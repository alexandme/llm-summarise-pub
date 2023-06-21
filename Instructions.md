The following instructions are for setting up an SSH and Github connection on a new machine.

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
chmod 600 /root/.ssh/sasha
```
Add key to start using with Github
Run in terminal
```
eval "$(ssh-agent -s)"
```

```
ssh-add ~/.ssh/sasha
```
Add Github credentials
```
git config --global user.email "sasha@micra.io"
git config --global user.name "Sasha Alyushin"
```

To make sh scripts executable
```
chmod +x /notebooks/*.sh
```