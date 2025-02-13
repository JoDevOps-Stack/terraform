variable "project" {
    default = "expense"
}

variable "environment" {

}
variable "instances" {
    default = ["mysql", "backend", "frontend"]
}

variable "zone_id" {
    default = "Z0946373TECVA3VZONGV"
}

variable "domain_name" {
    default = "daws82.cick"
}

variable "common_tags" {
    type = map
    default = {
        project = "expense"
    }
}