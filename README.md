# dockmob/zookeeper
Docker images for Apache ZooKeeper.

## Standalone mode
```
docker run -p 2181:2181 -d dockmob/zookeeper
```

## Cluster mode
```
docker run -d -h zk1 --name zk1 dockmob/zookeeper -s zk1,zk2,zk3
docker run -d -h zk2 --name zk2 dockmob/zookeeper -s zk1,zk2,zk3
docker run -d -h zk3 --name zk3 dockmob/zookeeper -s zk1,zk2,zk3
```