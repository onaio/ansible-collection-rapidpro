Vagrant.configure("2") do |config|
    config.vm.define "database" do |database|
      database.vm.provider :virtualbox do |vb|
        vb.name = "ansible-rapidpro-lb-database"
        vb.memory = 2048
        vb.cpus = 1
      end

      database.vm.network "private_network", ip: "10.0.0.5"
    end
  end