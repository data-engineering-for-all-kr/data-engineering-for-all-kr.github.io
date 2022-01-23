# Data Engineering for all

- [Go to blog](https://data-engineering-for-all-kr.github.io/)

## Data Engineering for all에 기여하는 방법

### 개발 환경 설정하기

- 기여하기 위해서는 개발 환경을 맞추어야 합니다. 우선 본 Repo를 clone 받아야 합니다.

```
$ git clone git@github.com:data-engineering-for-all-kr/data-engineering-for-all-kr.github.io.git
```

- clone 받은 directory에 진입한 후 npm package를 설치해 줍니다.

```
$ make init
or
$ npm install
```

### PR 생성하기

- Post를 추가하거나 수정할 때에는 PR을 생성해주셔야 합니다.
- PR 생성 전 Local에서 test해주시기 바랍니다. Project directory에서 아래 명령어를 통해 local server에서 test 할 수 있습니다.

```
$ make develop
or
$ npm run develop
```

### 새 Post를 추가하는 방법

- 모든 post는 `content/post` 디렉토리에 저장되어 있습니다. 따라서 새로운 Post를 작성한다면 `content/post` 디렉토리에 새 Post를 위한 디렉토리와, index.md 파일을 생성하면 됩니다.
- JS 정적 사이트 생성기를 사용하고 있으며, 모든 Post는 Markdown(`index.md`)으로 작성하도록 되어있습니다.
- 모든 `index.md`는 다음 예시와 같은 구조의 Header를 가지고 있어야 합니다.

```
---
title: Example Template
date: "2022-01-23"
description: "예시 템플릿 입니다."
---
```

- [index.md template](content/template/exmaple/index.md)에서 확인할 수 있습니다.

### 기존 Post를 수정하는 방법

- `content/post` 디렉토리에서 해당 Post를 찾아 수정할 수 있습니다.

## (참고) 디렉토리 구조

```
$ tree -I 'node_modules|static|public'

├── LICENSE
├── README.md
├── content
│   ├── post  // 실제 post가 저장되는 위치
│   └── template // post 예제
├── gatsby-browser.js
├── gatsby-config.js
├── gatsby-node.js
├── package-lock.json
├── package.json
└── src
    ├── components  // layout 등이 저장되는 위치
    ├── images
    ├── pages  // index page 등이 저장되는 위치
    │   ├── 404.js
    │   ├── index.js
    │   └── using-typescript.tsx
    ├── style.css
    └── templates
        └── blog-post.js

```

## References

- [gatsby-starter-blog](https://www.gatsbyjs.com/starters/gatsbyjs/gatsby-starter-blog)
