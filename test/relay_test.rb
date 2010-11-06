require File.expand_path("test_helper", File.dirname(__FILE__))

scope do
  scope do
    test "send a command to SERVER" do
      Dir.chdir(root("test", "tmp")) do
        FileUtils.touch("foobar")

        out, err = relay("-c \"ls #{root("test", "tmp")}\" localhost")

        assert out[/foobar/]
      end
    end

    test "relay a recipe of commands to SERVER" do
      Dir.chdir(root("test", "tmp")) do
        File.open("recipe.sh", "w") do |file|
          file.puts "cd #{root("test", "tmp")}"
          file.puts "ls -al > list"
          file.puts "cat list"
        end

        out, err = relay("-f recipe.sh localhost")

        assert out["$ cd #{root("test", "tmp")}"]
        assert out["$ ls -al > list"]
        assert out["$ cat list"]
        assert out["recipe.sh"]
      end
    end
  end
end
