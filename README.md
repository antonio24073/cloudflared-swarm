Cloudflared Tunnel
==================

# Dependencies

- docker
- docker compose
- make (optional)

# Configuration

- Go to folder `env` and create your own `.env.short_something`, in our example the env will be `.env.dc`.
- Go to folder `domains` and create your own folder. Don't worry with uuid, you will get him later.
- Add your domain in cloudflare panel

You can run it without `make` and without `swarm` but I recommend to use it.

So you can skip this next step.

# Tutorial without make and swarm 

Switch to the `tail` entrypoint in `docker-compose` file then up the container

In the bash inside container, do:

```
cloudflared tunnel login
cloudflared tunnel delete domain.com
cloudflared tunnel create domain.com
```

Configure your `config.yml`, then:

```
cloudflared tunnel route dns domain.com subdomain.domain.com
cloudflared tunnel run domain.com
```

(optional) Switch to the `tunnel run domain.com` command in `docker-compose` file then up the container.

In the above example `domain.com` is the `<UUID or NAME>` of the below docs and `subdomain.domain.com` is `<hostname>`.

Docs:

https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide/local/


# Basic operation (with make and swarm)

```
make login ENV=dc
```

A link will appear in the cli output.

Click in him, and download automatically your `.pem` key in the cloudflare panel. 

It you be storaged in your `domains/domain.com/.cloudflared` folder.

Create your first tunnel:

```
make create ENV=dc
```

List your tunnel.

```
make list ENV=dc
```

If you need to delete a tunnel, you can do:

```
make delete ENV=dc
```

Get your `uuid` and put in your `config.yml` file.

Now add `subdomain.domain.com` as a CNAME registry in cloudflare panel with this command:

```
make dns ENV=dc
```

Now you can remove the previous containers and run your tunnel in docker swarm mode

```
make run ENV=dc
```