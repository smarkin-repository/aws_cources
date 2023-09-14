import os.path

from aws_cdk.aws_s3_assets import Asset
from constructs import Construct
from requests import get

from aws_cdk import (
    # Duration,
    Aspects,
    CfnOutput,
    Tag,
    Stack,
    aws_ec2 as ec2,
    aws_iam as iam,
    aws_autoscaling as asg,
)

dirname = os.path.dirname(__file__)


# Get My external IP address
def get_my_external_ip():
    ip = get('https://api.ipify.org').content.decode('utf8')
    return f"{ip}/32"

    

class BaseVPC(Stack):

    @property
    def vpc(self):
        return self._vpc

    @property
    def asg(self):
        return self._asg

    @property
    def asg_sg(self):
        return self._asg_sg
    
    def create_ssm_endpoint(self, vpc):
        """
            Create ssm endpoint via AWS CDk
            :param vpc:
            :return:
               
        """


    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # VPC
        self._vpc = ec2.Vpc(self, "VPC",
            vpc_name="vpc-workshop",
            ip_addresses=ec2.IpAddresses.cidr("172.30.0.0/24"),
            enable_dns_hostnames=True,
            enable_dns_support=True,
            nat_gateways=0,
            subnet_configuration=[
                ec2.SubnetConfiguration(
                    name="public",
                    subnet_type=ec2.SubnetType.PUBLIC
                ),
                ec2.SubnetConfiguration(
                    name="private",
                    subnet_type=ec2.SubnetType.PRIVATE_WITH_EGRESS
                )
            ]
        )
        Aspects.of(self._vpc).add( Tag("Name", "vpc-workshop-lab"))
        # # Create ssm endpoint via AWS CDk
        # CodeWhisperer doesn't know CDK API documents
        # self._ssm_endpoint = SsmEndpoint(self, "SsmEndpoint", vpc=self._vpc)
        
        # import SG by ID
        security_group = ec2.SecurityGroup.from_security_group_id(
            self, "SG", self._vpc.vpc_default_security_group,
            mutable=False
        )

        ec2.InterfaceVpcEndpoint(self, "VPC Endpoint",
            vpc=self._vpc,
            service=ec2.InterfaceVpcEndpointService(f"com.amazonaws.{self.region}.ssm", 443),
            # Choose which availability zones to place the VPC endpoint in, based on
            # available AZs
            subnets=ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC),
            security_groups=[security_group]
        )

        # AMI
        amzn_linux = ec2.MachineImage.latest_amazon_linux2(
            edition=ec2.AmazonLinuxEdition.STANDARD,
            virtualization=ec2.AmazonLinuxVirt.HVM,
            storage=ec2.AmazonLinuxStorage.GENERAL_PURPOSE
            )

        # Instance Role and SSM Managed Policy
        role = iam.Role(self, "InstanceSSM", assumed_by=iam.ServicePrincipal("ec2.amazonaws.com"))

        role.add_managed_policy(iam.ManagedPolicy.from_aws_managed_policy_name("AmazonSSMManagedInstanceCore"))

        # create security group with whilelist MyIp
        self._asg_sg = ec2.SecurityGroup(
            self, "ASG_SG",
            vpc=self._vpc,
            allow_all_outbound=True,
            description="Security Group for ASG"
        )

        # allow only MyIp
        self._asg_sg.add_ingress_rule(
            peer = ec2.Peer.ipv4(get_my_external_ip()),
            connection=ec2.Port.all_tcp()
        )

        self._asg = asg.AutoScalingGroup(
            self, "ASG",
            vpc = self._vpc,
            vpc_subnets=ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC),
            instance_type=ec2.InstanceType("t2.micro"),
            machine_image=amzn_linux,
            min_capacity=0,
            max_capacity=1,
            desired_capacity=0,
            security_group=self._asg_sg,
            role=role
        )

        CfnOutput(self, "VPC ID", value=self._vpc.vpc_id)
        CfnOutput(self, "ASG ID", value=self._asg.auto_scaling_group_name)
        CfnOutput(self, "ASG SG ID", value=self._asg_sg.security_group_id)
                                         

        # # Script in S3 as Asset
        # asset = Asset(self, "Asset", path=os.path.join(dirname, "configure.sh"))
        # local_path = self._instance.user_data.add_s3_download_command(
        #     bucket=asset.bucket,
        #     bucket_key=asset.s3_object_key
        # )

        # Userdata executes script from S3
        # self._instance.user_data.add_execute_file_command(
        #     file_path=local_path
        #     )
        # asset.grant_read(self._instance.role)

                # Instance
        # self._instance = ec2.Instance(self, "Instance",
        #     instance_type=ec2.InstanceType.of(ec2.InstanceClass.T2, ec2.InstanceSize.MICRO),
        #     machine_image=amzn_linux,
        #     vpc = self._vpc,
        #     role = role,
        #     vpc_subnets=ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC)
        # )