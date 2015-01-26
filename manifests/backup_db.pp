# Class: mongodb_mms::backup_db
#
# install mongodb for mms on premise backup.
#
#
class mongodb_mms::backup_db(
  $logpath  = '/var/log/mongodb/mongodb.log',
  $dbpath   = '/var/lib/mongodb',
  $dbparent = '/data',
  $port     = 27017,
  $version  = '2.6.4-1',)
#  $user     = 'mongod',
#  $group    = 'mongod')
{

  class { 'epel': }

  class { '::mongodb::globals':
    manage_package_repo => true,
    server_package_name => 'mongodb-org',
    #bind_ip            => ['127.0.0.1','192.168.33.16'],
    bind_ip             => ['0.0.0.0'],
    version             => $version,
    require             => Class['epel']
  }

  class {'::mongodb::server':
    auth    => false,
    verbose => true,
    logpath => $logpath,
    dbpath  => $dbpath,    
    port    => $port,
    require => Class['::mongodb::globals']
  }
  
  class {'::mongodb::client':
    require => Class['::mongodb::server']
  }

}
