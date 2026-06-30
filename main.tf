# 1. Вызываем наш локальный модуль VPC
module "vpc_dev" {
  source   = "./vpc"
  env_name = var.vpc_name
  zone     = var.default_zone
  cidr     = var.default_cidr[0]
}

# 2. Remote-модуль для marketing ВМ
module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name       = "marketing"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "marketing-web-${terraform.workspace}"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    owner   = "sharov.o"
    project = "marketing"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# 3. Remote-модуль для analytics ВМ
module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name       = "analytics"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.subnet_id]
  instance_name  = "analytics-web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    owner   = "sharov.o"
    project = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

# 4. Передаём cloud-config в ВМ
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  
  vars = {
    ssh_public_key = var.vms_ssh_root_key
  }
}
