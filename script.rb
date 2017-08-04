#! /usr/bin/env ruby

require 'json'
puts "Using json version #{JSON::VERSION}"

puts ({:greeting => 'Hello, world!'}.to_json)
