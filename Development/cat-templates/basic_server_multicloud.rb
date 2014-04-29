name "Multi-Cloud Linux Server"
rs_ca_ver 20131202
short_description "![logo](http://assets.rightscale.com/69d7cf43d5f89965c1676fe604af36987aada5da/web/images/icons/home7.png) Standalone Linux server for AWS and Azure."
long_description "This basic server will stand up a vanilla server with only the required security 
updates and auditing software installed.

### Available Clouds ###
* AWS (East and West US)
* MS Azure (East and West US)
* vSphere (limited options)

### Available OSs ###
* Ubuntu 12.04
* CentOS 6.5


### Instance Sizes ###
* 2x cores, 3.5GB RAM (c3.large/A2-medium)
* 4x cores, 7GB RAM (c3.xlarge/A3-large)
* 8x cores, 14GB RAM (c3.2xlarge/A4-xlarge)
* 4x cores, 28GB RAM (i2.xlarge/A6)

"

#########
# Parameters
#########

# Cloud
parameter "cloud" do
  type "string"
  label "Cloud"
  category "Resource pool"
  allowed_values "AWS East Coast", "AWS West Coast", "MS Azure East", "MS Azure West", "vSphere"
  default "AWS West Coast"
  description "The cloud that the server will launch in"
end

# Instance Size

parameter "instance_size" do
  type "string"
  label "Instance Size"
  category "Resource pool"
  allowed_values "2x cores, 3.5GB RAM",  "4x cores, 7GB RAM", "8x cores, 14GB RAM", "4x cores, 28GB RAM"
  default "2x cores, 3.5GB RAM"
  description "Choose the general instance size to use. N/A for vSphere."
end

# Operating System

parameter "operating_system" do
  type "string"
  label "Operating System Distro"
  category "Operating System"
  allowed_values "Ubuntu 12.04", "CentOS 6.5"
  default "Ubuntu 12.04"
  description "Choose the OS you'd like to use. N/A for vSphere."
end



#########
# Mappings
#########

mapping "os_mapping" do {
  "Ubuntu 12.04" => {
  	"mci_name" => "RightImage_Ubuntu_12.04_x64_v13.5",
  	"mci_rev"  => "33"}, 
  "CentOS 6.5" => {
  	"mci_name" => "RightImage_CentOS_6.4_x64_v13.5",
  	"mci_rev"  => "43"},  
  "RHEL 6.5" => {
  	"mci_name" => "RightImage_RHEL_6.4_x64_v13.5_EBS",
  	"mci_rev"  => "10"}
}
end

mapping "cloud_mapping" do {
  "AWS East Coast" => {
    "cloud_name" => "EC2 us-east-1",
    "ssh_key_href" => "/api/clouds/1/ssh_keys/DU5BU7B472NAU"
    },
  "AWS West Coast" => {
    "cloud_name" => "EC2 us-west-2",
    "ssh_key_href" => "/api/clouds/6/ssh_keys/CBNF5UA7SLHQ4"
    }, 
  "MS Azure East" => {
    "cloud_name" => "Azure East US",
    }, 
  "MS Azure West" => {
    "cloud_name" => "Azure West US",
  }
}
end

# mapping "instance_mapping" do {

# "1x 2.6Ghz, 3.75GB RAM" => {
# 	"instance_type" => "m3.medium" },
# "2x 2.6Ghz, 7.5 GB RAM" => {
# 	"instance_type" => "m3.large" }, 
# "2x 2.8Ghz, 3.75GB RAM" => {
# 	"instance_type" => "c3.large" }, 
# "8x 2.8Ghz, 15GB RAM" => {
# 	"instance_type" => "c3.2xlarge" }, 
# "4x 2.6Ghz, 34.2GB RAM" => {
# 	"instance_type" => "m2.2xlarge" },
# "8x 2.5Ghz, 61GB RAM" => {
# 	"instance_type" => "i2.2xlarge" }
# }
# end
# For now, use cloud-specific hrefs instead of nice names
### Instance Sizes ###
#* 2x cores, 3.5GB RAM (c3.large/A2-medium)
#* 4x cores, 7GB RAM (c3.xlarge/A3-large)
#* 8x cores, 14GB RAM (c3.2xlarge/A4-xlarge)
#* 4x cores, 28GB RAM (i2.xlarge/A6)



