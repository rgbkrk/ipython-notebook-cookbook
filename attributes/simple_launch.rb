# Some default attributes for the simple launcher

default[:ipynb][:user] = "ipynb"
default[:ipynb][:group] = "ipynb"
default[:ipynb][:home_dir] = "/home/ipynb/"
default[:ipynb][:notebook_dir] = File.join(default[:ipynb][:home_dir], "notebooks")

default[:ipynb][:port] = 8888
