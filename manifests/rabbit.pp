Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class system-update {
  exec { 'apt-get update':
    command => 'apt-get update',
  }
}

class rabbit() {
  package {'rabbitmq-server':
    ensure => present,
  }
  service { 'rabbitmq-server':
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


