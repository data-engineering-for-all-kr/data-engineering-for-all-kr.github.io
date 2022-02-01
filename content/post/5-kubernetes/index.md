---
title: 5. Kubernetes
date: "2022-02-01"
description: "쿠버네티스"
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
