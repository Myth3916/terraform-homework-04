terraform {
  required_version = ">= 1.12.0"

  backend "s3" {
    bucket  = "oleg-sharov-tfstate-2026" # Имя моего bucket
    key     = "terraform.tfstate"       # Путь к файлу state внутри bucket
    region  = "ru-central1"
    
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    
    # Встроенный механизм блокировок (Terraform >= 1.6)
    use_lockfile = true
    
       
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true   # <-- ДОБАВЛЕНО (важно для YC)
    skip_s3_checksum            = true
  }

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.193.0" 
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
}


provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}