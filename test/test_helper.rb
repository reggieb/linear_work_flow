$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'linear_work_flow'
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]