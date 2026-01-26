module "sample-app-eks" {
  source = "./eks"
  name = "sample-app-eks"
  min_worker_nodes = 3
  max_worker_nodes = 10
  eks_version = "1.34"
  instance_type = "t3.micro"
}

module "sample-app-ecr" {
  source = "./ecr"
  name = "sample-node-app"
}
