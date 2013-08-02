# Default attributes for the IPython cookbook

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

# NotebookApp.password
# Default here is IPassword
default[:ipynb][:NotebookApp][:password_hash] = 'sha1:f918d238efbd:4a250470288eb6a41f5df648a39f82606cbd33dd'

# Landing page settings
default[:ipynb][:NotebookApp][:base_project_url] = nil
default[:ipynb][:NotebookApp][:base_kernel_url] = nil
default[:ipynb][:NotebookApp][:webapp_settings][:static_url_prefix] = nil


########################################
# Software Stack (system packages)
########################################

# System packages, at least for Ubuntu (naming may change)
default[:ipynb][:system_packages] = %w{
   libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
   libcurl4-gnutls-dev python-pycurl-dbg git-core
   python-egenix-mxdatetime python-numpy python-matplotlib
   ipython ipython-notebook python-pandas
}

########################################
# Software Stack (pip installs)
########################################

# The scientific computing stack, installed in order
# Note that numpy must be first and the dependencies for matplotlib also have
# to start first due to the way numpy+matplotlib are packaged
default[:ipynb][:scientific_stack] = ["numpy", "freetype-py", "pillow",
                                      "python-dateutil", "pytz==2013b", "six",
                                      "scipy", "pandas", "matplotlib"]

# Let users configure exactly what version of IPython they are going to pull (from git, PyPI, etc.)
# Default is a commit hash from the evening of July 30, 2013, eagerly waiting the release of IPython 1.0
# Most of the attributes, configuration, etc. rely on IPython 1.0 so be wary if for some reason you want to use 0.x releases.
default[:ipynb][:ipython_package] = 'http://archive.ipython.org/testing/1.0.0/ipython-1.0.0a1.tar.gz#egg=ipython-1.0.0a1'

# All the dependencies for IPython + IPython notebook
default[:ipynb][:ipython_deps] = ["tornado",
                                  "pyzmq",
                                  "jinja2"
]

# Additional packages to install into the same virtualenv as the IPython notebook
default[:ipynb][:extra_packages] = []

