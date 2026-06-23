# Домашнее задание: Продвинутые методы работы с Terraform - Шаров Олег

## 🎯 Задание 1: Работа с remote-модулями

### Что сделано:
- ✅ Созданы 2 ВМ через remote-модуль (marketing и analytics)
- ✅ Использованы labels для обозначения проектов
- ✅ SSH-ключ передаётся через переменную (не хардкод)
- ✅ В cloud-init.yml добавлена установка nginx
- ✅ ВМ прерываемые (preemptible = true) для экономии средств

### Файлы:
- `main.tf` — конфигурация с вызовами remote-модулей
- `cloud-init.yml` — шаблон настройки ВМ (пользователь ubuntu, nginx)
- `marketing_vm_output.txt` — вывод terraform console для module.marketing_vm

### Скриншоты:
 Подключение по SSH и проверка nginx
![Скрин](screenshots/task1_vm_console_with_nginx.png)

Консоль Yandex Cloud с метками ВМ
![Скрин](screenshots/task1_yc_vm_with_labels.png) 
---

## 🎯 Задание 2: Создание локального модуля VPC

### Что сделано:
- ✅ Создан локальный модуль `vpc` с сетью и подсетью
- ✅ Модуль принимает переменные: env_name, zone, cidr
- ✅ Модуль возвращает outputs: network_id, subnet_id
- ✅ Корневой модуль использует `module.vpc_dev`
- ✅ Сгенерирована документация через terraform-docs

### Структура модуля:
```
vpc/
├── main.tf         # Ресурсы сети и подсети
├── variables.tf    # Переменные модуля
├── outputs.tf      # Выходные значения (network_id, subnet_id)
└── README.md       # Автогенерированная документация
```

### Скриншоты:

Вывод terraform console для module.vpc_dev
![Скрин](screenshots/task2_vpc_dev_console.png) 

