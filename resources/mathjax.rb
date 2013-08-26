#
# Author:: Kyle Kelley <rgbkrk@gmail.com>
# Cookbook Name:: ipynb
# Resource:: mathjax
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

actions :create #, :delete, :create_if_missing
default_action :create if defined?(default_action)

# Default action for Chef <= 10.8
def initialize(*args)
   super
   @action = :create
end

attribute :install_dir
attribute :owner, :regex =>  Chef::Config[:user_valid_regex], :default => node[:ipynb][:linux_user]
attribute :ipython_path, :kind_of => String, :default => "#{node[:ipynb][:virtenv]}/bin/ipython"

