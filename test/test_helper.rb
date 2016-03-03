require 'simplecov'
SimpleCov.start do
    add_filter "/test/"
end

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rescodegen'

require 'minitest/autorun'
