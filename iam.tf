data "aws_iam_policy_document" "transfer_role" {

  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "transfer_server" {
  name               = format("%s-transfer-server-iam-role", var.transfer_server_name)
  assume_role_policy = data.aws_iam_policy_document.transfer_role.json
}

data "aws_iam_policy_document" "s3_permission" {

  statement {
    sid    = "HomeDirObjectAccess"
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObjectVersion",
      "s3:GetObjectACL",
      "s3:PutObjectACL"
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this.id}/*",
      "arn:aws:s3:::${aws_s3_bucket.this.id}"
    ]
  }
}

resource "aws_iam_role_policy" "transfer_server" {
  name = format("%s-transfer-server-iam-policy", var.transfer_server_name)
  role = aws_iam_role.transfer_server.id

  policy = data.aws_iam_policy_document.s3_permission.json
}

resource "aws_iam_role" "transfer_logs" {
  name               = format("%s-transfer-server-logs-iam-role", var.transfer_server_name)
  assume_role_policy = data.aws_iam_policy_document.transfer_role.json
}

data "aws_iam_policy_document" "logs" {

  statement {
    sid    = "AllowFullAccesstoCloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role_policy" "transfer_logs" {
  name = format("%s-transfer-server-iam-logs-policy", var.transfer_server_name)
  role = aws_iam_role.transfer_logs.id

  policy = data.aws_iam_policy_document.logs.json
}

