############################################################################################################
## Cognito User Pool
############################################################################################################
resource "aws_cognito_user_pool" "pool" {
  name = var.pool_name

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }
  auto_verified_attributes = ["email"]

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "client" {
  name                                 = "client"
  allowed_oauth_flows_user_pool_client = true
  generate_secret                      = false
  allowed_oauth_scopes                 = ["aws.cognito.signin.user.admin", "email", "openid", "profile"]
  allowed_oauth_flows                  = ["implicit", "code"]
  explicit_auth_flows                  = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
  supported_identity_providers         = ["COGNITO"]

  user_pool_id  = aws_cognito_user_pool.pool.id
  callback_urls = [var.callback_urls]
  logout_urls   = [var.logout_urls]
}

# Create a Cognito User to test the API
resource "aws_cognito_user" "example" {
  user_pool_id = aws_cognito_user_pool.pool.id
  username     = "flpmireles"
  password     = "Test@123"

  attributes = {
    email          = "my@gmail.com"
    email_verified = true
  }
}
