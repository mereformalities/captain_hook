$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'captain_hook'
require 'spec'
require 'spec/autorun'

require 'rubygems'
require 'grit'
Spec::Runner.configure do |config|
  
end
