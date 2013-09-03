# IPython Notebook Cookbook

Sets up an IPython Notebook server using Chef.

This cookbook targets IPython 1.0.0 and will not deploy 0.x releases.

# Requirements

This cookbook uses Chef 11. Additionally, Berkshelf is recommended but not required.

## Requirements for Vagrant

 * [Berkshelf][]: `gem install berks`
 * [Vagrant][] 1.2.4 or higher
 * Berkshelf plugin for Vagrant: `vagrant plugin install vagrant-berkshelf`
 * Omnibus plugin for Vagrant: `vagrant plugin install vagrant-omnibus`

# Usage

## Include this cookbook

This cookbook isn't on opscode (yet), so for now you'll have to use Berkshelf and point to it in your Berksfile

```ruby
cookbook 'ipynb',
  :git => 'https://github.com/rgbkrk/ipynb-cookbook'
```

## Bootstrap VirtualBox

You can also try it out using Vagrant with VirtualBox.

    vagrant up

Once finished, the IPython notebook can be accessed from your host machine (through port forwarding) on 127.0.0.1:9999.

# Attributes

See `attributes/default.rb` for default values. Most values including `:linux_user`, `:linux_group`, and `:service_name` default to `'ipynb'`.

Particularly important parameters for configuration of the notebook are located in `node[:ipynb][:NotebookApp]`.

* `node[:ipynb][:NotebookApp][:password]` - Password to use when accessing the notebook. (Please use an encrypted data bag to set this attribute in a real deployment).

If you're using the virtualenv recipe, you can either install more to the same virtualenv (`node[:ipynb][:virtenv]`) or add additional packages to `node[:ipynb][:extra_packages]`.

# Recipes

The `default` recipe simply installs (using system packages) IPython Notebook, numpy, Pandas, matplotlib, and all the dependencies for these.

The `virtenv_launch` recipe creates user and group *ipynb*, creates a spot to store notebooks, and sets up ipython notebook as a service using supervisord.

The `proxy` recipe adds an nginx proxy to the notebook and requires you to set the certificate and key attributes.

* `node[:ipynb][:ssl_certificate]` - Location to install the SSL certificate (e.g. /etc/nginx/ssl.crt)
* `node[:ipynb][:ssl_certificate_text]` - Text for the SSL Certificate
* `node[:ipynb][:ssl_certificate_key]` - Location to install the SSL private key (e.g. /etc/nginx/ssl.key)
* `node[:ipynb][:ssl_certificate_key_text]` - Text for the SSL private key

On a real deployment, these should be set using an encrypted data bag.

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
