# ETCD - Commands

Здесь дополнительная информация об утилите ETCDCTL.

ETCDCTL - это CLI-инструмент, используемый для взаимодействия с ETCD.

ETCDCTL может взаимодействовать с сервером ETCD, используя 2 версии API - версию 2 и версию 3. По умолчанию используется версия 2. Каждая версия имеет разные наборы команд.

Например, ETCDCTL версии 2 поддерживает следующие команды:

```sh
etcdctl backup
etcdctl cluster-health
etcdctl mk
etcdctl mkdir
etcdctl set
```
В то время как в версии 3 команды другие:

```sh
etcdctl snapshot save 
etcdctl endpoint health
etcdctl get
etcdctl put
```

Чтобы установить правильную версию API, установи переменную среды `ETCDCTL_API` командой

```sh
export ETCDCTL_API = 3
```
Когда версия API не установлена в переменной, в некоторых релизах ETCD она будет по умолчанию версией 2, в других - 3. И перечисленные выше команды версии 3 могут не работать.
Если явно задать `ETCDCTL_API`, то ETCD будет работать с требуемой ожидаемой версией API.

Кроме того, тебе также потребуется указать путь к файлам сертификатов, чтобы ETCDCTL мог аутентифицироваться на сервере ETCD API. Файлы сертификатов доступны в **etcd-controlplane** по следующему пути. Мы обсудим больше о сертификатах в разделе безопасности этого курса. Так что не волнуйся, если это пока сложно для тебя:

```sh
--cacert /etc/kubernetes/pki/etcd/ca.crt
--cert /etc/kubernetes/pki/etcd/server.crt
--key /etc/kubernetes/pki/etcd/server.key
```

Итак, чтобы все работало как надо, нужно указать версию API для ETCDCTL и путь к файлам сертификатов. Ниже представлена окончательная команда:

```sh
kubectl exec etcd-master -n kube-system -- sh -c "ETCDCTL_API=3 etcdctl get / --prefix --keys-only --limit=10 --cacert /etc/kubernetes/pki/etcd/ca.crt --cert /etc/kubernetes/pki/etcd/server.crt  --key /etc/kubernetes/pki/etcd/server.key" 
```
