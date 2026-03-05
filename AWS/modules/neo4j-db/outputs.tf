output "private_ip" { value = aws_instance.neo4j.private_ip }
output "bolt_uri" { value = "bolt://${aws_instance.neo4j.private_ip}:7687" }
