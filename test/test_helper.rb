require "rubygems"
require "fileutils"

require File.expand_path("../lib/relay", File.dirname(__FILE__))
require File.expand_path("commands", File.dirname(__FILE__))

include Commands

ROOT = File.expand_path(File.join(File.dirname(__FILE__), ".."))

$:.unshift ROOT

def root(*args)
File.join(ROOT, *args)
end

prepare do
  Dir[root("test", "tmp", "*")].each do |file|
    FileUtils.rm(file)
  end
end

def relay(args = nil)
  sh("ruby #{root "bin/relay"} #{args}")
end
