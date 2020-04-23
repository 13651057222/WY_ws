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
