#
# Cookbook Name:: route53
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'build-essential'

if node['platform_family'] == 'debian'
   xml = package "libxml2-dev" do
      action :nothing
   end
   xml.run_action( :install )

   xslt = package "libxslt1-dev" do
      action :nothing
   end
   xslt.run_action( :install )
elsif node['platform_family'] == 'rhel'
   xml = package "libxml2-devel" do
      action :nothing
   end
   xml.run_action( :install )

   xslt = package "libxslt-devel" do
      action :nothing
   end
   xslt.run_action( :install )
end

# because the constraint on mime-types is >= 0 it resolves to 3.0.0 
# which requires ruby 2.0 which conflicts with existing ruby 
# versions installed by omnibus for chef-client v 11.16.4
# so to fix this we download v 2.6.x of mime-types. 
chef_gem "mime-types" do 
  action :install 
  version node[:mime_types][:version] 
end 

# because the constraint on nokogiri is >= 1.5.11 it resolves to 1.7.0.1 
# which requires ruby 2.1 which conflicts with existing ruby 
# versions installed by omnibus for chef-client v 11.16
# so to fix this we download v 1.6.8.1 of nokogiri. 
chef_gem "nokogiri" do
  action :install
  version node[:nokogiri][:version]
end

Gem.clear_paths
require 'mime-types' 
require 'nokogiri' 

chef_gem "fog" do
  action :install
  version node['route53']['fog_version']
  retries 1 
end

#Gem.clear_paths
#require 'rubygems'
