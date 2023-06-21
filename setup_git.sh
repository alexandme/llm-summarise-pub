#!/bin/bash

mkdir ~/.ssh
chmod 700 ~/.ssh
sudo cp /notebooks/sasha.pub ~/.ssh/
sudo cp /notebooks/sasha ~/.ssh/
chmod 600 ~/.ssh/sasha.pub
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/sasha
git config --global user.email "sasha@micra.io"
git config --global user.name "Sasha Alyushin"