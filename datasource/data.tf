data "aws_ami" "joindevops" {   # - syntax here "joindevops" name 
    most_recent = true
    owners      = ["973714476881"]
    
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"    
        values = ["ebs"]                 # default values 
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]                  # default values
    }
}
 data "aws_vpc" "default" {
   default = true                #for default vpc
 }                                


output  "ami_id" {            #to show output
  value       = data.aws_ami.joindevops.id
}

output "default_vpc_id" {
    value = data.aws_vpc.default.id
}