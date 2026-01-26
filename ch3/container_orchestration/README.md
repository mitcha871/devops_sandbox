# Minikube detour

To run Kubernetes locally, there seem to be a few options.

* On Windows, just use Docker Desktop
* On Linux, minikube or kind are options. minikube is reportedly "batteries included" so I chose this.

[Minikube Quick Start](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fdebian+package)

Separately, I also needed to install kubectl.

Also, fun reading: [Comparing the top eight managed Kubernetes providers](https://medium.com/@elliotgraebert/comparing-the-top-eight-managed-kubernetes-providers-2ae39662391b)

```
minikube start
minikube stop
minikube status
minikube node add
minikube node delete
minikube pause
minikube resume
```

__Minikube gotchas__

* Minikube has it's own internal Docker registry! To run a local image, you need to add it: `minikube image load sample-node-app:latest`
* To access a service hosted by Minikube, use the Minikube IP address `minikube ip` followed by the IP address the service was assigned (e.g. 30215 - this will not be the same as what's defined in the service yaml).
  * This is because in the real world, a LoadBalancer would create a real load balancer with a real public IP address - Minikube doesn't have that so it virtualizes it.

__Why containers?__

* Speed: Containers build and deploy faster than VMs.
* Efficiency: Container orchestration tools have built in schedulers, using bin packing algorithms to use available resources in the most efficient manner.
* Portability: Docker and Kubernetes are open source, and containers are supported just about everywhere.
* Local development: Containers for use in local development are lightweight and simple.
* Functionality: Container orchestration tools have solved more orchestration tools out of the box than VM orchestration tools e.g.  deployment, updates, auto scaling/healing, secret management, service discovery, disk management.

Orchestration is not just Kubernetes. Other orchestration tools include: Nomad, ECS, OpenShift.

```
kubectl apply -f sample-app-deployment.yaml
kubectl destroy -f sample-app-deployment.yaml
```

Kubernetes has built-in support for load balancing via a Kubernetes object called a Service. In the real world this would be a real GCP or AWS Load Balancer with a public IP address.

Note if you change the name of a Deployment or service, it will orphan the existing object and just create a new one with the new name!
