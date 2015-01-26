# Class: mongodb_mms::backup_db
#
# install mongodb for mms on premise backup.
#
#
class mongodb_mms::backup_db(
  $logpath           = '/data/backupdb/mongodb.log',
  $dbpath            = '/data/backupdb',
  $port              = 27017,
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
  
 class {'::mongodb::client':
    require => Class['::mongodb::server']
  }
}

