# frozen_string_literal: true
require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'params_corrector'
require 'name_alterer'
require 'path_processor'
