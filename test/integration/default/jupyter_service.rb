# ensure configuration file exists
file '/home/vagrant/.jupyter/jupyter_notebook_config.py' do
  it { should exist }
end

# ensure our service is running
describe service 'jupyter' do
  it { should be_running }
end

# verify service is listening
describe port(8888) do
  its('addresses') { should include '127.0.0.1' }
  its('protocols') { should eq ['tcp'] }
  it { should be_listening }
end
