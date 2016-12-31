name             'ipynb'
maintainer       'Kyle Kelley'
maintainer_email 'rgbkrk@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures IPython Notebook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'
source_url       'https://github.com/rgbkrk/ipython-notebook-cookbook' if respond_to?(:source_url)
issues_url       'https://github.com/rgbkrk/ipython-notebook-cookbook/issues' if respond_to?(:issues_url)
chef_version     '>= 12.1'

depends 'poise-python', '~> 1.5'
depends 'poise-service', '~> 1.4.2'
depends 'apt', '~> 2.2'
depends 'build-essential', '>= 2'
# depends 'nginx', '~> 1.8'
depends 'nginx', '~> 2.7'

supports 'ubuntu', '>= 14.04'
