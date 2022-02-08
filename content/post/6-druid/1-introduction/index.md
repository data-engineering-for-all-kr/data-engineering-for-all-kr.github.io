---
title: "06-01 Druid Introduction"
date: "2022-02-08"
description: "Druid 의 핵심 개념과 물리적 구조"
author: Sunyoung Park (SoniaComp)
---

## Druid

* 공식문서: https://druid.apache.org/
* Github: https://github.com/apache/druid

> Druid is a high performance real-time analytics database. Druid's main value add is to reduce time to insight and action. (Druid Github README)

### OLAP Engine

* OLAP: 다수의 이용자가 실시간으로 데이터를 갱신하거나 조회하는 경우 트랜잭션 단위로 작업을 처리하는 방식
* OLTP: 대용량 데이터를 빠르게 처리하며 다양한 관점에서 추출, 분석할 수 있도록 지원하는 방식 (데이터에서 의미있는 정보를 추출하여 의사결정을 도움)

### Reduce Time

빠른 쿼리와 수집이 중요한 워크플로우를 위해 설계되었다.

## Druid 장점

내용과 이미지 출처: [공식문서](https://druid.apache.org/)

### **Build fast, modern data analytics applications**

드루이드는 다음의 특징을 갖는 데이터 워크플로우를 위해 설계되었습니다.

* fast-adhoc analytics
* instant data visibility
* supporting high concurrency

![img](https://druid.apache.org/img/diagram-3.png)

### **Easy integration with your existing data pipelines**

Kafka, Amazon Kinesis 같은 메시지 버스, HDFS 와 같이 다양한 소스의 정형 데이터와 반정형데이터를 로드할 수 있습니다.

![img](https://druid.apache.org/img/diagram-4.png)

### Fast, consistent queries at high concurrency

Druid는 새로운 스토리지 아이디어, 인덱싱 구조, 정확한 쿼리와 근사 쿼리를 결합하여 1초 이내에 대부분의 결과를 반환합니다.

드루이드는 Data 를 Column 에 저장하고, Column 의 type (string, number, etc) 에 따라 다양한 압축과 인코딩 방식, 그리고 인덱싱이 적용됩니다.

* 검색 시스템과 유사하게 Druid는 빠른 검색 및 필터링을 위해 문자열 열에 대한 역 인덱스를 구축합니다.
* 시계열 데이터베이스와 유사하게 Druid는 데이터를 시간별로 지능적으로 분할하여 빠른 시간 지향 쿼리를 가능하게 합니다.

![img](https://druid.apache.org/img/diagram-5.png)

**롤업**: Druid 는 데이터를 수집할 때 선택적으로 사전 집계를 할 수 있습니다. 이를 통해 스토리지를 절약할 수 있습니다.

### Broad applicability

드루이드는 새로운 유형의 쿼리와 워크플로우에 사용될 수 있습니다. 드루이드는 실시간과 과거 데이터 모두에 대해 빠르고 ad-hoc 한 쿼리를 위해 만들어졌습니다.

![img](https://druid.apache.org/img/diagram-6.png)

### Deploy in public, private, and hybrid clouds

다양한 환경에서 사용할 수 있다.

## Druid 주요 특징

출처: [공식문서](https://druid.apache.org/technology) 와 [Druid Docs](https://druid.apache.org/docs/latest/design/index.html)

* Column-Oriented Storage: Druid 는 각 열(column)을 개별적으로 저장하고 압축합니다. 그래서 특정 쿼리(scan, ranking, groupby)에 대해 필요한 하나의 열만 읽을 수 있습니다.
* Native Search Indexes: String Value 에 대한 역색인을 제공합니다.
* Indexes for quick filtering: Druid는 [Roaring](https://roaringbitmap.org/) 또는 [CONCISE](https://arxiv.org/pdf/1004.0403) 압축 비트맵 인덱스를 사용하여 인덱스를 생성하여 여러 열에서 빠른 필터링 및 검색을 가능하게 합니다.
* Streaming and batch ingest
* Flexible schemas: 변화하는 스키마와 중첩 데이터를 우아하게 처리할 수 있습니다.
* Time-Optimized Partitioning: Druid는 먼저 데이터를 시간별로 분할합니다. 선택적으로 다른 필드를 기반으로 추가 분할을 구현할 수 있습니다. 시간 기반 쿼리는 쿼리의 시간 범위와 일치하는 파티션에만 액세스하므로 성능이 크게 향상됩니다.
* SQL Support
* Horizontal Scalability: 확장 가능한 분산시스템 위에서 동작할 수 있으며, 각 쿼리를 병렬로 처리할 수 있어서 대규모 병렬 처리가 가능합니다. 
* Easy Operation: 노드의 고장이나 추가 및 축소에 대해 Self-healing, self-balancing을 제공합니다.
* Cloud-native, fault-tolerant architecture that won't lose data: 수집 후 Druid는 데이터 사본을 [딥 스토리지](https://druid.apache.org/docs/latest/design/architecture.html#deep-storage) 에 안전하게 저장합니다 . 딥 스토리지는 일반적으로 클라우드 스토리지, HDFS 또는 공유 파일 시스템입니다. 모든 Druid 서버가 실패하는 드문 경우에도 딥 스토리지에서 데이터를 복구할 수 있습니다. 소수의 Druid 서버에만 영향을 미치는 제한된 오류의 경우 복제를 통해 시스템 복구 중에 쿼리가 계속 가능합니다.
* Approximate algorithms: Druid에는 대략적인 개수 구별, 대략적인 순위, 대략적인 히스토그램 및 분위수 계산을 위한 알고리즘이 포함되어 있습니다. 이러한 알고리즘은 제한된 메모리 사용을 제공하며 종종 정확한 계산보다 훨씬 빠릅니다. 속도보다 정확도가 더 중요한 상황을 위해 Druid는 정확한 개수와 정확한 순위도 제공합니다.
* Automatic summarization at ingest time: Druid는 수집 시 데이터 요약을 선택적으로 지원합니다. 이 요약은 데이터를 부분적으로 사전 집계하여 잠재적으로 상당한 비용 절감 및 성능 향상으로 이어집니다.

## Druid 물리적 구조

![img](https://druid.apache.org/img/diagram-7.png)

## 드루이드를 사용할 때

참고: [Powered by Apache Druid](https://druid.apache.org/druid-powered)

사용 사례가 다음 중 몇 가지와 일치하는 경우 Druid가 좋은 선택일 수 있습니다.

- 삽입 비율은 매우 높지만 업데이트는 덜 일반적입니다.
- 데이터에는 시간 구성 요소가 있습니다. Druid에는 특히 시간과 관련된 최적화 및 디자인 선택이 포함됩니다.
- 테이블이 두 개 이상 있을 수 있지만 각 쿼리는 하나의 큰 분산 테이블에만 적용됩니다. 쿼리는 잠재적으로 둘 이상의 작은 "조회" 테이블에 도달할 수 있습니다.

*Druid를 사용하고 싶지 않은* 상황은 다음과 같습니다.

- *기본 키를 사용하여 기존* 레코드 의 지연 시간이 짧은 업데이트가 필요합니다 . Druid는 스트리밍 삽입을 지원하지만 스트리밍 업데이트는 지원하지 않습니다. 백그라운드 일괄 작업을 사용하여 업데이트를 수행할 수 있습니다.
- 쿼리 대기 시간이 그다지 중요하지 않은 오프라인 보고 시스템을 구축하고 있습니다.
- 하나의 큰 사실 테이블을 다른 큰 사실 테이블에 결합하는 것을 의미하는 "큰" 조인을 수행하려고 하며 완료하는 데 오랜 시간이 걸리는 이러한 쿼리에 대해 문제가 없습니다.