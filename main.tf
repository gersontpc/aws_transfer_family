resource "aws_transfer_server" "transfer_server" {

  identity_provider_type = var.identity_provider_type
  protocols              = var.protocols
  force_destroy          = var.force_destroy
  security_policy_name   = var.security_policy_name
  logging_role           = aws_iam_role.transfer_logs.arn

  tags = merge(
    var.tags,
    {
      Name = var.transfer_server_name
    },
  )
}

resource "aws_transfer_user" "this" {

  count = length(var.transfer_user)

  server_id = aws_transfer_server.transfer_server.id
  user_name = var.transfer_user[count.index].user_name
  role      = aws_iam_role.transfer_server.arn

  home_directory_type = var.home_directory_type
  home_directory_mappings {
    entry  = "/"
    target = "/${aws_s3_bucket.this.id}/$${Transfer:UserName}"
  }

  depends_on = [
    aws_s3_bucket.this
  ]

}

resource "aws_transfer_ssh_key" "this" {

  count = length(var.transfer_user)

  server_id = aws_transfer_server.transfer_server.id
  user_name = aws_transfer_user.this[count.index].user_name
  body      = var.transfer_user[count.index].ssh_key
}