mapping "instance_mapping" do {

  "2x cores, 3.5GB RAM" => {
    "AWS West Coast" => "/api/clouds/6/instance_types/554HVRSGECIC6",
    "AWS East Coast" => "/api/clouds/1/instance_types/5LLVV5K17FN96",
    "MS Azure East" => "/api/clouds/2179/instance_types/BB7GSHCR18B4D",
    "MS Azure West" => "/api/clouds/2178/instance_types/F894PR79927HV" 
  },
    "4x cores, 7GB RAM" => {
    "AWS West Coast" => "/api/clouds/6/instance_types/E2IKLRTRMIP4J",
    "AWS East Coast" => "/api/clouds/1/instance_types/77G0D0323Q144",
    "MS Azure East" => "/api/clouds/2179/instance_types/7M3RBT2GI377A",
    "MS Azure West" => "/api/clouds/2178/instance_types/1SQ12LL45K2Q0" 
  },
  "8x cores, 14GB RAM" => {
    "AWS West Coast" => "/api/clouds/6/instance_types/OHSORES44NHT",
    "AWS East Coast" => "/api/clouds/1/instance_types/9VHMKIO2M1I44",
    "MS Azure East" => "/api/clouds/2179/instance_types/E5OHMGF8NH467",
    "MS Azure West" => "/api/clouds/2178/instance_types/6RPUB8DOEC7Q0" 
  },
  "4x cores, 28GB RAM" => {
    "AWS West Coast" => "/api/clouds/6/instance_types/CML23G8I1419N",
    "AWS East Coast" => "/api/clouds/1/instance_types/F0G9U8ETA9V2P",
    "MS Azure East" => "/api/clouds/2179/instance_types/BETA0CTN649VU",
    "MS Azure West" => "/api/clouds/2178/instance_types/B6FUNQVI5FTKR" 
  },
}

end

#########
# Conditions
#########

condition "aws" do
  logic_or( equals?($cloud, "AWS West Coast"), equals?($cloud, "AWS East Coast"))
end

condition "azure" do
  logic_or( equals?($cloud, "MS Azure East"), equals?($cloud, "MS Azure West"))
end

condition "vsphere" do
  equals?($cloud, "vSphere")
end


#########
# Resources
#########

resource 'base_server_azure', type: 'server' do
  name "base_server"
  cloud map( $cloud_mapping, $cloud, "cloud_name")
  #cloud 'AWS US-Oregon' # Not working because of the name discrepency SS-40
  instance_type_href map( $instance_mapping, $instance_size, $cloud)
  #instance_type map( $instance_mapping, $instance_size, 'instance_type')  # SS-41
  #ssh_key "default" # doesnt work SS-44
  server_template find('Base ServerTemplate for Linux (v13.5)', revision: 154)
  multi_cloud_image find( map( $os_mapping, $operating_system, "mci_name"), revision: map( $os_mapping, $operating_system, "mci_rev"))

  condition $azure
end

resource "base_server_aws", type: 'server' do
  like @base_server_azure
  condition $aws
  ssh_key_href  map( $cloud_mapping, $cloud, "ssh_key_href")

end

resource 'base_server_vsphere', type: 'server' do
  name "base_server"
  cloud_href '/api/clouds/2705'
  datacenter_href '/api/clouds/2705/datacenters/21TO688TOOMPH'
  subnet_hrefs '/api/clouds/2705/subnets/5EB5OL2P137L4'
  server_template_href '/api/server_templates/327643003'
  condition $vsphere
end

