provider "aws"{
region="ap-south-1"
}
resource "aws_db_instance" "abhidb" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  name                 = "dbs"
  username             = "Abhishek"
  password             = "Abhishek123"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  =true
  iam_database_authentication_enabled = true


tags={
 Name="wordpresssqldb"
}
}
}