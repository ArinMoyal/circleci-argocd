package test

import (
        "fmt"
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestEKSCluster(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../",
	}

	// defer terraform.Destroy(t, terraformOptions)
	terraform.Init(t, terraformOptions)
	terraform.Validate(t, terraformOptions)
	planOutput := terraform.Plan(t, terraformOptions)

	assert.Contains(t, planOutput, "eks_cluster", "The plan should contain an EKS cluster resource")
	assert.Contains(t, planOutput, "eks_cluster_name", "The plan should contain the eks_cluster_name output")
	assert.Contains(t, planOutput, "eks_cluster_endpoint", "The plan should contain the eks_cluster_endpoint output")
	assert.Contains(t, planOutput, "Plan:", "The plan should not propose destroying resources unless intended")
}
