import typing
from aws_cdk import (
    # Duration,
    Environment,
    IStackSynthesizer,
    PermissionsBoundary,
    RemovalPolicy,
    CfnOutput,
    Stack,
    aws_ec2 as ec2,
    aws_iam as iam,
    aws_s3 as s3,
    aws_sagemaker as sagemaker
)

from constructs import Construct
from dataclasses import dataclass
from .notebook import (
    NotebookLab,
    NotebookProps
)

from .sm_studio import (
    SageMakerStudio,
    SageMakerStudioProps
)

@dataclass
class SageMakerLabProps:
    vpc: ec2.Vpc
    sg_id: str


class SageMakerLab(Stack):

    def __init__(self, scope: Construct, construct_id: str, 
                 props: SageMakerLabProps, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # self._notebook = NotebookLab(
        #     self, "NotebookLab",
        #     props=NotebookProps(
        #         vpc=props.vpc,
        #         sg_id=props.sg_id
        #     )
        # )

        # For some reason can't connect to Studio
        # difficalt to delete stack
        self._studio = SageMakerStudio(
            self, "SageMakerStudio",
            SageMakerStudioProps(
                vpc=props.vpc,
                sg_id=props.sg_id
            )
        )
        
        
        # CfnOutput(self,"notebook_instance", value=self._notebook_instance)

