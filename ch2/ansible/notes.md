# Ansible setup

[Ansible install guide](https://docs.ansible.com/projects/ansible/latest/getting_started_ee/introduction.html)

Ansible setup involved:

* Creating a python venv
  * `python3 -m venv ~/.ansible`
* Installing ansible-navigator
  * `./bin/pip install ansible-navigator`
* Installing the aws collection
  * `./bin/ansible-galaxy collection install amazon.aws`
* Creating a sample `execution-environment.yaml`

```
version: 3

images:
  base_image:
    name: registry.fedoraproject.org/fedora:42

dependencies:
  python_interpreter:
    package_system: python3
  ansible_core:
    package_pip: ansible-core
  ansible_runner:
    package_pip: ansible-runner
  system:
  - openssh-clients
  - sshpass
  galaxy:
    collections:
    - name: amazon.aws
```

* Building the image
  * `./bin/ansible-builder build -f ./aws-example/execution-environment.yaml -t ansible-aws-example -v`

```
$ docker images --format table | grep ansible-aws-example
ansible-aws-example                                                                              latest                 9629fb600157   9 minutes ago   332MB
```

# Using the image.

* Note that we're passing in the AWS secret access keys as environment variables to ansible-navigator

```
$ ~/.ansible/bin/ansible-navigator run deploy-ec2-ansible.yaml --execution-environment-image ansible-aws-example --mode stdout --pull-policy missing --container-options='--user=0' --penv AWS_DEFAULT_REGION --penv AWS_SECRET_ACCESS_KEY --penv AWS_ACCESS_KEY_ID
[WARNING]: No inventory was parsed, only implicit localhost is available
[WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not match 'all'

PLAY [Deploy EC2 instances in AWS] *********************************************

TASK [Create security group] ***************************************************
[WARNING]: Deprecation warnings can be disabled by setting `deprecation_warnings=False` in ansible.cfg.
[DEPRECATION WARNING]: Importing 'to_text' from 'ansible.module_utils._text' is deprecated. This feature will be removed from ansible-core version 2.24. Use ansible.module_utils.common.text.converters instead.
[DEPRECATION WARNING]: Importing 'to_native' from 'ansible.module_utils._text' is deprecated. This feature will be removed from ansible-core version 2.24. Use ansible.module_utils.common.text.converters instead.
changed: [localhost]

TASK [Get all Amazon Linux AMIs] ***********************************************
ok: [localhost]

TASK [Create EC2 instances with Amazon Linux] **********************************
changed: [localhost] => (item=0)

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

# Folder structure

| Folder | Notes|
| --- | --- |
| group_vars | variables to configure how ansible connects to hosts in a particular group. The group name is the name of each yaml file within this folder. |
| roles | roles are a logical configuration profile. Each role has a folder. |
| roles/<role_name>/defaults | |
| roles/<role_name>/files | Files to copy to a server |
| roles/<role_name>/handlers | |
| roles/<role_name>/tasks | Tasks to run on a server |
| roles/<role_name>/templates | Jinja templates to populate data |
| roles/<role_name>/vars | |

# Running a playbook

```
$ ~/.ansible/bin/ansible-navigator run configure_sample_ec2_ansible.yaml --execution-environment-image ansible-aws-example:latest --pull-policy missing -i aws_ec2.yaml --mode stdout --penv AWS_DEFAULT_REGION --penv AWS_SECRET_ACCESS_KEY --penv AWS_ACCESS_KEY_ID
[WARNING]: Deprecation warnings can be disabled by setting `deprecation_warnings=False` in ansible.cfg.
[DEPRECATION WARNING]: Importing 'to_text' from 'ansible.module_utils._text' is deprecated. This feature will be removed from ansible-core version 2.24. Use ansible.module_utils.common.text.converters instead.
[DEPRECATION WARNING]: Importing 'to_native' from 'ansible.module_utils._text' is deprecated. This feature will be removed from ansible-core version 2.24. Use ansible.module_utils.common.text.converters instead.
[DEPRECATION WARNING]: Passing `disable_lookups` to `template` is deprecated. This feature will be removed from ansible-core version 2.23.

PLAY [Configure EC2 instances] *************************************************
[WARNING]: Found variable using reserved name 'tags'.
Origin: <unknown>

tags


TASK [Gathering Facts] *********************************************************
[WARNING]: Host 'ec2-ip.region.compute.amazonaws.com' is using the discovered Python interpreter at '/usr/bin/python3.9', but future installation of another Python interpreter could cause a different interpreter to be discovered. See https://docs.ansible.com/ansible-core/2.20/reference_appendices/interpreter_discovery.html for more information.
ok: [ec2-ip.region.compute.amazonaws.com]

TASK [sample_config : Add Node Yum repo] ***************************************
changed: [ec2-ip.region.compute.amazonaws.com]

TASK [sample_config : Install Node.js] *****************************************
changed: [ec2-ip.region.compute.amazonaws.com]

TASK [sample_config : Copy sample app] *****************************************
changed: [ec2-ip.region.compute.amazonaws.com]

TASK [sample_config : Start sample app] ****************************************
changed: [ec2-ip.region.compute.amazonaws.com]

PLAY RECAP *********************************************************************
ec2-ip.region.compute.amazonaws.com : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
