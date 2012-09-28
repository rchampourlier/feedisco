require 'rubygems'
require 'bundler'
Bundler.setup :default, :development

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "feedisco"
    gemspec.summary = "A simple feed discovery library"
    gemspec.description = "Feedisco is a small and lightweight library focused on RSS/Atom feed discovery. It is intended to do little, but to do it well!"
    gemspec.email = "romain@softr.li"
    gemspec.homepage = "http://github.com/rchampourlier/feedisco"
    gemspec.authors = ["romain@softr.li"]

    gemspec.add_dependency 'nokogiri'
  end

rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end