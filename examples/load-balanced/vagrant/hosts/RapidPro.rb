Vagrant.configure("2") do |config|
    config.vm.define "app1" do |app1|
      app1.vm.provider :virtualbox do |vb|
        vb.name = "ansible-rapidpro-lb-app1"
        vb.memory = 2048
        vb.cpus = 1
      end

      app1.vm.network "private_network", ip: "10.0.0.3"
    end
    config.vm.define "app2" do |app2|
          app2.vm.provider :virtualbox do |vb|
            vb.name = "ansible-rapidpro-lb-app2"
            vb.memory = 2048
            vb.cpus = 1
          end
          app2.vm.network "private_network", ip: "10.0.0.4"
    end
  end