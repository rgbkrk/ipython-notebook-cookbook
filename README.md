# ipynb-cookbook

Sets up an IPython Notebook server using Chef.

Configuration/templating features will be coded towards IPython 1.0.0, which has not been released yet.

# Requirements
 * [Berkshelf][]: `gem install berks`
 * [Vagrant][] 1.2.4 or higher
 * Berkshelf plugin for Vagrant: `vagrant plugin install vagrant-berkshelf`
 * Omnibus plugin for Vagrant: `vagrant plugin install vagrant-omnibus`

# Usage

## Bootstrap VirtualBox

    vagrant up

Once finished, the IPython notebook can be accessed from your host machine (through port forwarding) on 127.0.0.1:9999.

# Attributes

See `attributes/default.rb` for default values. Most values including `:linux_user`, `:linux_group`, and `:service_name` default to `'ipynb'`.

Particularly important parameters for configuration of the notebook are located in `node[:ipynb][:NotebookApp]`.

If you're using the virtualenv recipe, you can either install more to the same virtualenv (`node[:ipynb][:virtenv]`) or add additional packages to `node[:ipynb][:extra_packages]`.

# Recipes

The `default` recipe simply installs (using system packages) IPython Notebook, numpy, Pandas, matplotlib, and all the dependencies for these.

The `simple_launch` recipe creates user and group *ipynb*, creates a spot to store notebooks, and sets up ipython notebook as a service using supervisord.

# Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature1`)
3. Commit your changes (`git commit -am 'Added new provider to ...'`)
4. Push to the branch (`git push origin feature1`)
5. Create a new Pull Request

# Author

Author:: Kyle Kelley (kyle.kelley@rackspace.com)

Copyright 2013, Rackspace Hosting

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[Vagrant]:http://vagrantup.com/
[Berkshelf]:http://berkshelf.com/
[Bundler]:http://gembundler.com/
