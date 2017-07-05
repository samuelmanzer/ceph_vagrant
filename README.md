Based on this [excellent guide](https://github.com/carmstrong/multinode-ceph-vagrant) by [carmstrong](https://github.com/carmstrong).

# Setup

Run these commands once to install all required vagrant plugins:

```
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-hostmanager
```

# Launching the cluster

Run the following to launch and provision the Ceph cluster:

```
make up
```
