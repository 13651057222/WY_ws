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
  password              = "Abcd!234"
  image_id              = "${data.alicloud_images.images_ds.images.2.id}"
  internet_charge_type  = "PayByTraffic"
  resource_group_id     = "rg-aek2z7njhung2ka"
  instance_type        = "${data.alicloud_instance_types.c2g4.instance_types.0.id}"
  system_disk_category = "cloud_efficiency"
  security_groups      = ["${alicloud_security_group.default.id}"]
  instance_name        = "wy"
  vswitch_id           = "vsw-2ze4ma7dap6bira0q1ozk"
}

resource "alicloud_security_group" "default" {
  name        = "tf_sg"
  description = "default"
  vpc_id      = "vpc-2zeme4cm4udat3oniyxrz"
}
