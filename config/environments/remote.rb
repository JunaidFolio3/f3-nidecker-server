require 'net/ssh/gateway'

module RemoteConnectionManager
  SSH_USER = 'tetix'
  # remote_host = 'ndk-staging-jones.nidecker.com'
  # port = 22
  
  def self.port_through_tunnel(remote_host, port)
  puts "remote host: #{remote_host} & port: #{port}"
    return Net::SSH::Gateway.new(remote_host, SSH_USER)
      .open(remote_host, port)
  end
end