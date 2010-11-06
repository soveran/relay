Relay
=====

Relay commands over SSH.

Description
-----------

Relay is a simple library that allows you to send commands over SSH.
It uses your own SSH, not a Ruby version, so you can profit from your
settings and public/private keys.

The following options are available:

    -c command
        Executes the command on the passed servers.

    -f recipe
        Reads commands from a file and executes them in the passed servers.

Usage
-----

To send a command to two servers called `server1` and `server2`:

    $ relay -c "ls -al" server1 server2
    $ relay -c "cd foo; ls" server1 server2
    $ relay -c "cd foo" -c "ls" server1 server2

If you want to send more commands, you can write a shell script:

    $ cat recipe.sh
      cd foo
      ls
      mkdir -p bar/baz

    $ relay -f recipe.sh server1 server2

It will execute those commands on both servers and show the output.


You can use each flag many times, so this is possible:

    $ relay -f recipe1.sh -f recipe2.sh server1 server2 server3

Installation
------------

    $ gem install relay

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
