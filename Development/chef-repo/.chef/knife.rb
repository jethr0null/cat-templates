# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

knife[:editor] = "/Users/michellesausa/local/bin/vim"


current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "mnikki137"
client_key               "#{current_dir}/mnikki137.pem"
validation_client_name   "mnikki137chefclass-validator"
validation_key           "#{current_dir}/mnikki137chefclass-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/mnikki137chefclass"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
