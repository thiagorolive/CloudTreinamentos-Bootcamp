#
# criação do cluster banco de dados RDS
#

resource "aws_rds_cluster" "db_bootcamp" {
  cluster_identifier      = "bootcamp"
  availability_zones      = ["us-west-1b", "us-west-1c"]
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.2"
  master_username         = "admin"
  master_password         = "1234567890"
  database_name           = "app_bootcamp"
  backup_retention_period = 5
  preferred_backup_window = "00:00-03:00"
  skip_final_snapshot     = true

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

#
# criação das instancia no cluster
#
resource "aws_rds_cluster_instance" "db_bootcamp" {
  count              = 2
  cluster_identifier = aws_rds_cluster.db_bootcamp.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.db_bootcamp.engine
  engine_version     = aws_rds_cluster.db_bootcamp.engine_version
}

