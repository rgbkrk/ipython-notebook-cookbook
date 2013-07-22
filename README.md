# ipynb-cookbook

IPython notebook cookbook for deployment.

Make it easy, make it awesome.

# Requirements

 * [Berkshelf][]: `bundle install`
 * [Vagrant][] 1.1.0 and greater
 * Berkshelf plugin for Vagrant: `vagrant plugin install vagrant-berkshelf`

# Usage

## Bootstrap VirtualBox

    vagrant up

Once finished, the IPython notebook should be reach-able from your host (through port forwarding) on 127.0.0.1:8888.

# Attributes

# Recipes

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
