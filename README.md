🐳 pool 🐳
===

![](http://31.media.tumblr.com/tumblr_m8pp4rlwTF1qjj2ado1_500.png)

The simplest proxy service to access your webapps separated from Git commit-id.

## Requirements

### Vagrant plugin

Need to install [vagrant dns plugin](https://github.com/BerlinVagrant/vagrant-dns). Just run:

> $ vagrant plugin install vagrant-dns

## Setup

Set the configration for dns first:

> $ vagrant dns --install

> $ vagrant dns --start

then run:

> $ vagrant up

Vagrantfile has dns settings for this development environment.
You can access your Docker container just to go `http://<container-id>.pool.dev`.

## How it works

This proxy accesses your Git repository with commit id.
Then checkout it with Dockerfile. Dockerfile should be on the root of the
repository. After checkout files, the container will be built by the Dockerfile
and port is linked with front automatically. All you can do is just to access
`http://<container-id>.pool.dev`.

`handlers/hook.rb` is the only file to handle this.
If you want to check it with your own Docker web-app project, you can rewrite
Git repository url inside `handlers/hook.rb`.