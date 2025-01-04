# Create-KVM-cloudinit-ubuntu-vm
## cloudinit isoを使用してkvm上にubunu-serverを立てます
### 以下のプログラムのインストールを行います。
  - update && upgrade
  - ca-certificates 
  - curl 
  - git 
  - cifs-utils 
  - docker-ce 
  - docker-ce-cli 
  - containerd.io 
  - docker-buildx-plugin 
  - docker-compose-plugin
  - docker-compose
### 以上が自動インストールされます。
#### 総括するとsambaを使用するのに必要なプログラムとDockerが入るという形なります。
### またsambaを使ってnasの自動マウントも行っています。
#### 実際に使う際には```sanba.local```の部分を自分のnasのIPアドレスに変更してください
  - ```mkdir /mnt/hdd && echo "//sanba.local/user /mnt/hdd cifs user,uid=1000,gid=1000,username=user,password=user" | sudo tee -a /etc/fstab && sudo mount -a```