output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "transfer_server_endpoint" {
  value = aws_transfer_server.transfer_server.endpoint
}