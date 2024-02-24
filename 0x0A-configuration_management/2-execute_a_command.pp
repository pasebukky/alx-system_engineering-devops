# Use puppet to create a manifest that kills a process named killmenow

exec { 'killmenow':
  path    => '/usr/bin',
  command => 'pkill -SIGTERM killmenow',
  returns => [0, 1],
}
