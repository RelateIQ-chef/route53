default['build_essential']['compiletime'] = true

chef_version = `chef-client -v`.strip.split(':')[1].to_f
if chef_version < 12
  default[:route53][:fog_version] = '1.5.0'
else
  default[:route53][:fog_version] = '1.11.0'
end

default[:mime_types][:version]  = '1.25.1'
default[:nokogiri][:version]  = '1.5.11'
default[:public_suffix][:version] = '3.1.1'
default[:launchy][:version] = '2.4.3'
