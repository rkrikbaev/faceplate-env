Run a container:

    sudo docker run -it --name ecomet22.3 -v /home/roman/PROJECTS:/opt/ext vzroman/erlang_ecomet:otp22.3

On the fisrt start you need to install ssh keys for private repositories:
    
    /opt/install-ssh.sh /opt/ext/_ssh

Start the container:
    
    sudo docker start -i ecomet22.3