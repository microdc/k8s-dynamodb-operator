# ee-microdc-k8s-dynamodb-controller
A kubernetes controller for creating/deleting dynamodb tables based on the [side8/k8s-operator](https://github.com/side8/k8s-operator)

Available on [Docker hub](https://hub.docker.com/r/equalexpertsmicrodc/k8s-dynamodb-controller/)


### Build docker container
```
$ export VERSION="0.1.0"
$ docker build . --tag "microdc/k8s-dynamodb-controller:${VERSION}" --tag "microdc/k8s-dynamodb-controller:latest"
```

### Example DynamoDB Table
To create a table using the example yaml config follow these steps.
1. Build the container above and deploy to your cluster. It will need a role able to perform cluster updates
2. Apply the yaml config:
```
kubectl apply -f example/Table2.yaml
```
3. Make some changes like adding a TTL to the table:
```
$ kubectl edit dynamodb envname.appname.table
#add the following
TTL_BOOLEAN='true'
TTL_ATTRIBUTE='example'
```
4. clean up
```
kubectl delete dynamodb envname.appname.table
```

### Tests
Requires: shellcheck and python(for yaml test)
Tests run at container build. test.sh can bes used for local command line testing.
