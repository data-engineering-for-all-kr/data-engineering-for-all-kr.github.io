---
title: 5. Kubernetes
date: "2022-02-01"
description: "쿠버네티스"
author: Kyeongmin Woo
---

## 쿠버네티스란

많은 서비스들이 Docker와 같은 Container 기술들을 통해 배포되고 있습니다. 이러한 Container 기술들은 다음과 같은 장점들을 가지고 있습니다.

- Infrastructure에 구애받지 않고 Application이 동작한다.
- local에서 테스트하고 cloud server에서 동일하게 배포할 수 있다.
- 기존의 Virtual Machine 기반의 기술들과 비교해 볼 때 가볍다.

kubernetes는 이러한 Container로 동작하는 서비스들이 안정적으로 동작할 수 있도록 도와주는 도구입니다. 특정 기능을 제공하는 Container가 어떤 이유로 다운되었을 때, 이를 대체할 새로운 Container를 생성하여 서비스의 항상성을 유지해주기도 하고, 특정 Container에 많은 트래픽이 몰리지 않도록 load balancing 기능을 제공하기도 합니다. 구체적으로 [Kubernetes 홈페이지](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/)에서 언급하고 있는 kubernetes의 기능들은 다음과 같습니다.

- Service discovery and load balancing: 많은 트래픽이 몰릴 때 load balancing 해주어 안정적인 배포가 가능하도록 한다.
- Storage orchestration: 다양한 storage를 사용할 수 있다.
- Automated rollouts and rollbacks: 배포 중인 서비스를 쉽게 업데이트할 수 있도록 한다.
- Automatic bin packing: Container가 필요로하는 자원의 크기와 Cluster의 개별 node가 가지고 있는 자원을 고려하여 적절하게 분배한다.
- Self-healing: 실패한 Conatiner를 새로 생성하고, 응답이 없는 Container는 제거하여 서비스를 유지할 수 있도록 한다.
- Secret and configuration management: 보안 상 중요한 정보들을 격리하여 안정적으로 관리할 수 있도록 한다.

## 쿠버네티스의 구성요소

Kubernetes는 여러 컴퓨터를 묶어 하나의 Cluster 처럼 동작할 수 있도록 합니다. 이때 개별 컴퓨터를 Node(또는 Worker Node)라고 부릅니다. 그리고 이러한 Node들을 통합적으로 관리하는 주체를 Control Plane 이라고 합니다. [kubernetes 홈페이지](https://kubernetes.io/docs/concepts/overview/components/)의 아래 이미지를 통해 보다 직관적으로 이해할 수 있습니다.

![Components of Kubernetes](./components-of-kubernetes.png)

## 1. Control Plane Components

kubenetes Cluster에는 Cluster를 유지, 관리하기 위한 목적으로 다음과 같은 요소들이 동작하고 있습니다.

```bash
$ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS        AGE
coredns-78fcd69978-f64td           1/1     Running   1 (2m44s ago)   10d
etcd-minikube                      1/1     Running   1 (2m44s ago)   10d
kube-apiserver-minikube            1/1     Running   1 (2m44s ago)   10d
kube-controller-manager-minikube   1/1     Running   1 (4d1h ago)    10d
kube-proxy-4j6lx                   1/1     Running   1 (4d1h ago)    10d
kube-scheduler-minikube            1/1     Running   1 (2m44s ago)   10d
storage-provisioner                1/1     Running   3 (90s ago)     10d
```

Kubernetes를 관리하는 Master node는 다음과 같은 요소들로 이뤄져 있습니다.

- Kube Api Server
- ETCD Cluster
- Kube Controller Manager
- Kube Scheduler

### 1.1. Kube Api Server

- 사용자의 Request를 받아서 쿠버네티스의 구성요소들에 적절한 명령을 전달하는 서버.
- pod 생성하는 Request를 전달받았을 때 Api Server가 하는 작업들은 다음과 같습니다.
  1. Authenticate User
  2. Valiate Request
  3. Retrieve data
  4. Update ETCD
  5. Scheduler
  6. Kubelet -> Build image
  7. Update ETCD

### 1.2. ETCD Cluster

- 분산 환경에서 key-value 형태의 데이터를 저장할 수 있도록 하는 서비스.
- 쿠버네티스에서는 etcd를 사용하여 `kubectl get` 으로 확인할 수 있는 모든 정보들을 저장합니다.

### 1.3. Kube Controller Manager

- 쿠버네티스에는 다양한 component의 상태를 지속적으로 관리하고, 문제가 발생했을 때 적절히 대응하는 Controller가 있습니다. 대표적으로는 아래와 같은 것들이 있습니다.
  - Node Controller
  - Replication Controller
  - Deployment Controller
  - ...
- Controller Manager는 이러한 Controller들을 관리(Control Loop)하는 역할을 수행합니다.
- 예를 들어 Job Controller가 새로운 Task의 존재를 인식하였다면 이를 적절히 처리해 줄 Pod를 생성하라는 명령을 Kube Api Server에 전달하여 Pod이 생성되도록 합니다.

### 1.4. Kube Scheduler

- 어떤 Pod가 어떤 Node에 할당될 것인지 결정하는 역할을 수행합니다.
  - 실제로 Pod를 생성하거나 하지는 않습니다.(생성은 Node의 Kubelet이 담당)
- Scheduler는 각 Task의 크기에 따라 적절한 Node를 결정합니다.
  - 이때 CPU Core, Memory와 같은 Resource 뿐만 아니라 개별 노드의 중요도(rank) 등을 함께 고려하게 됩니다.

## 2. Node Components

Kubernetes Cluster의 개별 node에는 다음과 같은 요소들이 있습니다.

- Kubelet
- Kube-proxy
- Container Runtime Engine

### 2.1. Kubelet

- 각 Node의 선장과 같은 역할
- Node의 작업을 관리하고 Master와 소통합니다. 구체적으로 다음과 같은 역할을 수행합니다.
  - Register Node
  - Create Pods
  - Running Containers in the Pod
  - Monitor Node and Pods
  - ...

### 2.2. Kube-proxy

- 각 Node의 네트워크를 관리하는 역할.
  - 구체적으로 Service를 통해 각 Node에 접근할 수 있도록 경로를 Forwarding 해주는 역할을 수행합니다.

### 2.3. Container Runtime Engine

- Cluster에서 동작하고 있는 Container를 관리하는 역할.
  - CRI(Container Runtime Interface)를 만족하는 Runtime Engine은 모두 관리할 수 있습니다.

## Minikube

## Kubeclt

## References

- [kubernetes components](https://kubernetes.io/docs/concepts/overview/components/)
