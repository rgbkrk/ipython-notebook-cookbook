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

```ruby
# User and group for IPython
default[:ipynb][:user] = "ipynb"
default[:ipynb][:group] = "ipynb"

# Home directory for the user
default[:ipynb][:home_dir] = "/home/ipynb/"

# Spot to store the notebook files
default[:ipynb][:notebook_dir] = File.join(default[:ipynb][:home_dir], "notebooks")

# Port to host on
default[:ipynb][:port] = 8888

# Where to store the virtual environment IPython runs in
default[:ipynb][:virtenv] = File.join(default[:ipynb][:home_dir], "ipyvirt")

# Version of Python to use
default[:ipynb][:py_version] = "python2.7"

# The scientific computing stack, installed in order
# Note that numpy must be first and the dependencies for matplotlib also have
# to start first due to the way numpy+matplotlib are packaged
default[:ipynb][:scientific_stack] = ["numpy", "freetype-py", "PIL",
                                      "python-dateutil", "pytz==2013b", "six",
                                      "scipy", "pandas", "matplotlib"]

# All the dependencies for IPython + IPython notebook
default[:ipynb][:ipython_packages] = ["tornado", "pyzmq", "statsmodels", "ipython" ]

# Additional packages to install into the same virtualenv as the IPython notebook
default[:ipynb][:extra_packages] = []

```

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
