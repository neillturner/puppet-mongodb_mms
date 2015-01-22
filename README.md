puppet-mongodb_mms
==================

Install and Manage MongoDB MMS On Premise

See: 
http://mms.mongodb.com/help-hosted/v1.5/tutorial/install-on-prem-quick-start/
http://mms.mongodb.com/help-hosted/v1.5/tutorial/nav/install-on-prem/

This is a minumum first version. 
It relies on puppet module puppetlabs/mongodb to install the mongodb database.
The mms application and mms mongodb database can be installed on one server.
The backup database should be installed on another server.

TO DO:
     Add support for replica sets
     Add support for monitoring agents
     Add support for backup agents 

Minimal Usage: 
=============

TO COME:
 

Detailed Usage:
===============

       class { 'mongodb_mms::application_db':
         logpath      => '/data/mmsdb/mongodb.log',
         dbpath       => '/data/mmsdb'
       }
       
       class { 'mongodb_mms::application':
         version               => '1.5.3.182-1',
         https_proxy           => '',
         mms_host              => '127.0.0.1',
         from_email_addr       => 'mms-admin@example.net',
         reply_to_email_addr   => 'mms-admin@example.net',
         admin_from_email_addr => 'mms-admin@example.net',
         admin_email_addr      => 'mms-admin@example.net',
         mail_hostname         => '127.0.0.1',
         mail_port             => 25,  
         aws_accesskey         => '',
         aws_secretkey         => '',
         db_host               => '127.0.0.1',
         db_port               => '27017',
         user                  => 'mongodb-mms',
         group                 => 'mongodb-mms',
         require               => Class['mongodb_mms::application_db'] 
  }
  
