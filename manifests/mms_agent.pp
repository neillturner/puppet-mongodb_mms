# Class: mongodb_mms::mms_agent
#
# install mongodb mms_agent for mms on premise.
#
#
class mongodb_mms::mms_agent(
  $version     = 'latest',
  $mmsBaseUrl  = 'http://127.0.0.1:8080',
)
{

  exec { 'download-mms-monitoring-agent':
    command => "curl -OL ${mmsBaseUrl}/download/agent/monitoring/mongodb-mms-monitoring-agent-${version}.x86_64.rpm",
    cwd     => '/tmp',
    creates => "/tmp/mongodb-mms-monitoring-agent-${version}.x86_64.rpm",
  }

  exec { 'install-mms-monitoring-agent':
    cwd     => '/tmp',
    creates => '/usr/bin/mongodb-mms-monitoring-agent',
    command => "rpm -U  \"/tmp/mongodb-mms-monitoring-agent-${version}.x86_64.rpm\"",
    require => Exec['download-mms-monitoring-agent'],
    timeout => 0
  }
  
  file { '/etc/init.d/mongodb-mms-monitoring-agent':
    content => template('mongodb_mms/mongodb-mms-monitoring-agent.erb'),
    mode    => '0755',
    require => Exec['install-mms-monitoring-agent'],
  }
  
  service { 'mongodb-mms-monitoring-agent':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    restart   => true,
    require   => File['/etc/init.d/mongodb-mms-monitoring-agent']
  }
  
}