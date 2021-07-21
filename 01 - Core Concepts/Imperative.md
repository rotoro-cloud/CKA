# Imperative Commands with Kubectl

Хотя ты будешь работать в основном декларативным способом - используя файлы определений, императивные команды могут помочь в быстром выполнении одноразовых задач, а также в легком создании шаблона для файла определения. Это поможет значительно сэкономить время во время экзамена.

Прежде чем мы начнем, ознакомься с двумя опциями, которые могут пригодиться при работе с приведенными ниже командами.
```sh
--dry-run=client
```
Обычно, как только команда запущена, ресурс сразу создается. Но если тебе хочетьбся лишь протестировать свою команду, используй параметр `--dry-run=client`. Это не создаст ресурс, а сообщит нам, можно ли это выполнить в данном кластере и верна ли твоя команда.
```sh
-o yaml
```
Это выведет на экран определение ресурса в формате YAML.

Используй два этих сочетания для быстрого создания файла определения ресурса, который затем можно изменять и создавать ресурсы по мере необходимости, вместо написания файлов с нуля.

## POD 
### Создать POD NGINX
```sh
kubectl run nginx --image=nginx
```
### Создать YAML-манифест POD 
Используем `-o yaml`, чтобы не создавать в кластере `--dry-run`
```sh
kubectl run nginx --image=nginx --dry-run=client -o yaml
```

## Deployment 
### Создать Deployment
```sh
kubectl create deployment --image=nginx nginx
```
### Создать YAML-манифест Deployment 
Используем `-o yaml`, чтобы не создавать в кластере `--dry-run`
```sh
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```
### Создать YAML-манифест Deployment с 4 replicas
Используем `-o yaml`, чтобы не создавать в кластере `--dry-run`, и параметр `--replicas=4`
```sh
kubectl create deployment nginx --image=nginx --replicas=4
```
### Масштабирование Deployment
Используем команду `scale` и параметр `--replicas=3`
```sh
kubectl scale deployment nginx --replicas=3
```
Другой способ сделать это - сохранить определение YAML в файл и изменить его там.
```sh
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > nginx-deployment.yaml
```
Теперь нам нужно лишь обновить файл `nginx-deployment.yaml`, добавив туда реплик или изменив любые другие полея перед созданием deployment.

## Services
### Создать Service для `redis`-POD
```sh
kubectl expose pod redis --port=6379
```
или тоже самое, но если POD еще нет
```sh
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
```
> Это автоматически будет использовать метки POD в качестве селекторов для Service

или, если нам нужны дополнительные селекторы
```sh
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
```
> Это не будет использовать метки POD в качестве селекторов, вместо этого он будет использовать селекторы как `app=redis`. 

Мы не можем передавать селекторы в качестве опциий для команды. Таким образом, он не будет работать с POD `redis` как ожидалось, если у него другой набор меток. Поэтому, мы зайдем в файл и отредактируем как нам нужно, перед созданием Service

### Создать Service с именем `nginx` типа `NodePort`

И еще открыть порт 80 в nginx-POD на портах 30080 на узлах кластера

```sh
kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service --dry-run=client -o yaml
```
> Это будет автоматически использовать метки POD в качестве селекторов, но мы не сможете указать `NodePort`. Необходимо сгенерировать файл определения, а затем попроавить `NodePort` вручную перед созданием службы.

Или мы можем зайти с другой стороны
```sh
kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml
```
> Это не будет использовать метки POD в качестве селекторов Service, поэтому файл все равно придется править

У обеих этих команд есть свои проблемы. Хотя одна из них не может принять селектор, другая не может принять nodeport. Я бы рекомендовал использовать команду kubectl expose. 

Если тебе нужно указать порт узла, сгенерируй файл определения с помощью той же команды и вручную измени его, введя `nodePort` перед созданием службы.

# Документация:
[https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)

[https://kubernetes.io/docs/reference/kubectl/conventions/](https://kubernetes.io/docs/reference/kubectl/conventions/)

