module "ec2" {
    source = "../terraform-aws-ec2" # refferring terraform-aws-ec2 folder
    sg_id = "sg-0e978039cdb6c3057" #this sg details we can give here or can give variable file of aws -ec2
    instance_type = "t3.micro" # i override it
}
output "public_ip" {
   value =  module.ec2.public_ip
}
