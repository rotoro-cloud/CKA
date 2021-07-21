# Using PVCs in PODs
После создания PVC используй его в файле определения POD, указав имя PVC в разделе persistentVolumeClaim в секции `volumes` следующим образом:
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim
```

То же самое верно для ReplicaSets или Deployments. Добавь это в раздел template POD

[https://kubernetes.io/docs/concepts/storage/persistent-volumes/#claims-as-volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#claims-as-volumes)
