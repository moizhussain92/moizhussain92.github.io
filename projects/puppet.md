---
title: Puppet
permalink: /work/puppet
---
![puppet](project-img/puppet-diagram.png){: #project-image" .project}

#### Design and Implementation:
Implemented a puppet master-slave scenario where multiple nodes can be configured remotely via a puppet master.

1. Machine A was configured to be the puppet master
```shell
yum install puppet-server
systemctl start puppetmaster #Starting the service
systemctl enable puppetmaster #Enable start on boot
```
2. Rest of the machines were configured to be the puppet-clients
```shell
ping puppet #to check if puppet agent is up and running
systemctl start puppet #start puppet in the machine
```

3. Certificate approval requests related to puppet were approved in machine A.
```shell
puppet cert --list --all # See pending certificate approval requests
puppet cert --sign --all # Approve all the pending certificate requests
puppet cert --sign <hostname> #Approve specific certificate request for a certain host
``` 

4. Created directory site.pp to store all the puppet manifests. Whenever a client queries the puppet master, it looks for manifests that are specifically addressed to it. For Example, machine B querying the puppet master would look for configuration that contains its hostname as show below:
```puppet
node "machineb.domain.com"
        file {'/tmp/test':
        content => 'This is a test' }
``` 
> This would create a file at `/tmp/test` in Machine B with content "This is a test".
> Any configuration that does not specify a node/machine is considered common and will be applied to all the puppet clients. Hence, one should be careful in mentioning/omitting the nodes in puppet manifests to avoid pushing the wrong configurations. 

5. Puppet clients query the puppet master every 30 minutes for any updates in the configuration. If one wants to pull the configuration manually, it can be done by executing the command `puppet agent --test`

6. For reference, the manifests for each machine that were used for this project are located [here][puppet-repo].

[puppet-repo]:https://github.com/moizhussain92/linux