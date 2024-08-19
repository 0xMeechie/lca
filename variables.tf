variable "vpc_cidr" {
  description = "cidr block for the vpc"
  type        = string
  default     = "10.0.0.0/16"

}

variable "environment" {
  description = "environment of the cluster"
  type        = string
  default     = "dev"

}

variable "region" {
  description = "deployment region"
  type        = string
  default     = "us-east-1"

}
variable "azs" {

  description = "List of Azs to deploy into"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]

}


##################
## RDS Variables##
##################

variable "db_instance_class" {
  description = "Instance class for the database"
  type        = string
  default     = "db.t3.micro"
}

variable "max_storage" {
  description = "max amount of space for the database"
  type        = number
  default     = 60
}

variable "db_name" {
  description = "name of the database"
  type        = string
  default     = "testdb"

}

variable "db_engine" {
  description = "Engine that is being used for the db"
  type        = string
  default     = "mysql"

}

variable "db_engine_version" {
  description = "version of the engine"
  type        = string
  default     = "8.0.35"

}

variable "db_username" {
  description = "master username for the databse"
  type        = string
  default     = "foobar"
}


##################
## ECS Variables##
##################

variable "ecs_cluster_name" {
  description = "name for the ecs cluster"
  type        = string
  default     = "test-cluster"

}

variable "ecs_service_name" {
  description = "name of the service that is being deployed"
  type        = string
  default     = "wordpress"

}


