name             'ipynb'
maintainer       'Kyle Kelley'
maintainer_email 'rgbkrk@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures IPython Notebook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends "python"
depends "yum", ">= 2.3.0"
depends "apt", ">= 2.0.0"
depends "supervisor", ">= 0.4.5"
depends "nginx", ">= 1.7.0"

supports 'ubuntu'
