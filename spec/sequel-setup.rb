Sequel.extension :migration

# Configure FakeWeb to mock requests to ElasticSearch
FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:any, %r|\Ahttp://localhost:9200|, :body => '{}')

# In-memory database
DB = Sequel.sqlite

# Add the table for TireSampleModel
DB.create_table(:tire_sample_models) do
  primary_key :id
  String :name
end

# Define TireSampleModel class for testing Sequel models with the Tire plugin
class TireSampleModel < Sequel::Model(DB)
  plugin :tire
end

# Create some sample data
rand(50..100).times do
  TireSampleModel.create :name => Faker::Lorem.word
end