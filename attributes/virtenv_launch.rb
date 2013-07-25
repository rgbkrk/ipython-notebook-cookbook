# Attributes specific to installing IPython + packages to a virtualenv

# Where to store the virtual environment IPython runs in
default[:ipynb][:virtenv] = File.join(default[:ipynb][:home_dir], "ipyvirt")

# Version of Python to use
default[:ipynb][:py_version] = "python2.7"
