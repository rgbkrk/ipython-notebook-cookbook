################################################################################
#
# IPython Notebook Cookbook Default Attributes
#
################################################################################

################################################################################
# Server side configuration
################################################################################

# user and group for the system IPython is being deployed to
default['ipynb']['linux_user'] = 'ipynb'
default['ipynb']['linux_group'] = 'ipynb'

# Home directory for the system user
default['ipynb']['home_dir'] = nil # File.join('/home/', default['ipynb']['linux_user'])

# Spot to store the notebook files
default['ipynb']['notebook_dir'] = nil # File.join(default[:ipynb][:home_dir],
#                                        "notebooks")

# Service name
default['ipynb']['service_name'] = 'jupyter'

# IPython profile
default['ipynb']['profile_name'] = 'cooked'

default['ipynb']['proxy']['enable'] = true
default['ipynb']['proxy']['hostname'] = fqdn
default['ipynb']['proxy']['alias_hostnames'] = []

default['nginx']['default_site_enabled'] = false

default['nginx']['version'] = '1.10.2'
default['nginx']['source']['version'] = '1.10.2'
# The Chef checksum of a binary is determined by: shasum -a 256 FILE_NAME
default['nginx']['source']['checksum'] = '1045AC4987A396E2FA5D0011DAF8987B612DD2F05181B67507DA68CBE7D765C2'
default['nginx']['source']['prefix'] = "/opt/nginx-#{node['nginx']['source']['version']}"
default['nginx']['source']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['sbin_path'] = "#{node['nginx']['source']['prefix']}/sbin/nginx"

default['nginx']['source']['default_configure_flags'] = [
  "--prefix=#{node['nginx']['source']['prefix']}",
  "--conf-path=#{node['nginx']['dir']}/nginx.conf",
  "--sbin-path=#{node['nginx']['source']['sbin_path']}",
]
node.default['nginx']['init_style'] = 'runit'

################################################################################
# IPython Notebook runtime configuration
################################################################################

# IP to host on, defaults to all interfaces
default['ipynb']['NotebookApp']['ip'] = '127.0.0.1'

# Port to host on
default['ipynb']['NotebookApp']['port'] = 8888

# Choose whether to open a browser, default is server mode (no browser run on
# server -- interact on client)
default['ipynb']['NotebookApp']['open_browser'] = 'False'

# SSL Certificate file (private), should be the absolute path of the PEM file
# you want to use.
#
# Example for self-generating:
#
#   openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out \
#   mycert.pem
#
# Can acquire a signed certificate by following this tutorial, through StartSSL:
#
#   http://arstechnica.com/security/news/2009/12/how-to-get-set-with-a-
#
default['ipynb']['ssl_certificate'] = nil
default['ipynb']['ssl_certificate_text'] = nil
default['ipynb']['ssl_certificate_key'] = nil
default['ipynb']['ssl_certificate_key_text'] = nil

# Hashed Password with Salt, Algorithm for accessing the Jupyter Notebook
#
# You can generate one using notebook.auth.passwd
#
#     In [1]: from notebook.auth import passwd
#
#     In [2]: passwd()
#     Enter password:
#     Verify password:
#     Out[2]: 'sha1:47850f246447:2886935dc08e949f84aeaa41c0030d95253b61b3'
#
# The structure of the result is ALGORITHM:SALT:HASH.
#
# Roughly speaking the password is converted to UTF-8 (when in Python 2.7) using
# string.encode
#
# >>> user_password = "IPassword"
# >>> normalized_password = user_password.encode("utf-8", "replace")
# >>> # Python 3 encodes the salt to ascii (it remains the same for Python 2.7)
# >>> normalized_salt = salt.encode("ascii")
# >>> h = hashlib.new(algorithm) # e.g. sha1
# >>> h.update(normalized_password + normalized_salt)
#
# In [10]: passwd("IPassword")
# Out[10]: 'sha1:7f4bcfc8850f:eb4a986083f011b8f7a2604265a7282b74964dc2'
#
# In [11]: h = hashlib.new("sha1"); h.update("IPassword".encode("utf-8","replace")+"7f4bcfc8850f"); h.hexdigest()
# Out[11]: 'eb4a986083f011b8f7a2604265a7282b74964dc2'
#
# Default shown here is "IPassword" (without the quotes)
# 'sha1:f918d238efbd:4a250470288eb6a41f5df648a39f82606cbd33dd'
#
default['ipynb']['NotebookApp']['password_hash'] = nil

# Token for authenticating first connections to the server
# Only used if password_hash is set to nil
# Setting both password_hash and token to nil disables auth
# THIS IS NOT ADVISED!
default['ipynb']['NotebookApp']['token'] = 'IPassword'

