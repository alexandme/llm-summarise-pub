#!/bin/bash
# Переход в каталог text-generation-webui
cd /notebooks/text-generation-webui

# Варианты запуска
echo "Выберите вариант запуска:"
echo "1. Запуск с веб-интерфейсом"
echo "2. Запуск только с API"

read -p "Введите номер варианта (1-2): " choice

case $choice in
    1) python server.py --share --api --model-menu ;;
    2) python server.py --api --model-menu ;;
    *) echo "Неправильный выбор. Введите число от 1 до 2." ;;
esac