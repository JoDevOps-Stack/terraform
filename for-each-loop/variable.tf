variable "instances" {
    type = map
    default = {
        mysql = "t3.small" # here i want more for database for that i have taken t3.small
        backend = "t3.micro"
        frontend = "t3.micro"
    }
}

variable "domain_name" {
    default = "daws82.cick"
}

variable "zone_id" {
    default = "Z0946373TECVA3VZONGV"
}