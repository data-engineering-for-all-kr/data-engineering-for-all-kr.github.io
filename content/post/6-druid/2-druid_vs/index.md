---
title: "06-02 Druid VS"
date: "2022-02-08"
description: "Druid 와 다른 빅데이터 솔루션과의 비교"
author: Sunyoung Park (SoniaComp)
---

## Druid VS ES
참고: [Druid 공식문서](https://druid.apache.org/docs/latest/comparisons/druid-vs-elasticsearch.html)

### ES: 검색엔진 + 분석엔진 [텍스트(비정형데이터),반정형데이터, 정형데이터]

* 스키마가 없는 문서에 대한 전체 텍스트 검색을 제공하고 원시 이벤트 수준 데이터에 대한 액세스를 제공
* 수집 시 데이터 요약/롤업을 지원하지 않음: 실제 데이터 세트로 최대 100배정도로 데이터를 압축할 수 있는 롤업을 지원하지 않음. 이로 인해 Elasticsearch는 더 많은 스토리지 요구 사항을 갖게 됨

### Druid: 분석엔진 [반정형데이터, 정형데이터]

* OLAP 작업 흐름에 중점을 둡니다. (스캔 및 집계(어그리게이션)에 최적화)
* Druid는 저렴한 비용으로 고성능(빠른 집계 및 수집)에 최적화되어 있으며 광범위한 분석 작업을 지원. Druid는 구조화된 이벤트 데이터에 대한 몇 가지 기본 검색 지원을 제공하지만 전체 텍스트 검색은 지원하지 않음
* Druid는 또한 완전히 구조화되지 않은 데이터를 지원하지 않습니다. 측정은 요약/롤업이 수행될 수 있도록 Druid 스키마에 정의되어야 합니다.

## Druid VS Key-Value Storage

참고: [Druid 공식문서](https://druid.apache.org/docs/latest/comparisons/druid-vs-key-value.html)

### Key-Value Storage

* 다음과 같은 두 가지 방식으로 집계에 대해 지원
  * 가능한 사용자 쿼리의 모든 순열을 미리 계산: 많은 시간이 소요
  * 이벤트 데이터에 대한 범위 스캔: 모든 종류의 필터링에 대한 인덱스가 없다는 제한사항 때문에 성능이 크게 저하될 수 있음

### Druid

* Druid는 스캔 및 집계에 고도로 최적화되어 있으며 데이터 세트에 대한 임의의 심층 드릴다운을 지원

* 데이터의 임의 탐색(유연한 데이터 필터링)을 위해 Druid의 사용자 정의 열 형식은 사전 계산 없이 임시 쿼리를 가능하게 한다. 또한 이 형식은 열에 대한 빠른 스캔을 가능하게 하기 때문에 성능이 우수하다.

## Druid VS Spark

참고: [Druid 공식문서](https://druid.apache.org/docs/latest/comparisons/druid-vs-spark.html)

Druid와 Spark는 Druid를 사용하여 Spark에서 OLAP 쿼리를 가속화할 수 있으므로 상호 보완적인 솔루션

### Spark

* RDD(Resilient Distributed Datasets) 개념을 중심으로 설계된 일반 클러스터 컴퓨팅 프레임워크
* RDD는 중간 결과를 메모리에 유지하여 데이터 재사용을 가능하게 하고 Spark가 반복 알고리즘에 대한 빠른 계산을 제공
* 데이터를 처리하는 엔진
* 데이터의 빠른 쿼리(1초 미만)를 목표로 하지는 않음

### Druid

* 드루이드의 목표는 짧은 쿼리 시간
* 모든 데이터를 완전히 색인화하고 Spark와 애플리케이션 사이의 중간 계층 역할을 할 수 있다.

