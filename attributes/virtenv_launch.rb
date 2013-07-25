
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

