# generate script from template that queries the puppet database
define pdsh_puppet_list(String $label,
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
