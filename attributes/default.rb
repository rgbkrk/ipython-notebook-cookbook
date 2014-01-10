################################################################################
#
# IPython Notebook Cookbook Default Attributes
#
################################################################################

################################################################################
# Server side configuration
################################################################################

# linux user and group for the system IPython is being deployed to
default[:ipynb][:linux_user] = "ipynb"
default[:ipynb][:linux_group] = "ipynb"

# Home directory for the system user
default[:ipynb][:home_dir] = nil #File.join("/home/", default[:ipynb][:linux_user])

# Spot to store the notebook files
default[:ipynb][:notebook_dir] = nil #File.join(default[:ipynb][:home_dir],
                                     #      "notebooks")

default[:supervisor][:version] = "3.0"

# Supervisord service name
default[:ipynb][:service_name] = "ipynb"

# IPython profile
default[:ipynb][:profile_name] = "cooked"

default[:ipynb][:proxy][:enable] = true
default[:ipynb][:proxy][:hostname] = fqdn
default[:ipynb][:proxy][:alias_hostnames] = []

################################################################################
# IPython Notebook runtime configuration
################################################################################

# Pick how plots are done
default[:ipynb][:NotebookApp][:pylab] = 'inline'

# IP to host on, defaults to all interfaces
default[:ipynb][:NotebookApp][:ip] = '127.0.0.1'

# Port to host on
default[:ipynb][:NotebookApp][:port] = 8888

# Choose whether to open a browser, default is server mode (no browser run on
# server -- interact on client)
default[:ipynb][:NotebookApp][:open_browser] = 'False'

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
default[:ipynb][:ssl_certificate] = nil
default[:ipynb][:ssl_certificate_text] = nil
default[:ipynb][:ssl_certificate_key] = nil
default[:ipynb][:ssl_certificate_key_text] = nil

# Hashed Password with Salt, Algorithm for accessing the IPython Notebook
#
# You can generate one using IPython.lib.passwd
#
#     In [1]: from IPython.lib import passwd
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
default[:ipynb][:NotebookApp][:password_hash] = nil
default[:ipynb][:NotebookApp][:password] = nil


# Landing page settings
default[:ipynb][:NotebookApp][:base_project_url] = nil
default[:ipynb][:NotebookApp][:base_kernel_url] = nil
default[:ipynb][:NotebookApp][:webapp_settings][:static_url_prefix] = nil

################################################################################
# Virtualenv
################################################################################

# Where to store the virtual environment IPython runs in
default[:ipynb][:virtenv] = nil #File.join(default[:ipynb][:home_dir], ".ipyvirt")

# Version of Python to use
default[:ipynb][:py_version] = "python2.7"

################################################################################
# Software Stack (system packages)
################################################################################

# System packages, at least for Ubuntu (naming may change)
default[:ipynb][:system_packages] = %w{
   build-essential libcurl4-openssl-dev libssl-dev zlib1g-dev libpcre3-dev
   gfortran libblas-dev libblas3gf liblapack3gf liblapack-dev libncurses5-dev
   libatlas-dev libatlas-base-dev libscalapack-mpi1 libscalapack-pvm1
   liblcms-utils python-imaging-doc python-imaging-dbg
   libamd2.2.0 libjpeg-turbo8 libjpeg8 liblcms1 libumfpack5.4.0 python-imaging
   libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
   libcurl4-gnutls-dev python-pycurl-dbg git-core
   cython libhdf5-7 libhdf5-serial-dev
   python-egenix-mxdatetime vim python-numpy python-scipy pandoc
}

################################################################################
# Software Stack (pip installs)
################################################################################

# The scientific computing stack, installed in order
# Note that numpy must be first and the dependencies for matplotlib also have
# to start first due to the way numpy+matplotlib are packaged
default[:ipynb][:scientific_stack] = ["numpy==1.8.0",
                                      "freetype-py==0.4.1",
                                      "pillow==2.3.0",
                                      "scipy==0.13.2",
                                      "python-dateutil",
                                      "pytz==2013b",
                                      "six==1.5.2",
                                      "scikit-learn==0.14.1",
                                      "pandas==0.12.0",
                                      "https://downloads.sourceforge.net/project/matplotlib/matplotlib/matplotlib-1.3.1/matplotlib-1.3.1.tar.gz",
                                      "pygments==1.6",
                                      "readline==6.2.4.1",
                                      "nose==1.3.0",
                                      "pexpect==3.0",
                                      "cython==0.19.2",
                                      "networkx==1.8.1",
                                      "numexpr==2.2.2",
                                      "tables==3.0.0",
                                      "patsy==0.2.1",
                                      "statsmodels==0.5.0",
                                      "sympy==0.7.4.1",
                                      "scikit-image==0.9.3",
                                      "nltk==2.0.4",
                                      "theano==0.6.0",
                                      "xlrd==0.9.2",
                                      "xlwt==0.7.5"
                                     ]

# Let users configure exactly what version of IPython they are going to pull (from git, PyPI, etc.)
# Most of the attributes, configuration, etc. rely on IPython 1.0 so be wary if for some reason you want to use 0.x releases.
default[:ipynb][:ipython_package] = "ipython[notebook]==1.1.0"

# Additional packages to install into the same virtualenv as the IPython notebook
default[:ipynb][:extra_packages] = []

