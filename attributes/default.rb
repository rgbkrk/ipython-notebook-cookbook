# Attributes for the IPython cookbook

# User and group for IPython
default[:ipynb][:user] = "ipynb"
default[:ipynb][:group] = "ipynb"

# Home directory for the user
default[:ipynb][:home_dir] = "/home/ipynb/"

# Spot to store the notebook files
default[:ipynb][:notebook_dir] = File.join(default[:ipynb][:home_dir], "notebooks")

# Port to host on
default[:ipynb][:port] = 8888

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

# System packages, at least for Ubuntu (naming may change)
default[:ipynb][:system_packages] = %w{ipython ipython-notebook ipython-doc python-pandas ipython-qtconsole
   libpng12-0 libpng12-dev libfreetype6 libfreetype6-dev
   python-matplotlib python-numpy libjs-jquery-ui-docs python-egenix-mxdatetime
   libcurl4-gnutls-dev python-pycurl-dbg}

