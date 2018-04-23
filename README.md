# Redis-HA-OSE
A highly available Redis cluster for Openshift / Kubernetes

## Miscellaneous

### Deleting Untagged Docker Images
```bash
$ docker rmi $(docker images | grep none | awk '{print $3}')
```

### Deleting Exited Containers
```bash
$ docker rm $(docker ps -aq --filter="status=exited")
```



