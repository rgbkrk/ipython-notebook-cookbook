# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Name the box for Vagrant
  config.vm.define :IPyBox

  config.vm.provider "virtualbox" do |ipybox|
     ipybox.name = "IPyBox"
  end

  config.vm.hostname = "ipynb-cookbook-berkshelf"

  config.omnibus.chef_version = "11.6.0"

  config.vm.box = "opscode-ubuntu-13.04"
  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-13.04_provisionerless.box"

  # Forward the default 8888 port for the IPython notebook,
  # keeping the port different on the host box in case the user
  # is running the IPython notebook locally
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.network :forwarded_port, guest: 80, host: 9999

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true


  config.vm.provision :chef_solo do |chef|

    chef.log_level = :debug

    chef.json = {
      :ipynb => {
         :NotebookApp => {
            :password => "test",
         },
         :ssl_certificate => "/etc/nginx/ssl.pem",
         :ssl_certificate_key => "/etc/nginx/ssl.key",
         # Note: Don't use this key in production -- this is just a vagrant testing key
         :ssl_certificate_key_text => <<-eos,
-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQDKDv8EmwzlrhoN7XknVNDyZFMC3eQl60fSrNgjYjMojMmNlrRx
p770h5Y9dosEuQXuXMbYyvyQpQemDWiQEt6rkGhOB5lZ9NheWn6nnW+9YBbtwkqz
ZuAoq6asuvH4faXivg6d8Qxt0xa+g3vFUNVzKBLoRziYFN4NEO+gxrXbXwIDAQAB
AoGBAIJMhVtc+UYrrZWJq/UXFt8YnwdcO8HQJbLPz1mR+9eMYnUx2A7q05Mw1Euy
ZBeZkR+TKI+o5pIIOhR01RcDdB8dPtoVCgiDSyb/kzhqnEvY/8IvvHdvGQU2V5q3
6NVISp/SIRUuFxoTuPq5tF0cvPYSp4U+BBFavnXwe1y9KUSxAkEA6gs2rDyMVU7K
0yY+pzWM6/OdNKPWYRCBeCRxo1d2k4xlkoPOq8xVm5+RyNq9NBGWkUSROz6zOuwH
swExKq3sswJBAN0DoHMks6o/vw2Z86FJEEffWuDXRHZeMfgaug8vuDHLzrkZcUzb
WJcbNTF1H1FeF3ITevt98CZOhrZHCXcwhKUCQQDorCc5SaR1trQ7AB1vW/RyKimS
SIL60k70Ir76lRwkCYJ9Cx5ueuBsq1FibduFJSsb1h/P10CVhksNMVUwyeGzAkA9
YVl5QPMo0CVmSKBR5bHA1DYwBXj9CrID/qA3wX/9TGXwIDHIL47OAH9oaee1uFT4
mJJqMBK3AM4G53mogXAFAkBSpcRbCXlWBUJjGiE9qrpaqrDhncNhMA5zqxkxmGEF
WfBxaOjp9wsQZZHX+bSQLp92WjW0Uq712dtL7CVOWqxb
-----END RSA PRIVATE KEY-----
eos
         :ssl_certificate_text => <<-eos,
-----BEGIN CERTIFICATE-----
MIICmDCCAgGgAwIBAgIJAONj1DIGs9lkMA0GCSqGSIb3DQEBBQUAMD0xCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJUWDEhMB8GA1UEChMYSW50ZXJuZXQgV2lkZ2l0cyBQ
dHkgTHRkMB4XDTEzMDgxOTIwNDE0NloXDTE0MDgxOTIwNDE0NlowPTELMAkGA1UE
BhMCVVMxCzAJBgNVBAgTAlRYMSEwHwYDVQQKExhJbnRlcm5ldCBXaWRnaXRzIFB0
eSBMdGQwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMoO/wSbDOWuGg3teSdU
0PJkUwLd5CXrR9Ks2CNiMyiMyY2WtHGnvvSHlj12iwS5Be5cxtjK/JClB6YNaJAS
3quQaE4HmVn02F5afqedb71gFu3CSrNm4Cirpqy68fh9peK+Dp3xDG3TFr6De8VQ
1XMoEuhHOJgU3g0Q76DGtdtfAgMBAAGjgZ8wgZwwHQYDVR0OBBYEFKJEzyGWKl47
WecMx/gocolKLN1IMG0GA1UdIwRmMGSAFKJEzyGWKl47WecMx/gocolKLN1IoUGk
PzA9MQswCQYDVQQGEwJVUzELMAkGA1UECBMCVFgxITAfBgNVBAoTGEludGVybmV0
IFdpZGdpdHMgUHR5IEx0ZIIJAONj1DIGs9lkMAwGA1UdEwQFMAMBAf8wDQYJKoZI
hvcNAQEFBQADgYEAUxagzwBN/fCJlKh1eIdO/oWBqtt9Ca70VSylD0WJrtgznreG
fZJ4bEzYsCAsWcQowSmEkzQeXzB60EUT3I09SbyFe7+JD+/CGiBfET42ABGwGNUV
dE3w7J7Coc46rYXAqMg05hBYrOe43nra2RHTFxQr5V+oDLMcZuPI2Ozo4e4=
-----END CERTIFICATE-----
eos
         # Make boot up quicker when simply testing the notebook
         #:scientific_stack => [],
      }
    }

    chef.run_list = [
        "recipe[apt]",
        "recipe[yum]",
        "recipe[ipynb::default]",
        "recipe[ipynb::virtenv_launch]",
        "recipe[ipynb::proxy]"
    ]
  end
end
