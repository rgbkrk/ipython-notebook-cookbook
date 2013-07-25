# Some default attributes for the simple launcher

# User and group for IPython
default[:ipynb][:user] = "ipynb"
default[:ipynb][:group] = "ipynb"

# Home directory for the user
default[:ipynb][:home_dir] = "/home/ipynb/"

# Spot to store the notebook files
default[:ipynb][:notebook_dir] = File.join(default[:ipynb][:home_dir], "notebooks")

# Port to host on
default[:ipynb][:port] = 8888
