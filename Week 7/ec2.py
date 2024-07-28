import boto3
ec2 = boto3.resource('ec2')

instances = ec2.create_instances(
        ImageId="ami-04b70fa74e45c3917",
        MinCount=1,
        MaxCount=1,
        InstanceType="t2.micro"
    )
