Note: this is a very early stage of writing a puppet assertion module.
So enhance it while I sleep :)

## What?
It will provide a way to execute commands to check things during a puppet run.

I imagine a validate.pp or integration in site.pp where these are executed.
Maybe made optional by using tag => 'validation' or something. 
Todo on how stuff works

It would also be great if we can create a shared 'assertions' library that would work across operating systems.
Maybe reusing the logic in other providers to check the actual state without changing it.

## Usage

    $sitename = 'www.jedi.be'

    assert { "testing ${sitename} apache up":
      # fail, succeed
      ensure        => 'succeed',
      # true, false, onfailure, onsuccess
      logoutput    => true,
      exitcode     => 0,
      command      => 'nc -w 1 localhost 80',
      message      => 'hurray',
      fail_message => 'bollocks',
      action       => 'warning',
      fail_action  => 'fail'
    }

## Why do we need this?
Even though we work declarative, commands sometimes lie to puppet:

- A service might well say ok? But when you check it by hand it doesn't
- A config file syntax check might work great, but the webserver doesn't actually respond anymore.

## Why not just cucumber-nagios (or aruba)

1. I love those tools, but they require way to much gems and require people to write some ruby code sometimes.
Most people just know command execution
2. By executing this inside puppet, we can get access to the variables (hiera, extlookup etc..) , this would need to be duplicated in those other standalone tool.

## How is this differently from rspec-puppet?

Rspec-puppet only works on the catalog but does not run on the server, and you need the real checks for this.

## Why not a function
because functions run on the server, providers run on the client

## Doesn't use of this module imply bugs in puppet or your manifests that should be fixed?

## More ideas

have ensure => 'matches' or ensure => 'contains', ensure => 'equals' to do matches with output

## Inspiration
Using chef -minitests made me think of that. All kudos there

