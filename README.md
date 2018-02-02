# ee-microdc-k8s-dynamodb-controller
A kubernetes controller for creating/deleting dynamodb tables based on the [side8/k8s-operator](https://github.com/side8/k8s-operator)

Available on [Docker hub](https://hub.docker.com/r/equalexpertsmicrodc/k8s-dynamodb-controller/)


### Build docker container
```
$ export VERSION="0.1.0"
$ docker build . --tag "microdc/k8s-dynamodb-controller:${VERSION}" --tag "microdc/k8s-dynamodb-controller:latest"
```

### Prerequisites

* An AWS user or role with admin permissions on DynamoDB. kube2iam works very well for this.
* The operator running in the cluster with a serviceAccountName with permissions to the DynamoDB CRD, events and ConfigMaps. `operator.yaml` is a good reference example.


### Example DynamoDB Table

To create a table using the example yaml config follow these steps.
1. Build the container above and deploy to your cluster. It will need a role able to perform cluster updates
2. Apply the `test-table` yaml config:
```
kubectl apply -f example/Table.yaml
```
3. Check the table configuration both on the dynamodb object and the created ConfigMap:
```
kubectl get dynamodb test-table -o json | jq '.status'
kubectl describe configmap dynamodb-test-table
```
4. Use the ConfigMap to configure containers:
```
...
  env:
    - name: TEST_TABLE
      valueFrom:
        configMapKeyRef:
          name: dynamodb-test-table
          key: TableName
```


5. Make some changes. The format mirrors the AWS API so adding more AttributeDeffinitions should be as simple as extending the array in the yaml.
```
$ kubectl edit dynamodb test-table
...
spec:
  ...
  AttributeDefinitions:
    ...
    - AttributeName: active
      AttributeType: "N"
```
6. clean up
```
$ kubectl delete dynamodb test-table
```

### Tests
Requires: shellcheck and yamllint
Tests run at container build. test.sh can bes used for local command line testing.
