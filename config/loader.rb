ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup'
#
Bundler.require(:default)

# Require files from lib
Dir["./lib/*.rb"].each {|file| require file }