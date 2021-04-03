package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraBaseInfra(t *testing.T) {
	t.Parallel()

	// expectedText := "test"
	// expectedList := []string{expectedText}
	// expectedMap := map[string]string{"expected": expectedText}

	terraformOptions := &terraform.Options{
		// website::tag::1::Set the path to the Terraform code that will be tested.
		// The path to where our Terraform code is located
		TerraformDir: "..",

		// Variables to pass to our Terraform code using -var options
		// Vars: map[string]interface{}{
		// 	"example": expectedText,

		// 	// We also can see how lists and maps translate between terratest and terraform.
		// 	"example_list": expectedList,
		// 	"example_map":  expectedMap,
		// },

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"varfile.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// website::tag::4::Clean up resources with "terraform destroy". Using "defer" runs the command at the end of the test, whether the test succeeds or fails.
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::2::Run "terraform init" and "terraform apply".
	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualVpcID := terraform.Output(t, terraformOptions, "vpc_id")
	actualPublicSubnetID := terraform.Output(t, terraformOptions, "public_subnet_id")
	actualPrivateSubnetID := terraform.Output(t, terraformOptions, "private_subnet_id")
	actualNatID := terraform.Output(t, terraformOptions, "nat_gw_id")
	actualSecGroupID := terraform.Output(t, terraformOptions, "sg_lb_id")
	actualLBArb := terraform.Output(t, terraformOptions, "lb_arn")

	// website::tag::3::Check the output against expected values.
	assert.NotNil(t, actualVpcID)
	assert.NotNil(t, actualPublicSubnetID)
	assert.NotNil(t, actualPrivateSubnetID)
	assert.NotNil(t, actualNatID)
	assert.NotNil(t, actualSecGroupID)
	assert.NotNil(t, actualLBArb)
}
