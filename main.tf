variable "access_key" {
  //type = string
}

variable "secret_key" {
  //type = string
}

variable "region" {
  //type = string
}

provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  version    = "~> 1.76"
  region     = "${var.region}"
}

data "alicloud_regions" "current_region_ds" {
}

data "alicloud_instance_types" "c2g4" {
  cpu_core_count = 2
  memory_size    = 4
}

data "alicloud_images" "images_ds" {
  owners     = "system"
  name_regex = "^centos_7"
  output_file = "./image.file"
}

output "first_image_id" {
  value = data.alicloud_images.images_ds.images.2.id
  description = "aaaa"
}

output "region" {
  value = "${var.region}"
}

resource "alicloud_instance" "wy" {
  host_name             = "tf_host"
  password              = "Abcd!234"
  image_id              = "${data.alicloud_images.images_ds.images.2.id}"
  internet_charge_type  = "PayByTraffic"

  instance_type        = "${data.alicloud_instance_types.c2g4.instance_types.0.id}"
  system_disk_category = "cloud_efficiency"
  security_groups      = ["${alicloud_security_group.default.id}"]
  instance_name        = "web"
  vswitch_id           = "vsw-abc12345"
}

resource "alicloud_security_group" "default" {
  name        = "default"
  description = "default"
  vpc_id      = "vpc-bp110ctzj23qp97c4c8wq"
}
