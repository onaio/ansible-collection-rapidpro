Vagrant.configure("2") do |config|
    config.vm.define "monitoring" do |monitoring|
      monitoring.vm.provider :virtualbox do |vb|
        vb.name = "ansible-rapidpro-lb-monitoring"
        vb.memory = 2048
        vb.cpus = 2
      end

      monitoring.vm.network "private_network", ip: "10.0.0.2"
    end
  end