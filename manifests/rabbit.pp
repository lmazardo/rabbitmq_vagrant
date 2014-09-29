Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class system-update {
  exec { 'apt-key present rabbit}':
    command => "/usr/bin/wget -q http://www.rabbitmq.com/rabbitmq-signing-key-public.asc -O -|/usr/bin/apt-key add -",
    unless  => "/usr/bin/apt-key list|/bin/grep -c 056E8E56",
  } -> file {'/etc/apt/sources.list.d/rabbitmq.list':
    content => 'deb http://www.rabbitmq.com/debian/ testing main',
  } -> exec { 'apt-get update':
    command => 'apt-get update',
  } -> file {'/etc/hosts':
    content => "
192.168.1.10 rabbit1
192.168.1.11 rabbit2
",
  }
}

class rabbit() {
  package {'rabbitmq-server':
    ensure => present,
    notify => Exec['purge first rabbit launch'],
  } -> file {'/var/lib/rabbitmq/.erlang.cookie':
    content => 'IDURWQDPCZHKVIFHXXOF',
    notify => Service['rabbitmq-server'],
  } -> file {'/etc/rabbitmq/rabbitmq.config':
    ensure => present,
    content => "[{rabbit, [{cluster_nodes, {['rabbit@rabbit1', 'rabbit@rabbit2'], disc}}]}].",
    notify => Service['rabbitmq-server'],
  }

  exec{ 'purge first rabbit launch':
    command => 'rabbitmqctl stop_app; rabbitmqctl reset; killall epmd beam; echo OK',
    refreshonly => true,
  } -> service{ 'rabbitmq-server':
    ensure => running,
  }
}

include rabbit

stage { 'first':
  before => Stage['main'],
}
class { 'system-update':
  stage => first,
}
