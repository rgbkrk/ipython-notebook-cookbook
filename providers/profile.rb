#
# Author:: Kyle Kelley <rgbkrk@gmail.com>
# Cookbook Name:: ipynb
# Provider:: profile
#
# Copyright:: 2013, Rackspace
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :create do
   Chef::Log.info("Creating profile \"#{new_resource.name}\" for #{new_resource.owner}")
   Chef::Log.info("IPython path is at #{new_resource.ipython_path}")
   Chef::Log.info("IPython settings are at #{new_resource.ipython_settings_dir}")
   create_profile(new_resource.ipython_path, new_resource.owner,
                  new_resource.name, new_resource.ipython_settings_dir)
end

def create_profile(ipython_path, owner, name, ipython_settings_dir)
   bash "create_profile" do
      user owner
      group owner
      code <<-EOH
      #{ipython_path} profile create --profile=#{name} --ipython-dir #{ipython_settings_dir}
      EOH
      environment
   end
end

