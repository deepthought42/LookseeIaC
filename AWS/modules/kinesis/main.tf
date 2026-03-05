resource "aws_kinesis_stream" "this" {
  for_each         = toset(var.stream_names)
  name             = "${var.environment}-${each.value}"
  shard_count      = 1
  retention_period = 24

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-${each.value}"
  })
}
