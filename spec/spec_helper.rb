$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'faker'
require 'fakeweb'
require 'sqlite3'
require 'sequel_tire'
require 'sequel'
require 'sequel-setup'

RSpec.configure do |config|

end