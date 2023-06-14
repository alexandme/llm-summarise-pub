#!/bin/bash

# 1. Download and install Miniconda
curl -sL "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" > "Miniconda3.sh"
bash Miniconda3.sh -b -p $HOME/miniconda3
rm Miniconda3.sh
export PATH="$HOME/miniconda3/bin:$PATH"

# 2. Install build-essential
sudo apt install -y build-essential

# 3. Create and activate conda environment
conda create -y -n textgen python=3.10.9
conda init bash
source ~/.bashrc
source activate textgen

# 4. Install PyTorch and dependencies
pip install torch torchvision torchaudio
pip install pdfminer.six


# Clone text-generation-webui repository to tmp folder

# If /tmp folder does not exist, create it
if [ ! -d "/tmp" ]; then
    mkdir /tmp
fi
cd /tmp
git clone https://github.com/oobabooga/text-generation-webui.git

# Copy all files from repo root folder to local folder
external_repo="/tmp/text-generation-webui"
local_repo="/notebooks/text-generation-webui"
find $external_repo -maxdepth 1 -type f -exec cp -t $local_repo {} +

# Create an .rsync-filter file in the temporary folder
echo "- loras/" > /tmp/text-generation-webui/.rsync-filter
echo "- models/" >> /tmp/text-generation-webui/.rsync-filter
echo "- prompts/" >> /tmp/text-generation-webui/.rsync-filter
echo "- repositories/" >> /tmp/text-generation-webui/.rsync-filter
echo "- softprompts" >> /tmp/text-generation-webui/.rsync-filter
echo "- training" >> /tmp/text-generation-webui/.rsync-filter

rsync -av --filter=': .rsync-filter' /tmp/text-generation-webui/ /notebooks/text-generation-webui/

# Remove temporary folder
rm -rf /tmp/text-generation-webui



# 5. Install required packages and update repository
if [ ! -d "/notebooks/learn-langchain" ]; then
    git clone https://github.com/paolorechia/learn-langchain
fi

# 6. Install learn-langchain and dependencies of text-generation-webui
cd /notebooks/learn-langchain
git clone https://github.com/paolorechia/learn-langchain .
pip install -r requirements.txt --upgrade

cd /notebooks/text-generation-webui
pip install -r requirements.txt --upgrade

if [ ! -d "repositories" ]; then
    mkdir repositories
fi
cd repositories

# 7. Install GPTQ-for-LLaMa
if [ ! -d "GPTQ-for-LLaMa" ]; then
    git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa
fi
cd GPTQ-for-LLaMa/
git pull
pip install -r requirements.txt --upgrade

# 8. Install ipykernel
conda install -y -c anaconda ipykernel
python -m ipykernel install --user --name textgen
pip install -r /notebooks/requirements.txt --upgrade

# 9. Install ssh keys
mkdir ~/.ssh
chmod 700 ~/.ssh
sudo cp /notebooks/sasha.pub ~/.ssh/
sudo cp /notebooks/sasha ~/.ssh/
chmod 600 ~/.ssh/sasha.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/sasha
git config --global user.email "sasha@micra.io"
git config --global user.name "Sasha Alyushin"


# 10. Launch webui
cd /notebooks/text-generation-webui

while true; do
    echo "Выберите вариант запуска:"
    echo "1. API и WebUI"
    echo "2. Только API"

    read -p "Введите номер варианта (1-2): " choice

    case $choice in
        1) 
            python server.py --share --api --model-menu
            break
            ;;
        2) 
            python server.py --api --model-menu
            break
            ;;
        *) 
            echo "Неправильный выбор. Введите число от 1 до 2." 
            ;;
    esac
done
