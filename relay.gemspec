Gem::Specification.new do |s|
  s.name              = "relay"
  s.version           = "0.0.2"
  s.summary           = "Relay commands over SSH"
  s.description       = "Relay allows you to execute remote commands via SSH with ease."
  s.authors           = ["Damian Janowski", "Michel Martens"]
  s.email             = ["djanowski@dimaion.com", "michel@soveran.com"]
  s.homepage          = "http://github.com/soveran/relay"

  s.rubyforge_project = "relay"

  s.executables << "relay"

  s.add_dependency("thor", "~> 0.11")

  s.files = ["LICENSE", "README.markdown", "Rakefile", "bin/relay", "lib/relay.rb", "relay.gemspec", "test/commands.rb", "test/relay_test.rb", "test/test_helper.rb"]
end
