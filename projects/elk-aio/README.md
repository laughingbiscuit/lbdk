ELK All-in-one
---

## Prerequisites

Install Docker, Python, Docker Compose

```
git clone https://github.com/deviantony/docker-elk
cd docker-elk
```

allow http input

```
sed -i "s/tcp/http/g" logstash/pipeline/logstash.conf
```

```
docker-compose up -d
xdg-open localhost:5601
```

Log in with `elastic` and `changeme`

## Post a log via HTTP

```
curl -v -XPUT localhost:5000/project/log/1 -d 'message=hello&error=false'
```

## Look at the logs

Navigate to the `Discover` page
