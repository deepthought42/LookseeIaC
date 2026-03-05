output "stream_arns" {
  value = { for name, stream in aws_kinesis_stream.this : name => stream.arn }
}

output "stream_names" {
  value = { for name, stream in aws_kinesis_stream.this : name => stream.name }
}
