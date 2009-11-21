require "rubygems"
require "contest"
require "fileutils"
require File.join(File.dirname(__FILE__), "..", "lib", "relay")

ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

$:.unshift ROOT

require "test/commands"

class Test::Unit::TestCase
  include Test::Commands

  def root(*args)
    File.join(ROOT, *args)
  end

  def setup
    Dir[root("test", "tmp", "*")].each do |file|
      FileUtils.rm(file)
    end
  end

  def teardown
    Dir[root("test", "tmp", "*")].each do |file|
      FileUtils.rm(file)
    end
  end

  def relay(args = nil)
    sh("ruby -rubygems #{root "bin/relay"} #{args}")
  end
end
