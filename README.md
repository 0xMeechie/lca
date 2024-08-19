
# Limble IaC 

This is just a simple terraform project that provisions a vpc , ecs cluster and database. With  three subnets for each subnet group (public, data , and service). The data subnet holds the database. Service holds the ECS cluster and the public subnet is where the load balancer resides. Each Subnet is is spread across three AZs for high availability. 




## Requirements
- Terraform installed on your PC
- An AWS Account
- AWS CLI creds


## Deployment

To deploy this project run

```bash
  Terraform plan
  Terraform apply 
```

