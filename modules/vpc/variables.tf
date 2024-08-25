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

}


