Fundamentals of DevOps and Software Delivery O'Reilly textbook study

Code examples provided by the book [here](https://github.com/brikis98/devops-book)

## Chapter 1: How to deploy your app

* __Platform as a Service (PaaS)__
  * Platform as a Service examples include: Heroku, Render, Fly.io and Vercel.
  * For these examples, __Render__ is selected as it offers a free Hobby tier.
    * For a trivial web app you can simply point Render to a public repository (or sign in with Github) and it will build the image and deploy it.
    * It also allows non-service workloads like jobs and cron, and private connectivity to AWS.
    * Paid services include Metrics and Logs streaming (OpenTelemetry).
  * PaaS providers do not offer the range of services that IaaS providers offer, but are simpler and likely cheaper; at a small scale you don't need IaaS.
    * __As a general principle you should spend as little time and money on software delivery as you possibly can while still meeting requirements.__
* __Infrastructure as a service (IaaS)__
  * Infrastructure as a Service examples include: Hetzner, DigitalOcean, Vultr, and Akamai.
    * Non big 3 cloud providers will be cheaper.
  * IaaS is a better fit as these grow: load, company size, availability demands, security and compliance demands.
    * Infrastructure and software delivery processes should grow with the company and be the right complexity to meet the needs of the company.
  * Consider cloud vendor lock-in clear eyed. It is plausibly the case that avoiding the use of proprietary solutions will slow down your deployment, and not pay for itself if you ever try to move.

## Chapter 2: How to manage your Infrastructure as Code IaC

* Why use IaC?
  * Speed & safety, documentation, version control, validation, self-servicability, reuse, toil elimination
* Scripts & configuration management tools
  * While it's possible to manage  infrastructure through the CLI or bash scripts this has obvious drawbacks e.g. inconistency, maintainability, scale etc.
  * __Ansible__ is an open source automation engine to simplify configuraton, deployment and orchestration across servers.
    * Python, with runbooks written in yaml.
    * It does not have an official Docker image; it seems the intention is that you create your own Executable Environment:
      * https://docs.ansible.com/projects/ansible/latest/getting_started_ee/introduction.html
      * Be aware of this additional overhead!
    * Ansible, like most configuration management tools, doesn't support delete.
      * there is a `state: absent` parameter, but this doesn't automatically track dependencies.
    * Ansible supports deployment strategies e.g. rolling.
    * Some Ansible tasks may be idempotent, but it is not necessarily the case that all are.
  * Configuration drift is a concern for configuration management tools (imagine running ansible playbooks on a server that has been running for years).
    * _Mutable infrastructure_ can be contrasted with _immutable infrastructure_ - which are like short-lived VMs that are replaced whenever they need to be modified
    * __Configuration management tools are great for managing the configuration of servers, but not for deploying the servers themselves__
* Server templating tools
  * Server templating tools only create images (they don't deploy them).
  * Key difference between Containers and VMs: Containers share the underlying OS's kernel and hardware (which reduces overhead but reduces isolation compared to VMs) while VMs virtualize their own hardware and OS.
    * _Kernel space_: Direct, unrestricted access to all the hardware; no security restrictions - any code can execute any CPU instruction or access any part of the hard drive or memory.
    * _User space_: No direct access to the hardware, and must use APIs exposed by the OS kernal that may enforce security and safety restrictions.
  * __Packer__
     * "Packer is a community tool for creating identical machine images for multiple platforms from a single source configuration."
     * "A machine image is a single static unit that contains a pre-configured operating system and installed software which is used to quickly create new running machines."
     * Packer doesn't replace configuration management - in fact it can leverage it to create the machine images.
* Provisioning tools
  * e.g. OpenTofu/Terraform, CloudFormation, Pulumi
  * Behind the scenes, provisioning tools translate your code into API calls.
  * __OpenTofu__
    * Open source provisioning tool
    * It records information about the infrastructure it creates in a _state file_ (default: a local json file).
      * This record refreshed on every run and is compared against your current code when determining what changes it needs to make to the infrastructure.
    * Provisioning tools are highly flexible, scalable, consistent, and support any deployment strategy the underlying infrastructure supports. They are idempotent by design.
* The reality is is that you will likely need to use multiple tools e.g.
  * OpenTofu to deploy the underlying infrastructure & Ansible to deploy the apps on that infrastructure.
    * (OpenTofu tagging infrastructure and Ansible targeting those tags is a useful pattern).
  * Packer to design machine images, and OpenTofu to deploy them.
* IaC is very different to traditional system administration. Golden rules for transformation:
  * Adapt all processes to your needs.
  * Work incrementally (have each step be an incremental gain).
  * Give people time to learn.

## Chapter 3: How to manage your apps by using orchestration tools

* Core Orchestration problems:
  * _Deployment_: Deploying one or more replicas of the app onto servers, and roll out updates - preferably with no noticeable downtime.
  * _Scheduling_: Deciding which app runs on which hardware; ensuring it has the required CPU/Memory/Disk space.
  * _Rollback_: Some way of rolling back bad updates.
  * _Auto Scaling_: Either veritical or horizontal scaling that occurs in response to load.
  * _Auto Healing_: Some mechanism to detect whether or not instances of an app are healthy, and restarting or replacing them accordingly.
  * _Load Balancing_: Distributing load across replicas.
  * _Configuration_: If there are multiple environments, configuring the app differently in each.
  * _Secrets Management_: Securely storing and accessing sensitive information.
  * _Service Communication_: Enabling communication between services.
  * _Disk Management_: Ensuring instances of the app has access to the right disks.
* Server orchestration
  * The original pre-cloud approach: set up a bunch of servers, deploy your app to them, and update the servers in-place as needed.
  * e.g. Using Ansible to deploy code onto a cluster of servers.
* VM orchestration
  * Create VM images that have your apps and dependencies fully installed and configured, deploy thte VM images across a cluster of servers, scale the number of servers to meet load, and create new VM images on new servers to do an upgrade.
  * e.g. Deploy VMs into an EC2 autoscaling group.
* Container orchestration
  * e.g. Deploy containers into a Kubernetes cluster.
  * Instead of using basic yaml for Kubernetes management, use Helm, OpenTofu (with the Kubernetes provider), or Kustomize which support loops, conditionals and other programming language features that support code re-use.
  * You also generally don't want to be handwriting from scratch all your own IaC; instead, leverage things like official modules in the Terraform Registry or the [Google Cloud Foundation Toolkit](https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit). Modules for AWS and Azure are:
    * [Terraform AWS modules](https://github.com/terraform-aws-modules)
    * [Azure Verified modules](https://github.com/Azure/Azure-Verified-Modules)
* Serverless orchestration
  * e.g. Deploy functions using AWS Lambda.
  * Originally this was FaaS (Functions as a Service): Upload a deployment package to a cloud provider, and have the package execute in response to a certain event like a HTTP request.
  * Good for background jobs, event processing, and simple web apps. Not really suited for complex web apps.
* While Container and Serverless orchestration tools offer a lot of advantages, don't be naive to their disadvantages, e.g. Complexity, opaqueness when debugging.

## Chapter 4: How to version, build and test your code

* Commits and PRs should be atomic.
* It can be a good idea to enforce signed commits, where commits are validated through GPG or SSH keys.
* Protect your branches.

## Chapter 5: How to set up continuous integration and continuous delivery

Key ideas:

* Trunk based development
* Feature toggles
* Deployment strategies

OIDC, Github Actions

## Chapter 6: How to work with multiple environments and teams

Key ideas:

* Multiple environments/libraries/services

AWS IAM, Kubernetes

## Chatpter 7: How to set up networking

Key ideas:

* Set up DNS
* Set up VPCs
* Network access and hardening
* Service discovery and meshes

Route 53, AWS custom VPC, Istio

## Chapter 8: How to secure communication and storage

Key ideas:

* Cryptography
* Encryption at rest
* Encryption in transit

AES, RSA, AWS Secrets Manager, Let's Encrypt

## Chapter 9: How to store data

Key ideas:

* Relational databases
* NoSQL, NewSQL, queues, streams
* File storage and CDN's
* Backup and recovery

RDS, Postgres, Knex.js, S3, CloudFront

## Chapter 10: How to monitor your systems

Key ideas:

* Logs and log aggregation
* Metrics, dashboards, alerts
* Observability and tracing

Node.js, CloudWatch, Route 53

## Chapter 11: The future of DevOps and software delivery

Key ideas:

* Infrastructureless
* Generative AI
* Supply chain security
* Platform Engineering

Runme, Snyk, Chainguard, Backstage
