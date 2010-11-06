#! /usr/bin/env ruby

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

class Relay
  VERSION = "0.1.0"

  def initialize
    @recipes = []
    @commands = []
  end

  def recipe(recipe)
    @recipes << recipe
  end

  def command(command)
    @commands << command
  end

  def run(servers)
    servers.each do |server|
      Ssh.new(server).start do |session|
        @commands.each do |command|
          session.run(command)
        end

        @recipes.each do |recipe|
          File.readlines(recipe).each do |command|
            session.run(command)
          end
        end
      end
    end
  end
end
