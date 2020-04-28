# AngularAppWithNginxDocker

This project create by referring https://github.com/chetanku/frontend-env.git for my own testing with kubenetes environment.

1) Accessing k8s config map variable via environment variables

> Build and run the docker images locally with the below command and browse to localhost:80:
```
   $ docker build -f .docker/client.Dockerfile . -t sameerat8/angular-frontend-env-k8s:1.0
   $ docker run -p 80:8080 -it sameerat8/angular-frontend-env-k8s:1.0
```

> Push to docker hub
```
  $ docker push sameerat8/angular-frontend-env-k8s:1.0
```

## In kubenetes(or minikube)

> Deploy application
```
  $ kubectl create -f .kube/client-kube.yaml
```

> To testing
```
  $ kubectl port-forward client-pod 8080:8080
```

> Print out the environment variables running inside pod by running below command:
```
  $ kubectl exec -it client-pod -- printenv | grep ENVENV=PRODUCTION
```
