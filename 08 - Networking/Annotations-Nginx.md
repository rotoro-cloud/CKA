# Annotations and rewrite-target
Различные `ingress controllers` имеют разные параметры, которые можно использовать для их настройки под свои нужды. Контроллер `NGINX Ingress controller` имеет множество опций, которые можно увидеть [https://kubernetes.github.io/ingress-nginx/examples/](https://kubernetes.github.io/ingress-nginx/examples/).
Я хотел бы объяснить одну из этих опций, которую мы будем использовать в наших лабораторных. Параметр "Rewrite target"

Наше приложение `meet` показывает страницу конференций по адресу: `http://<meet-service>:<port>/`

Наше приложение `meet` показывает страницу магазина по адресу: `http://<store-service>:<port>/`

Мы должны настроить `Ingress` для достижения следующего. Когда пользователь посещает URL-адрес, его запрос должен быть перенаправлен внутрь на URL-адрес после стрелки.
#
`http://<ingress-service>:<ingress-port>/shop` 
-->> 
`http://<store-service>:<port>/`

`http://<ingress-service>:<ingress-port>/conference` 
-->>
`http://<meet-service>:<port>/`
#
Обрати внимание, что в URL путь `/shop` и `/conference` - это то, что мы настраиваем на  `ingress controller`, поэтому мы можем перенаправлять пользователей в соответствующие приложения в бэкенде. 
Пока для приложений не настроен этот путь.
И без заданной опции `rewrite-target` мы получим что-то вроде:
#
`http://<ingress-service>:<ingress-port>/shop` 
-->> 
`http://<store-service>:<port>/shop`

`http://<ingress-service>:<ingress-port>/conference` 
-->>
`http://<meet-service>:<port>/conference`
#
Обрати внимание на `shop` и `conference` в конце целевых URL. Целевые приложения не настроены с работать путями `/shop` или `/conference`. 

Это разные приложения, созданные специально для своих целей, поэтому они не ожидают `/shop` и `/conference` в адресе. Поэтому такие запросы будут терпеть неудачу и возвращать `404 not found`.

Чтобы исправить это, мы хотим "переписать" (`rewrite`) URL-адрес, когда запрос передается в приложение `store` и `meet`. Мы не хотим передавать тот путь, который ввел пользователь. Поэтому мы указываем опцию `rewrite-target`.

Она перезаписывает URL-адрес, заменяя все, что находится в `rules-> http-> paths-> path`, который в данном случае является `/pay`, на значение в `rewrite-target`. 

Это работает так же, как функция поиска и замены: 
replace(path, rewrite-target). В нашем случае: replace("/path","/")
```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: test-ingress
  namespace: critical-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - http:
      paths:
      - path: /pay
        backend:
          serviceName: pay-service
          servicePort: 8282
```
В другом примере, это также может быть:
```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
  name: rewrite
  namespace: default
spec:
  rules:
  - host: rewrite.bar.com
    http:
      paths:
      - backend:
          serviceName: http-svc
          servicePort: 80
        path: /something(/|$)(.*)
```
