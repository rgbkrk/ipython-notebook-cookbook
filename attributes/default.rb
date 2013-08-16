##############################################
# IPython Notebook Cookbook Default Attributes
##############################################

########################################
# Server side configuration
########################################

# linux user and group for the system IPython is being deployed to
default[:ipynb][:linux_user] = "ipynb"
default[:ipynb][:linux_group] = "ipynb"

# Home directory for the system user
default[:ipynb][:home_dir] = File.join("/home/", default[:ipynb][:linux_user])

# Spot to store the notebook files
default[:ipynb][:notebook_dir] = File.join(default[:ipynb][:home_dir], "notebooks")

# Supervisord service name
default[:ipynb][:service_name] = "ipynb"

# IPython profile
default[:ipynb][:profile_name] = "cooked"

# IPython directory for settings
default[:ipynb][:ipython_settings_dir] = File.join(default[:ipynb][:home_dir], ".ipython")

########################################
# IPython Notebook runtime configuration
########################################

# Pick how plots are done
default[:ipynb][:NotebookApp][:pylab] = 'inline'

# IP to host on, defaults to all interfaces
default[:ipynb][:NotebookApp][:ip] = '*'

# Port to host on
default[:ipynb][:NotebookApp][:port] = 8888

# Choose whether to open a browser, default is server mode (no browser run on server -- interact on client)
default[:ipynb][:NotebookApp][:open_browser] = 'False'

# SSL Certificate file (private), should be the absolute path of the PEM file you want to use.
#
# Example for self-generating:
#
#   openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
#
# Can acquire a signed certificate by following this tutorial, through StartSSL:
#
#   http://arstechnica.com/security/news/2009/12/how-to-get-set-with-a-
#
default[:ipynb][:NotebookApp][:certfile] = nil

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
# Roughly speaking the password is converted to UTF-8 (when in Python 2.7) using string.encode
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
default[:ipynb][:NotebookApp][:password_hash] = 'sha1:f918d238efbd:4a250470288eb6a41f5df648a39f82606cbd33dd'

# Landing page settings
default[:ipynb][:NotebookApp][:base_project_url] = nil
default[:ipynb][:NotebookApp][:base_kernel_url] = nil
default[:ipynb][:NotebookApp][:webapp_settings][:static_url_prefix] = nil

########################################
# Virtualenv
########################################

# Where to store the virtual environment IPython runs in
default[:ipynb][:virtenv] = File.join(default[:ipynb][:home_dir], "ipyvirt")

# Version of Python to use
default[:ipynb][:py_version] = "python2.7"

########################################
# Software Stack (system packages)
########################################

# System packages, at least for Ubuntu (naming may change)
default[:ipynb][:system_packages] = %w{
   gfortran libblas-dev libblas3gf liblapack3gf liblapack-dev
   libatlas-dev libatlas-base-dev libscalapack-mpi1 libscalapack-pvm1
   liblcms-utils python-imaging-doc python-imaging-dbg
   libamd2.2.0 libjpeg-turbo8 libjpeg8 liblcms1 libumfpack5.4.0 python-imaging
   libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
   libcurl4-gnutls-dev python-pycurl-dbg git-core
   python-egenix-mxdatetime vim python-numpy python-scipy
}

########################################
# Software Stack (pip installs)
########################################

# The scientific computing stack, installed in order
# Note that numpy must be first and the dependencies for matplotlib also have
# to start first due to the way numpy+matplotlib are packaged
default[:ipynb][:scientific_stack] = ["numpy", "freetype-py", "pillow",
                                      "python-dateutil", "pytz==2013b", "six",
                                      "scipy", "pandas", "matplotlib", "scikit-learn"]

# Let users configure exactly what version of IPython they are going to pull (from git, PyPI, etc.)
# Default is a commit hash from the evening of July 30, 2013, eagerly waiting the release of IPython 1.0
# Most of the attributes, configuration, etc. rely on IPython 1.0 so be wary if for some reason you want to use 0.x releases.
default[:ipynb][:ipython_package] = 'https://1f2133dc3aab4203faba-815b705eb00655bf9ca363d7dfb3b606.ssl.cf2.rackcdn.com/ipython-1.0.0-rc1.tar.gz#egg=ipython-1.0.0-rc1'

# All the dependencies for IPython + IPython notebook
default[:ipynb][:ipython_deps] = ["tornado==3.1",
                                  "pyzmq",
                                  "jinja2"
]

# Additional packages to install into the same virtualenv as the IPython notebook
default[:ipynb][:extra_packages] = []
#default[:ipynb][:extra_packages] = ["bookstore==0.0.4a"]