# Landing page settings
default['ipynb']['NotebookApp']['base_project_url'] = nil
default['ipynb']['NotebookApp']['base_kernel_url'] = nil
default['ipynb']['NotebookApp']['webapp_settings']['static_url_prefix'] = nil

# Any additional configuration for Notebooks, to complete
# jupyter_notebook_config.py ruby template
default['ipynb']['NotebookApp']['additional_config'] = nil

################################################################################
# Virtualenv
################################################################################

# Where to store the virtual environment IPython runs in
default['ipynb']['virtenv'] = nil # File.join(default['ipynb']['home_dir'], '.ipyvirt')

# Version of Python to use
default['ipynb']['py_version'] = case node['platform_version'].to_f
                                 when 16.04
                                   '3.5'
                                 when 14.04
                                   '3.4'
                                 else
                                   '3.5'
                                 end

################################################################################
# Software Stack (system packages)
################################################################################

# System packages, at least for Ubuntu (naming may change)
default['ipynb']['system_packages'] = case node['platform_version'].to_f
                                      when 16.04
                                        %w(
                                          libcurl4-openssl-dev libssl-dev zlib1g-dev libpcre3-dev
                                          gfortran libblas-dev liblapack-dev libncurses5-dev
                                          libatlas-base-dev libscalapack-openmpi1 libscalapack-pvm1
                                          libjpeg-turbo8 libjpeg8
                                          libpng12-0 libpng12-dev
                                          libfreetype6 libfreetype6-dev git-core
                                          libhdf5-serial-dev pandoc
                                        )
                                      when 14.04
                                        %w(
                                          libcurl4-openssl-dev libssl-dev zlib1g-dev libpcre3-dev
                                          gfortran libblas-dev libblas3gf liblapack3gf liblapack-dev libncurses5-dev
                                          libatlas-dev libatlas-base-dev libscalapack-mpi1 libscalapack-pvm1
                                          liblcms-utils
                                          libamd2.3.1 libjpeg-turbo8 libjpeg8 liblcms1 libumfpack5.6.2
                                          libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
                                          git-core
                                          libhdf5-7 libhdf5-serial-dev
                                          pandoc
                                        )
                                      else
                                        %w(
                                          libcurl4-openssl-dev libssl-dev zlib1g-dev libpcre3-dev
                                          gfortran libblas-dev libblas3gf liblapack3gf liblapack-dev libncurses5-dev
                                          libatlas-dev libatlas-base-dev libscalapack-mpi1 libscalapack-pvm1
                                          liblcms-utils
                                          libamd2.2.0 libjpeg-turbo8 libjpeg8 liblcms1 libumfpack5.4.0
                                          libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
                                          git-core
                                          libhdf5-7 libhdf5-serial-dev
                                          pandoc
                                        )
                                      end

################################################################################
# Software Stack (pip installs)
################################################################################

# The scientific computing stack, installed in order
# Note that numpy must be first and the dependencies for matplotlib also have
# to start first due to the way numpy+matplotlib are packaged
default['ipynb']['scientific_stack'] = { 'numpy' => nil,
                                         'freetype-py' => '1.0.2',
                                         'pillow' => '4.0.0',
                                         'scipy' => '0.18.1',
                                         'python-dateutil' => nil,
                                         'pytz' => '2016.10',
                                         'six' => '1.10.0',
                                         'scikit-learn' => '0.18.1',
                                         'pandas' => '0.19.2',
                                         'matplotlib' => '1.5.3',
                                         'pygments' => '2.1.3',
                                         'readline' => '6.2.4.1',
                                         'nose' => '1.3.7',
                                         'pexpect' => '4.2.1',
                                         'cython' => '0.25.2',
                                         'networkx' => '1.11',
                                         'numexpr' => '2.6.1',
                                         'tables' => '3.3.0',
                                         'patsy' => '0.4.1',
                                         'statsmodels' => '0.6.1',
                                         'sympy' => '1.0',
                                         'scikit-image' => '0.12.3',
                                         'theano' => '0.8.2',
                                         'xlrd' => '1.0.0',
                                         'xlwt' => '1.1.2',
                                       }

# Let users configure exactly what version of Jupyter they are going to pull (from git, PyPI, etc.)
# Most of the attributes, configuration, etc. rely on Jupyter 4.x so be wary on changing
# Note that we default to the jupyter meta-package, which is jupyter1.0.0
default['ipynb']['ipython_package'] = 'jupyter'
default['ipynb']['ipython_package_version'] = nil

# Additional packages to install into the same virtualenv as the IPython notebook
default['ipynb']['extra_packages'] = {}
