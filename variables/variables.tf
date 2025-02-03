variable "ami_id" {
    type      = string
    default   = "ami-09c813fb71547fc4f"
    description = "this is rhel9 ami id"
}

variable "instance_type" {
   type      = string
   default   = "t3.micro" 
   description = "type of instance"
}

variable "ec2_tags" {
    type     = map
    default  = { 
        project = "expense"
        component = "backend"
        environment = "dev"
        name = "expense-backend-dev"
}

}

variable "from_port" {
    type = number
    default = 22
}
 
 variable "to_port" {
    type = number
    default = 22
 }

 variable "cidr_blocks" {
    type = list
    default = ["0.0.0.0/0"]
 }

variable "sg_tags" {
    type = map
    default = {
        name = "expense-backend-dev"
    }
}



#variable preference:
#1.command
#2.tfvars
#3.env. variables
#4.default
#5.user prompt
