variable "instances" {
 default = ["mysql" , "backend" , "frontend"]
}

variable "zone_id" {
    default = "Z0946373TECVA3VZONGV"
}

variable "domain_name"{
    default = "daws82.click"
}

variable "common_tags" {
    type = map 
    default = {
        project = "expense"
        environment = "dev"
    }
}