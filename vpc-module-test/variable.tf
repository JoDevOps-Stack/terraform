variable "project_name" {          
    default = "expense"
}

variable "environment" {
   default = "dev"     
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
    default = true 
}

#so here giving mandatory
variable "common_tags" {
    default = {
        project = "expense"
        environment = "dev"
        terraform = "true"
    }
}

variable "vpc_tags" {
    default = {
        purpose = "assignent"
    }
}

variable "public_subnet_cidrs" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
    
variable "private_subnet_cidrs" {
    default = ["10.0.11.0/24", "10.0.12.0/24"]
}
    
variable "database_subnet_cidrs" {
    default = ["10.0.21.0/24", "10.0.22.0/24"]
}
    