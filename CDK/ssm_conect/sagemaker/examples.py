        # vpc = ec2.Vpc.from_lookup(
        #     self, "vpc-workshop",
        #     is_default=False,
        #     owner_account_id="500480925365",
        #     region="us-east-1",
        #     tags={
        #         "Name": "vpc-workshop-lab",
        #         "aws:cloudformation:stack-name": "BaseVPCStack"
        #     }
        # )

        # print(f"VPC: notebook {vpc.vpc_id} ")
        
        # subnet_selection = vpc.select_subnets(
        #     subnet_type=ec2.SubnetType.PUBLIC
        # )

        # role.add_managed_policy(iam.ManagedPolicy.from_aws_managed_policy_name("AmazonSSMManagedInstanceCore"))
        # ec2.SubnetSelection(subnet_type=ec2.SubnetType.PUBLIC),



        # Securety Group
        # sg_sm_name_id = "SageMakerLab-SG-SM"
        # self._sg_sm = ec2.SecurityGroup(
        #     self, sg_sm_name_id,
        #     vpc = props.vpc_id,
        #     allow_all_outbound=True,
        #     security_group_name=sg_sm_name_id,
        #     description=sg_sm_name_id     
        # )