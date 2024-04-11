variable vpc_cidr_block {
    default = "10.0.0.0/16"
}
variable subnet_cidr_block {
    default = "10.0.10.0/24"
}

variable avail_zone {
    default = "us-west-1a"
}

variable instance_type {
    default = "t2.micro"
}

variable jenkins_ip {
    default = "54.183.147.139/32"
}

variable region {
    default = "us-west-1"
}
