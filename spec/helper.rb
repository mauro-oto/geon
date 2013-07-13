$:.push File.expand_path('../lib', __FILE__)

require "rspec"
require 'geon'

require 'config'
$specs_dir = File.dirname(__FILE__)

def sample(name)
  IO.read ("#{$specs_dir}/samples/#{name}")
end