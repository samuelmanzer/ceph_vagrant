Based on this [excellent guide](https://github.com/carmstrong/multinode-ceph-vagrant) by [carmstrong](https://github.com/carmstrong).

# Setup

Install `vagrant-libvirt` according to the [instructions](https://github.com/vagrant-libvirt/vagrant-libvirt) to allow the use of the more efficient `libvirt` provider. Unlike the virtualbox provider, the `libvirt` provider can provision multiple vagrants in parallel.

```
Note: `vagrant-libvirt` does not play nice with `vagrant-hostmanager`, so you will need to uninstall that plugin if you are using it.
```

Additionally, install `vagrant-cachier` to reduce time spend installing packages with `apt`:

```
vagrant plugin install vagrant-cachier
```

# Launching the cluster

Run the following to launch and provision the Ceph cluster:

```
make up
```
