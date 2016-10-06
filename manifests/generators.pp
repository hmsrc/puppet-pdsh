class pdsh::generators (
  $puppetdb_host = 'puppetdb',
  $puppetdb_port = '8080',
  $output_dir = '/etc/dsg/group',
  $queries = {},
  ) {

    #provides the parameters to fill out the queries hash more
    $query_defaults = {
      puppetdb_host => $puppetdb_host ,
      puppetdb_port => $puppetdb_port,
      output_dir    => $output_dir,
    }

    create_resources(pdsh_puppet_list,$queries,$query_defaults)
}

define pdsh_puppet_list($name,$puppetdb_host,$puppetdb_port,$output_dir,$query) {
  file {"/usr/local/sbin/pdsh_list_${name}.rb":
    content => template('pdsh/pdsh_list_generator.rb.erb'),
    mode    => '0744',
    owner   => root,
    group   => root,
  }

  #cron to update list every 30
  cron { "update_pdsh_list_${name}":
    minute  => '*/30',
    command => "/usr/local/sbin/pdsh_list_${name}.rb > /dev/null 2>&1",
    user    => root,
  }
}
