Gitlab All-in-one
---

## Run GitLab

```
docker run --detach --hostname localhost -p 80:80 -p 22:22 --name some-gitlab gitlab/gitlab-ce:latest
```

Startup takes a while, so you can check the startup logs with

```
docker logs -f some-gitlab
```

Open GitLab
```
xdg-open localhost
```

On first login, you set your initial password for the `root` user.
