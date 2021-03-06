# Class: zabbix::server
#
#   This class manages the zabbix server.  The web UI will be available at
#   [Zabbix](http://monitor/zabbix) where monitor is the hostname of the
#   monitor machine.
#
#   This class has been developed and tested with Ubuntu Lucid LTS (10.04)
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class zabbix::server {
  $zabbix_server_service_status = "/bin/bash /etc/init.d/zabbix-server status"
  Package {
    ensure => present,
  }
  package { 'zabbix-server-mysql':
    notify  => Service['zabbix-server'],
    require => Class['zabbix'],
  }
  package { 'zabbix-frontend-php': }
  service { 'zabbix-server':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    status     => $zabbix_server_service_status,
  }
}
