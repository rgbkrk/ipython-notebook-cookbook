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
   Chef::Log.info("Creating profile \"#{new_resource.profile_name}\" for #{new_resource.owner}")
   create_profile(new_resource.ipython_path, new_resource.owner, new_resource.profile_name)
end

def create_profile(ipython_path, owner, profile_name)
   execute "ipython profile creation" do
      command "#{ipython_path} profile create #{profile_name}"
      user owner
   end
end
