Relay
=====

Relay commands over SSH.

Description
-----------

Relay is a simple library that allows you to send commands over SSH.
It uses your own SSH, not a Ruby version, so you can profit from your
settings and public/private keys.

Usage
-----

To send a command to a server called `myserver`:

    $ relay execute "ls -al" myserver
    $ relay execute "cd foo; ls" myserver

If you want to send more commands, you can write a shell script:

    $ cat recipe.sh
      cd foo
      ls
      mkdir -p bar/baz

    $ relay recipe.sh myserver

It will execute those commands on `myserver` and show the output.

This last form accepts one file as the recipe and one or many servers:

    $ relay recipe.sh server1 server2 server3

You can also add your public key to a remote server's authorized keys file:

    $ relay identify myserver

Relay exposes the `execute` method, which returns the output of the command:

    >> require "relay"
    >> Relay.execute "echo foo", "myserver"
    => ["foo\n"]

Installation
------------

    $ sudo gem install relay

License
-------

Copyright (c) 2009 Michel Martens and Damian Janowski

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
