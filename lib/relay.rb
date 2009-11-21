#! /usr/bin/env ruby

require "thor"
require "open3"

class Ssh
  def initialize(server, quiet = false)
    @server = server
    @output = []
    @quiet = quiet
  end

  def start
    Open3.popen3("ssh -T #{@server}") do |stdin, stdout, stderr|
      threads = []

      @stdin, @stdout, @stderr = stdin, stdout, stderr

      threads << Thread.new do
        while line = stderr.gets
          $stderr.puts(line) unless @quiet
        end
      end

      threads << Thread.new do
        while line = stdout.gets
          @output << line
          $stdout.puts(line) unless @quiet
        end
      end

      yield(self)
      stdin.close
      threads.each {|t| t.join }
      @output
    end
  end

  def run(command)
    puts "\e[1m\e[33m$ #{command.strip}\e[0m" unless @quiet
    @stdin.puts(command)
  end
end

class Relay < Thor

  # If you require the relay library, you can issue commands
  # with the execute method:
  #
  # @example
  #
  #     >> require "relay"
  #     >> Relay.execute "echo foo", "myserver"
  #     => ["foo\n"]
  def self.execute(*args)
    start args.unshift("execute").push("--quiet")
  end

  desc "identify SERVER", "Copies your public key to a remote server"
  method_option :key, :type => :string, :aliases => "-k"
  method_option :path, :type => :string, :aliases => "-p"
  def identify(server)
    path = options[:path] || "~/.ssh/authorized_keys"
    keys = [options[:key], "~/.ssh/id_rsa.pub", "~/.ssh/id_dsa.pub"].compact
    key = keys.find { |k| File.exists?(File.expand_path(k)) }

    if system %Q{cat #{key} | ssh #{server} "cat >> #{path}"}
      say_status :copied, "#{key} to #{server}:#{path}"
    end
  end

  desc "recipe RECIPE SERVER", "Execute commands contained in RECIPE in the context of SERVER"
  def recipe(recipe, server)
    Ssh.new(server).start do |session|
      File.readlines(recipe).each do |command|
        session.run(command)
      end
    end
  end

  desc "execute COMMAND SERVER", "Execute COMMAND in the context of SERVER"
  method_option :quiet, :type => :boolean, :aliases => "-q"
  def execute(command, server)
    Ssh.new(server, options[:quiet]).start do |session|
      session.run(command)
    end
  end
end
