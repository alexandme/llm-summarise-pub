#!/bin/bash

# 1. Скачивание и установка Miniconda
curl -sL "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" > "Miniconda3.sh"
bash Miniconda3.sh -b -p $HOME/miniconda3
rm Miniconda3.sh
export PATH="$HOME/miniconda3/bin:$PATH"

# 2. Установка build-essential
sudo apt install -y build-essential

# 3. Создание и активация conda-окружения
conda create -y -n textgen python=3.10.9
conda init bash
source ~/.bashrc
conda activate textgen

# 4. Установка PyTorch и зависимостей
python -m pip install torch torchvision torchaudio
python -m pip install pdfminer.six
python -m pip install -U gradio

# 5. Установка требуемых пакетов и обновление репозитория
if [ ! -d "/notebooks/learn-langchain" ]; then
    git clone https://github.com/paolorechia/learn-langchain
fi
cd /notebooks/learn-langchain
git pull
python -m pip install -r requirements.txt --upgrade

cd text-generation-webui
python -m pip install -r requirements.txt --upgrade


if [ ! -d "repositories" ]; then
    mkdir repositories
fi
cd repositories

if [ ! -d "GPTQ-for-LLaMa" ]; then
    git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa
fi
cd GPTQ-for-LLaMa/
git pull
python -m pip install -r requirements.txt --upgrade

conda install -y -c anaconda ipykernel
python -m ipykernel install --user --name=textgen

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
