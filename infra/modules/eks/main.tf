#Creating with EKS module from terraform registry
#https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest

module "eks_al2023" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${var.tags["Environment"]}-eks2"
  kubernetes_version = "1.33"

  # Enable accessing cluster from anywhere
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  authentication_mode = "API_AND_CONFIG_MAP"
  

  # EKS Addons
  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  self_managed_node_groups = {
    example = {
      ami_type      = "AL2023_x86_64_STANDARD"
      instance_type = "t3.medium"

      min_size = 1
      max_size = 3
      # This value is ignored after the initial creation
      # https://github.com/bryantbiggs/eks-desired-size-hack
      desired_size = 2

      # This is not required - demonstrates how to pass additional configuration to nodeadm
      # Ref https://awslabs.github.io/amazon-eks-ami/nodeadm/doc/api/
      cloudinit_pre_nodeadm = [
        {
          content_type = "application/node.eks.aws"
          content      = <<-EOT
            ---
            apiVersion: node.eks.aws/v1alpha1
            kind: NodeConfig
            spec:
              kubelet:
                config:
                  shutdownGracePeriod: 30s
          EOT
        }
      ]
    }
  }


    tags = merge(
        var.tags,              
        { Name = "${var.tags["Environment"]}-eks2" }  
    )
}


resource "aws_security_group" "k8s-node-sg-default" {
  name        = "${var.tags["Environment"]}-sg-group"
  vpc_id      = var.vpc_id
  description = "Managed by Terraform"

  tags = {
    Environment                                 = "sandbox"
    Team                                        = "DevOps"
    Terraform                                   = "true"
    "kubernetes.io/cluster/${module.eks_al2023.cluster_name}" = "owned"
  }
}

# Kubernetes node additional security group rules

resource "aws_security_group_rule" "k8s-node-sg-allow-ssh-connections" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
  cidr_blocks       = var.subnet_cidr
  security_group_id = aws_security_group.k8s-node-sg-default.id
}