


## Check Disk Usage

```
baobab
```


## Clean System

```
sudo apt-get autoremove
sudo apt-get autoclean
nix-collect-garbage
sudo journalctl --vacuum-size=100M
find . -maxdepth 5 -name node_modules -type d -exec rm -rf {} +

cd /var/log
sudo find . -type f -name '*.gz' -exec rm -f {} +
