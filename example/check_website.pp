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
