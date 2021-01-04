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

    create_resources(pdsh_puppet_list,$queries,$query_defaults)
}

