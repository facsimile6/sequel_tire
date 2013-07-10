# sequel_tire

Sequel plugin for patching Sequel::Model to work with Tire::Model

## Installation

Add this line to your application's Gemfile:

    gem 'sequel_tire', :git => 'https://github.com/facsimile6/sequel_tire'

And then execute:

    $ bundle

## Usage

Define Sequel::Model classes as usual and add the tire plugin.


    class TireSampleModel < Sequel::Model(DB)
      plugin :tire
    end

See [Tire documentation](https://github.com/karmi/tire) for more specific usage details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
