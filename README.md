# ipynb-cookbook

Sets up an IPython Notebook server using Chef.

# Requirements
 * [Berkshelf][]: `gem install berks`
 * [Vagrant][] 1.1.0 and greater
 * Berkshelf plugin for Vagrant: `vagrant plugin install vagrant-berkshelf`

# Usage

## Bootstrap VirtualBox

    vagrant up

Once finished, the IPython notebook can be accessed from your host machine (through port forwarding) on 127.0.0.1:8888.

# Attributes

```ruby
default[:ipynb][:user] = "ipynb"
default[:ipynb][:group] = "ipynb"
default[:ipynb][:home_dir] = "/home/ipynb/"
default[:ipynb][:notebook_dir] = File.join(default[:ipynb][:home_dir], "notebooks")
default[:ipynb][:port] = 8888
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

Author:: Kyle Kelley rgbkrk@gmail.com

[Vagrant]:http://vagrantup.com/
[Berkshelf]:http://berkshelf.com/
[Bundler]:http://gembundler.com/
