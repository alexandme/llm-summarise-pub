
Create a directory for a key
```
mkdir ~/.ssh
chmod 700 ~/.ssh
```
Copy keys and change rights
```
sudo cp /notebooks/sasha.pub ~/.ssh/
sudo cp /notebooks/sasha ~/.ssh/
chmod 600 ~/.ssh/sasha.pub
```
Add key to start using with Github
Run in terminal
```
ssh-agent
```
Run output in terminal
Then run
```
ssh-add ~/.ssh/sasha
```
Add Github credentials
```
git config --global user.email "sasha@micra.io"
git config --global user.name "Sasha Alyushin"
```