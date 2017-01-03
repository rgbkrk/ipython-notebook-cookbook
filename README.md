# IPython Notebook Cookbook

Sets up an IPython Notebook server using Chef.

This cookbook targets Jupyter/IPython 4.x environment.

CAUTION: This cookbook now (Jan, 2017) defaults to using Jupyter and IPython versus the old 
monolithic IPython stack. While testing has been performed, if you are dependent on the 
old behavior, you should use the V1.1.1 tagged release of this cookbook.

# Requirements

This cookbook uses Chef 12.1+.

# Usage

## Include this cookbook

This cookbook isn't on supermarket (yet), so for now you'll have to use Berkshelf and point to it in your Berksfile

```ruby
cookbook 'ipynb', github: 'rgbkrk/ipynb-cookbook'
```

## Bootstrap VirtualBox

You can also try it out using test-kitchen.

    test-kitchen converge ubuntu-16

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

# Future Directions

This cookbook satisfies the needs of the current collaborators. To do items include:
- Supporting non-Ubuntu platforms (Amazon, Centos, etc.)
- Support for non-IPython kernels (Rstats)
- Submission to Supermarket
- CI testing

Contributions are most welcome!

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
