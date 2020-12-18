# create pdsh files
class pdsh::generators (
  $puppetdb_host = 'puppetdb',
  $puppetdb_port = '8080',
  $output_dir    = '/etc/dsh/group',
  $endpoint      = 'nodes',
  $queries       = {},
  ) {
    #queries shoult be in the format:
    #{label => label, endpoint => endpoint, query=> query}
    #provides the parameters to fill out the queries hash more
    $query_defaults = {
      puppetdb_host => $puppetdb_host ,
      puppetdb_port => $puppetdb_port,
      output_dir    => $output_dir,
      endpoint      => $endpoint,
    }

    create_resources(pdsh_list,$queries,$query_defaults)
}

# generate script from template that queries the puppet database
define pdsh_list(String $label,
                        String $puppetdb_host,
                        String $puppetdb_port,
                        String $output_dir,
                        String $endpoint,
                        String $query,
  ) {
  file {"/usr/local/sbin/pdsh_list_${label}.rb":
    content => template('pdsh/pdsh_list_generator.rb.erb'),
    mode    => '0744',
    owner   => root,
    group   => root,
  }

  #cron to update list every 30
  cron { "update_pdsh_list_${label}":
    minute  => '*/30',
    command => "/usr/local/sbin/pdsh_list_${label}.rb > /dev/null 2>&1",
    user    => root,
  }
}
