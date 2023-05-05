output "private_ip_a" {
  value = aws_instance.instance_a.private_ip
}

output "private_ip_b" {
  value = aws_instance.instance_b.private_ip
}

output "public_dns_a" {
  value = aws_instance.instance_a.public_dns
}


output "public_dns_b" {
  value = aws_instance.instance_b.public_dns
}

output "region" {
  value = var.region
}

output "instance_type" {
  value = var.instance_type
}

output "elastic_ip_a" {
  value = aws_eip_association.eip_assoc.public_ip
}

output "elastic_ip_b" {
  value = aws_eip_association.eip_assoc2.public_ip
}

output "aws_rds_cluster" {
  value = aws_rds_cluster.db_bootcamp.arn
}

# output "endpoint_db" {
#   value = aws_rds_cluster_instance.db_bootcamp.endpoint
# }

output "bucket" {
  value = aws_s3_bucket.bootcamp-s3.bucket_regional_domain_name
}