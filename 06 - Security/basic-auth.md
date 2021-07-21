# Setting up Basic Authentication
> Внимание, basic authentication Deprecated in Kubernetes 1.19++

Это является устаревшим и не должно использоваться в производстве. Тем не менее очень хорошо помогает новичку разобраться в аутентификации в Kubernetes

## Следуя инструкциями настроим `basic authentication` в `kubeadm`-установке

Создай файл с данными пользователей локально по `/tmp/users/user-details.csv`

```
# User File Contents
password123,user1,u0001
password123,user2,u0002
password123,user3,u0003
password123,user4,u0004
password123,user5,u0005
```

Измени static POD настроенный `kubeadm` для `kube-apiserver`, на получение списка пользователей. Файл-манифест в размещении `/etc/kubernetes/manifests/kube-apiserver.yaml`

```
apiVersion: v1
kind: Pod
metadata:
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
      <content-hidden>
    image: k8s.gcr.io/kube-apiserver-amd64:v1.11.3
    name: kube-apiserver
    volumeMounts:
    - mountPath: /tmp/users
      name: usr-details
      readOnly: true
  volumes:
  - hostPath:
      path: /tmp/users
      type: DirectoryOrCreate
    name: usr-details
```
Измени опции старта `kube-apiserver`, подключив файл для `basic-auth`

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --authorization-mode=Node,RBAC
      <content-hidden>
    - --basic-auth-file=/tmp/users/user-details.csv
```
Создай необходимые `roles` и `rolebindings` для этих пользователей:
```
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```
```
---
# This role binding allows "jane" to read pods in the "default" namespace.
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: user1 # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role 
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

После создания, ты можешь аутентифицироваться в `kube-apiserver` используя их данные:
```
curl -v -k https://localhost:6443/api/v1/pods -u "user1:password123"
```
