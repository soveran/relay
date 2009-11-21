require File.join(File.dirname(__FILE__), "test_helper")

class TestRelay < Test::Unit::TestCase
  context "relay identify SERVER" do
    should "copy the public key to SERVER" do
      Dir.chdir(root("test", "tmp")) do
        out, err = relay("identify localhost --path #{root("test", "tmp", "authorized_keys")}")

        assert_match /copied/, out
        assert File.exists?("authorized_keys")
        assert File.read("authorized_keys")[/^ssh-/]
      end
    end

    should "send a command to SERVER" do
      Dir.chdir(root("test", "tmp")) do
        FileUtils.touch("foobar")

        out, err = relay("execute \"ls #{root("test", "tmp")}\" localhost")

        assert_match /foobar/, out
      end
    end

    should "relay a recipe of commands to SERVER" do
      Dir.chdir(root("test", "tmp")) do
        File.open("recipe.sh", "w") do |file|
          file.puts "cd #{root("test", "tmp")}"
          file.puts "ls -al > list"
          file.puts "cat list"
        end

        out, err = relay("recipe.sh localhost")

        assert out["$ cd #{root("test", "tmp")}"]
        assert out["$ ls -al > list"]
        assert out["$ cat list"]
        assert out["recipe.sh"]
      end
    end
  end
end
