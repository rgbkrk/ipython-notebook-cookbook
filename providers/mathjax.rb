#
# Author:: Kyle Kelley <rgbkrk@gmail.com>
# Cookbook Name:: ipynb
# Provider:: mathjax
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
   Chef::Log.info("Installing mathjax to \"#{new_resource.name}\" for #{new_resource.owner}")
   Chef::Log.info("IPython path is at #{new_resource.ipython_path}")
   install_mathjax(new_resource.ipython_path, new_resource.owner, new_resource.name)
end

def install_mathjax(ipython_path, owner, name)

   python "install_mathjax" do
       user owner
       group owner
       cwd node[:ipynb][:home_dir]

       environment "HOME" => node[:ipynb][:home_dir],
                   "SHELL" => "/bin/bash",
                   "USER" => node[:ipynb][:linux_user],
                   "PATH" => "#{node[:ipynb][:virtenv]}/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games",
                   "VIRTUAL_ENV" => "#{node[:ipynb][:virtenv]}"

       code <<-EOH
import os
from IPython.external.mathjax import install_mathjax
from IPython.utils.path import locate_profile
dest = os.path.join(locate_profile('#{name}'), 'static', 'mathjax')
install_mathjax(replace=True, dest=dest)
       EOH
   end

end

