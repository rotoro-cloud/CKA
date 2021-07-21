# About CNI and CKA Exam

## Важный совет по развертыванию сетевых плагинов в кластере Kubernetes

Далее в лабораторных работах мы будем работать с сетевыми аддонами. Это включает установку сетевого плагина в кластер. Хотя мы использовали `weave-net` в качестве примера, имей в виду, что можно использовать любой из описанных здесь плагинов:

[https://kubernetes.io/docs/concepts/cluster-administration/addons/](https://kubernetes.io/docs/concepts/cluster-administration/addons/)

[https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model](https://kubernetes.io/docs/concepts/cluster-administration/networking/#how-to-implement-the-kubernetes-networking-model)

На экзамене CKA для ответа на вопрос, требующий развертывания сетевого дополнения, если не будет указано иное, можно использовать любое из решений, описанных в приведенной выше ссылке

Однако в настоящее время документация не содержит прямых ссылок на точную команду, которая будет использоваться для развертывания стороннего сетевого дополнения

Приведенные выше ссылки перенаправляют на сторонние сайты или репозитории GitHub, которые нельзя использовать на экзамене. Это было сделано намеренно, чтобы содержание документации Kubernetes не зависело от поставщика.

На данный момент в документации есть еще одно место, где можно найти точную команду для развертывания плагина `Weave Network`:

[https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#steps-for-the-first-control-plane-node](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/#steps-for-the-first-control-plane-node)

Там в поле `step 2`
