# Домашнее задание: Продвинутые методы работы с Terraform - Шаров Олег

---

## 🎯 Задание 1: Работа с remote-модулями

### Что сделано:
- ✅ Созданы 2 ВМ через remote-модуль `yandex_compute_instance` (marketing и analytics)
- ✅ Использованы labels для обозначения проектов (`project = "marketing"`, `project = "analytics"`)
- ✅ SSH-ключ передаётся через переменную `vms_ssh_root_key` (не хардкод)
- ✅ В cloud-init.yml добавлена установка nginx
- ✅ ВМ прерываемые (`preemptible = true`) для экономии средств
- ✅ Пользователь для подключения: `ubuntu`

### Файлы:
- `main.tf` — конфигурация с вызовами remote-модулей
- `cloud-init.yml` — шаблон настройки ВМ (пользователь ubuntu, nginx)
- `marketing_vm_output.txt` — вывод terraform console для module.marketing_vm

### Скриншоты:
- ![Скрин](screenshots/task1_vm_console_with_nginx.png) — подключение по SSH и проверка nginx
- ![Скрин](screenshots/task1_yc_vm_with_labels.png) — консоль Yandex Cloud с метками ВМ

---

## 🎯 Задание 2: Создание локального модуля VPC

### Что сделано:
- ✅ Создан локальный модуль `vpc` с сетью и подсетью
- ✅ Модуль принимает переменные: `env_name`, `zone`, `cidr`
- ✅ Модуль возвращает outputs: `network_id`, `subnet_id`
- ✅ Корневой модуль использует `module.vpc_dev`
- ✅ Сгенерирована документация через `terraform-docs`

### Структура модуля:
```
vpc/
├── main.tf         # Ресурсы сети и подсети
├── variables.tf    # Переменные модуля
├── outputs.tf      # Выходные значения (network_id, subnet_id)
└── README.md       # Автогенерированная документация
```

### Скриншоты:
- ![Скрин](screenshots/task2_vpc_dev_console.png) — вывод terraform console для module.vpc_dev

---

## 🎯 Задание 3: Работа со state (импорт/экспорт)

### Что сделано:
- ✅ Удалены модули из state через `terraform state rm`
- ✅ Получены ID ресурсов из Yandex Cloud
- ✅ Импортированы ресурсы обратно через `terraform import`
- ✅ Проверен `terraform plan` — значимых изменений нет

### Процесс:
1. Удаление из state: `terraform state rm module.vpc_dev`, `module.marketing_vm`, `module.analytics_vm`
2. Получение ID: `yc vpc network list`, `yc vpc subnet list`, `yc compute instance list`
3. Импорт: `terraform import module.vpc_dev.yandex_vpc_network.network <ID>`
4. Проверка: `terraform plan` → `Plan: 0 to add, 2 to change, 0 to destroy`

### Скриншоты:
- ![Скрин](screenshots/task3_state_rm.png) — процесс удаления модулей из state
- ![Скрин](screenshots/task3_import_vm.png) — импорт ВМ
- ![Скрин](screenshots/task3_import_vpc.png) — импорт сети и подсети
- ![Скрин](screenshots/task3_terraform_plan.png) — финальная проверка plan

---

## 🚀 Как запустить

1. Клонировать репозиторий:
```bash
git clone <URL_репозитория>
cd terraform-homework-04
```

2. Создать файл `personal.auto.tfvars`:
```hcl
token     = "your_oauth_token"
cloud_id  = "your_cloud_id"
folder_id = "your_folder_id"
vms_ssh_root_key = "your_ssh_public_key"
```

3. Инициализировать и применить:
```bash
terraform init
terraform apply
```

4. Подключиться к ВМ:
```bash
ssh ubuntu@<public_ip>
sudo nginx -t
```

---

## 🧹 Удаление ресурсов

```bash
terraform destroy
```

---

## 📚 Документация модулей

- [Документация модуля VPC](./vpc/README.md)

---