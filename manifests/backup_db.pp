# Class: mongodb_mms::backup_db
#
# install mongodb for mms on premise backup.
#
#
class mongodb_mms::backup_db(
  $logpath           = '/data/backupdb/mongodb.log',
  $dbpath            = '/data/backupdb',
  $port              = 27018,
  $version           = '2.6.4-1')
{

  class { 'epel': }

  class { '::mongodb::globals':
    manage_package_repo => true,
    server_package_name => 'mongodb-org',
    bind_ip             => ['0.0.0.0'],
    version             => $version,
    require             => Class['epel']
  }->

  class {'::mongodb::server':
    auth    => false,
    verbose => true,
    port    => $port,
    logpath => $logpath,
    dbpath  => $dbpath,
    require => Class['::mongodb::globals']
  }->
  
#  file { $dbpath:
#    ensure  => directory,
#    owner   => $user,
#    group   => $user,
#    require => Class['::mongodb::server']
#  }
  
  # restart the mongod service dso authorization is now on 
  exec { 'service mongod restart':
    command => 'service mongod restart',
    timeout => 0,
    require =>  Class['::mongodb::server'],
  }
}

