# Fundamentals of DevOps and Software Delivery O'Reilly workbook

## Chapter 1: How to deploy your app

Key ideas:

* On-prem vs cloud
* PaaS
  * Platform as a Service examples include: Heroku, Render, Fly.io and Vercel.
  * For these examples, _Render_ is selected as it offers a free Hobby tier.
    * For a trivial web app you can simply point Render to a public repository (or sign in with Github) and it will build the image and deploy it.
    * It also allows non-service workloads like jobs and cron, and private connectivity to AWS.
    * Paid services include Metrics and Logs streaming (OpenTelemetry).
    * PaaS providers do not offer the range of services that IaaS providers offer, but are simpler and likely cheaper; at a small scale you don't need IaaS.
      * As a general principle you should spend as little time and money on software delivery as you possibly can while still meeting requirements.
* IaaS
  * Infrastructure as a Service examples include: Hetzner, DigitalOcean, Vultr, and Akamai.
    * Non big 3 will be cheaper.
  * IaaS is a better fit as these grow: load, company size, availability demands, security and compliance demands.
    * Infrastructure and software delivery processes should grow with the company and be the right complexity to meet the needs of the company.
  * Consider vendor lock-in clear eyed. It is plausibly the case that avoiding the use of proprietary solutions will slow down your deployment, and not pay for itself if you ever try to move.
    * But, for most new projects, cloud is the way to go.

## Chapter 2: How to manage your IaS

Key ideas:

* Scripts & configuration management tools
* Server templating tools
* Provisioning tools

Bash, Ansible, OpenTofu, Packer, EC2, AMI

## Chapter 3: How to manage your apps by using orchestration tools

Key ideas:

* Server/Container/VM/Serverless orchestration

Ansible, OpenTofu, Docker, Kubernetes, ASG, ALB, Lamdba

## Chapter 4: How to version, build and test your code

Key ideas:

* Version control
* Build systems
* Dependency management
* Automated testing

Github, npm, Node.js, OpenTofu

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
