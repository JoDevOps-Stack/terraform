variable "instances" {
    type = map
    default = {
        mysql = "t3.small" # here i want more for database for that i have taken t3.small
        backend = "t3.micro"
        frontend = "t3.micro"
    }
}