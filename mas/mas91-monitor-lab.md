# MVI LAB

# Podman simulator

```
podman create -p 10502:10502 -p 20502:20502 -v node_red_data_vol:/data --name i550simulator ekstrom/modbus_simulator
podman  start i550simulator
```
# Node Red Setup
```
sudo npm install -g --unsafe-perm node-red
podman run -it -p 1880:1880 --name mynodered nodered/node-red
```
