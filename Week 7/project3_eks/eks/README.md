## Install Terraform

curl -O https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_amd64.zip
unzip terraform_1.5.7_linux_amd64.zip
mkdir -p ~/bin
mv terraform ~/bin/
terraform version



## Provision the infrastructure

terraform init
terraform plan
terraform apply


This may take up to 10 minutes to complete. When it completes, you will see something similar to this at the end of all the output. You will need the value of `NodeInstanceRole` later.

```
Outputs:

NodeAutoScalingGroup = "demo-eks-stack-NodeGroup-UUJRINMIFPLO"
NodeInstanceRole = "arn:aws:iam::387779321901:role/demo-eks-node"
NodeSecurityGroup = "sg-003010e8d8f9f32bd"
```

## Set up access and join nodes

Do the following at the CloudShell command line

1.  Create a KUBECONFIG for `kubectl`

    aws eks update-kubeconfig --region us-east-1 --name demo-eks

1.  Join the worker nodes

    1. Download the node authentication ConfigMap
        curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/aws-auth-cm.yaml

    1.  Edit the ConfigMap YAML to add in the `NodeInstanceRole` we got from terraform

        vi aws-auth-cm.yaml

        Delete the text `<ARN of instance role (not instance profile)>` and replace it with the value for `NodeInstanceRole` we got from terraform, then save and exit.

 
        apiVersion: v1
        kind: ConfigMap
        metadata:
        name: aws-auth
        namespace: kube-system
        data:
        mapRoles: |
            - rolearn: <ARN of instance role (not instance profile)> # <- EDIT THIS
            username: system:node:{{EC2PrivateDNSName}}
            groups:
                - system:bootstrappers
                - system:nodes


    1.  Apply the edited ConfigMap to join the nodes

        kubectl apply -f aws-auth-cm.yaml

        Wait 2-3 minutes for node join to complete, then

        kubectl get node -o wide

        You should see 3 worker nodes in ready state. Note that with EKS you do not see control plane nodes, as they are managed by AWS.

1.  View the completed cluster in the [EKS Console](https://us-east-1.console.aws.amazon.com/eks/home?region=us-east-1).