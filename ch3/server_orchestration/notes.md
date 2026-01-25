# Server orchestration with ansible

The concept we're demoing here is managing mutable servers and using Ansible to deploy an app to them.

We're using Ansible to create the EC2 servers, but in the real world you'd probably use OpenTofu/Terraform to provision them.

Add extra variables when running the playbook with the `--extra-vars` flag.

```
~/.ansible/bin/ansible-navigator run deploy-ec2-ansible.yaml \
--execution-environment-image ansible-aws-example \
--mode stdout \
--pull-policy missing \
--container-options='--user=0' \
--penv AWS_DEFAULT_REGION \
--penv AWS_SECRET_ACCESS_KEY \
--penv AWS_ACCESS_KEY_ID \
--extra-vars ./sample-app-vars.yaml
```

We're using PM2 - this is a process supervisor, which is a tool to run apps, monitor them, restart them after a reboot or crash, and manage their logging.

PM2 has some features specifically for Node, so it's selected in this example.

* Use `deploy-ec2-ansible.yaml` with the extra vars file `sample-app-vars.yaml` to deploy 3 EC2 instances.
* Use `configure_sample_app_playbook.yaml` targeting the created hosts to install npm and run the sample app and pm2.

Then, we will use nginx as a load balancer.

Rerunning the playbook will not create additional security groups or instances.

Editing the security group and then rerunning the playbook will splat the changes.

* Use the same `deploy-ec2-ansible.yaml` but with a different `nginx-vars.yaml` vars file to deploy a EC2 instance for nginx.
* Then we use a third party role provided on Github: `requirements.yaml`
