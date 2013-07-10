require 'rubygems'
require 'sequel'
require 'tire'
require 'sequel_tire/version'

module Sequel
  module Plugins
    module Tire

      module ::Tire::Tasks::Import
        alias_method :__original_add_pagination_to_klass, :add_pagination_to_klass

        def add_pagination_to_klass(klass)
          if klass.ancestors.include? Sequel::Model
            klass.instance_eval do
              def paginate(options = {})
                self.limit(options[:per_page], (options[:page] - 1) * options[:per_page]).all
              end
            end
          else
            __original_add_pagination_to_klass(klass)
          end
        end
      end

      module ::Tire::Model::Search::Loader
        alias_method :__original_tire_load, :load

        # If the model is a Sequel::Model then load it using sequel, otherwise fall back to Tire's load method
        def load(options=nil)
          if self.class.ancestors.include? Sequel::Model
            self.class.find(self.class.primary_key => self.id)
          else
            __original_tire_load(options)
          end
        end
      end

      class PaginationStrategy
        attr_reader :klass, :options, :index

        def initialize(klass, options={})
          @klass = klass
          @options = {:per_page => 1000}.update(options)
          @index = options[:index] ? Tire::Index.new(options.delete(:index)) : klass.tire.index
        end

        def import(&block)
          count = 0
          while count < klass.count
            items = klass.limit(options[:per_page], count).all
            index.import items, options, &block
            count += items.size
          end
          self
        end
      end

      def self.apply(model, options={})
        model.include(::Tire::Model::Search)

        #::Tire::Model::Search::Results::Item.send :include, ::Tire::Model::Search::Loader

        # Reopen the model class to override the search method
        class << model
          alias_method :__original_tire_search, :search

          def search(*args, &block)
            results = __original_tire_search(*args, &block)
            results.instance_eval do
              def __find_records_by_ids(klass, ids)
                klass.where(klass.primary_key => ids).all
              end
            end
            results
          end

          # Return a Sequel dataset object to perform further manipulations if need be
          def query(*args, &block)
            results = search(*args, &block)
            where(self.primary_key => results.map(&:id))
          end
        end

      end

      module ClassMethods
        def import(options={}, &block)
          strategy = PaginationStrategy.new(self, options)
          strategy.import(&block)
        end
      end

      module InstanceMethods
        def after_commit
          super
          self.index.store self
        end

        def after_destroy_commit
          super
          self.index.remove self
        end
      end
    end
  end
end