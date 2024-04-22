// WAF for APIs
resource "aws_wafv2_web_acl" "api-waf" {
  name        = var.name
  description = "WAF for the API Gateway"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "my-api-waf"
    sampled_requests_enabled   = true
  }

  rule {
    name     = "my-api-aws-managed-rules-common-rule-set"
    priority = 0

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "my-api-aws-managed-rules-common-rule-set"
      sampled_requests_enabled   = true
    }
  }
  
  tags = var.tags

  // Other Rules for the WAF
  #   rule {
  #     name     = "my-api-aws-managed-rules-ip-reputation-list"
  #     priority = 2

  #     override_action {
  #       none {}
  #     }

  #     statement {
  #       managed_rule_group_statement {
  #         name        = "AWSManagedRulesAmazonIpReputationList"
  #         vendor_name = "AWS"
  #       }
  #     }

  #     visibility_config {
  #       cloudwatch_metrics_enabled = true
  #       metric_name                = "my-api-aws-managed-rules-ip-reputation-list"
  #       sampled_requests_enabled   = true
  #     }
  #   }
}
