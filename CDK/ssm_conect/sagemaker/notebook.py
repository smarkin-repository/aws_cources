import typing
from aws_cdk import (
    # Duration,
    RemovalPolicy,
    CfnOutput,
    aws_ec2 as ec2,
    aws_iam as iam,
    aws_s3 as s3,
    aws_sagemaker as sagemaker
)

from constructs import Construct
from dataclasses import dataclass

@dataclass
class NotebookProps:
    vpc: ec2.Vpc
    sg_id: str


class NotebookLab(Construct):

    @property
    def notebook_instance(self):
        return self._notebook_instance
    
    def __init__(self, scope: Construct, construct_id: str, 
                 props: NotebookProps, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)


        # S3 bucket 
        self._s3_sm_bucket = s3.Bucket(
            self, "BucketSMlab",
            block_public_access=s3.BlockPublicAccess.BLOCK_ALL,
            # encryption=s3.BucketEncryption.KMS_MANAGED,
            enforce_ssl=True,
            versioned=True,
            removal_policy=RemovalPolicy.DESTROY,
            # lifecycle_rules=[]
            bucket_name="aws-sm-sagemaker-lab-bucket"
        )

        # IAM Role access to s3 bucket for notebook
        self._sm_iam_role = iam.Role(
            self, "notebook-lab-access-role",
            role_name="notebook-lab-role",
            assumed_by=iam.ServicePrincipal("sagemaker.amazonaws.com")
        )

        _statement_s3 = iam.PolicyStatement(
            actions=[
                's3:*',
            ],
            resources=[
                '*',
            ]
        )

        _statement_repo = iam.PolicyStatement(
            actions=[
                'codecommit:GitPull',
                'codecommit:GitPush'
            ],
            resources=[
                '*',
            ]
        )


        self._sm_role_policy = iam.Policy(
            self, "notebook-lab-access-policy",
            policy_name="notebook-lab-access-policy",
            statements=[_statement_s3,_statement_repo]
        )
        self._sm_role_policy.attach_to_role(self._sm_iam_role)

        # SageMaker
        sg_name_id = "SageMakerLab-ML-t2"

        subnet_ids =[ subnet.subnet_id for subnet in props.vpc.public_subnets ]
        self._notebook_instance = sagemaker.CfnNotebookInstance(
            self, sg_name_id,
            instance_type="ml.t2.medium",
            role_arn=self._sm_iam_role.role_arn,
            # subnet_id=subnet_selection.subnet_ids[0],
            subnet_id=subnet_ids[0],
            security_group_ids=[props.sg_id],
            volume_size_in_gb=5,
            notebook_instance_name=sg_name_id,
            default_code_repository="",
            additional_code_repositories="",
        )

        # CfnOutput(self,"notebook_instance", value=self._notebook_instance)
        # https://docs.aws.amazon.com/sagemaker/latest/dg/nbi-git-resource.html
