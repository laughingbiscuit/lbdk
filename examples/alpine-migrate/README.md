Migrating my Development Environment to Alpine
---

My development environment is starting to feel bloated. Lets try to...

Switch from Debian to Alpine
Switch from NPM to Yarn
Remove rarely used tools and runtimes

## Clean down
```
docker rmi $(docker images -a -q)
docker rm -f $(docker ps -a -q)
```

## Terminal Tools Only
Time to build image:
15m13.732s

Size of image:
2.92GB

## Result
Time to build image:
6mins

Size of image:
2.29GB

Take a look [here](https://github.com/laughingbiscuit/lbdk/commit/e9e30a7223b32860a7f097dd9e0221585f94108d) ☺
