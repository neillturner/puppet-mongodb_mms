# Class: mongodb_mms::monitoring_agent
#
# install mongodb monitoring_agent for mms on premise.
#
#
class mongodb_mms::monitoring_agent(
  $mmsApiKey   = '',
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
  

  file { '/etc/mongodb-mms/monitoring-agent.config':
    content => template('mongodb_mms/monitoring-agent.config.erb'),
    owner   => 'mongodb-mms-agent',
    group   => 'mongodb-mms-agent',
    mode    => '0600',
    require => Exec['install-mms-monitoring-agent'],
  }
  
  service { 'mongodb-mms-monitoring-agent':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    restart   => true,
    require   => File['/etc/mongodb-mms/monitoring-agent.config']
  }  
  
 
}