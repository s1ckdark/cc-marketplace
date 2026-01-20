# Dave's CC Plugins

> Claude Code의 기능을 확장하는 개인 플러그인 마켓플레이스

[![Marketplace](https://img.shields.io/badge/Marketplace-Personal-blue.svg)](https://github.com/s1ckdark/cc-marketplace)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## 소개

개인용 Claude Code 플러그인 저장소입니다. RAG 기반 지식 관리, 생산성 도구 등 다양한 플러그인을 제공합니다.

## 설치 방법

### 1단계: 마켓플레이스 추가

```bash
/plugin marketplace add s1ckdark/cc-marketplace
```

### 2단계: 플러그인 설치

```bash
/plugin install claude-code-rag@dave-cc-plugins --scope project
```

> **Scope 옵션:**
>
> | Scope     | 설명                                   |
> | --------- | -------------------------------------- |
> | `user`    | 본인만 사용 (기본값)                   |
> | `project` | 저장소의 모든 협업자가 사용 **(권장)** |
> | `local`   | 본인만, 이 저장소에서만 사용           |

## 플러그인 목록

### claude-code-rag (v1.0.0)

> RAG 기반 지식 관리 시스템

작업 내역, 솔루션, 분석 결과를 벡터 DB에 저장하고 나중에 검색할 수 있는 플러그인입니다.

**주요 기능:**
- `/save` - 현재 작업을 벡터 DB에 저장
- `/search` - 저장된 지식 검색
- `/index` - 프로젝트 문서 인덱싱

**지원 벡터 DB:** Pinecone, Chroma, MongoDB

```bash
/plugin install claude-code-rag@dave-cc-plugins --scope project
```

---

## 새 플러그인 추가하기

### 자동 생성 (권장)

```bash
./scripts/create-plugin.sh my-new-plugin
```

### 수동 생성

1. `plugins/` 폴더에 새 플러그인 디렉토리 생성
2. `plugin.json` 파일 작성
3. `.claude-plugin/marketplace.json`에 플러그인 등록

자세한 가이드는 [CLAUDE.md](CLAUDE.md)를 참조하세요.

## 구조

```
cc-marketplace/
├── .claude-plugin/
│   └── marketplace.json      # 플러그인 레지스트리
├── plugins/
│   └── claude-code-rag/      # 플러그인 폴더
│       ├── plugin.json
│       ├── commands/
│       ├── agents/
│       ├── hooks/
│       └── templates/
├── scripts/
│   └── create-plugin.sh      # 플러그인 생성 스크립트
├── CLAUDE.md                 # 플러그인 개발 가이드
└── README.md
```

## 기여하기

1. 저장소 포크
2. 새 플러그인 개발 또는 기존 플러그인 개선
3. Pull Request 제출

## 라이선스

MIT
