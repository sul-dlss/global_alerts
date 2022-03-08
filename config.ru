# frozen_string_literal: true

require "rubygems"
require "bundler"

Bundler.require :default, :development

Combustion.path = 'test/dummy'
Combustion.initialize! :all
run Combustion::Application
