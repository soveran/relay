require "open3"
require "socket"

module Commands
  def sh(cmd)
    out, err = nil

    Open3.popen3(cmd) do |_in, _out, _err|
      out = _out.read
      err = _err.read
    end

    [out, err]
  end
end
