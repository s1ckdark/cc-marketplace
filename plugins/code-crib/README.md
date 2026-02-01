# code-crib

> Your knowledge stash for Claude Code - Stash work, grab past solutions, rack up your codebase docs
>
> Claude Code를 위한 지식 창고 - 작업 저장, 과거 솔루션 검색, 코드베이스 문서화

[![Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blue.svg)](https://github.com/s1ckdark/claude-crib)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

[English](#installation) | [한국어](#설치)

---

## Installation

```bash
# Add marketplace
/plugin marketplace add s1ckdark/claude-crib

# Install plugin
/plugin install code-crib@claude-crib --scope project
```

## Setup

### Vector DB Options

| Option | Pros | Setup |
|--------|------|-------|
| **Pinecone** (default) | Zero maintenance, scalable | `PINECONE_API_KEY` env var |
| **Chroma** (local) | Free, privacy | Docker required |
| **MongoDB Atlas** | Familiar, rich queries | `MONGODB_URI` env var |

### Pinecone Setup (Recommended)

Claude Code has Pinecone MCP built-in.

1. Get API key from [Pinecone](https://pinecone.io)
2. Add to `~/.claude/settings.json`:
   ```json
   {
     "env": {
       "PINECONE_API_KEY": "your-api-key"
     }
   }
   ```
3. Create index: `/pinecone quickstart` or via console

## Commands

All commands have both **normal** and **slang** versions:

| Normal | Slang | Description |
|--------|-------|-------------|
| `/save` | `/stash` | Stash your work to the knowledge crib |
| `/search` | `/grab` | Grab docs from your stash |
| `/index` | `/rack` | Rack up local docs into the stash |
| `/analyze` | `/scope` | Scope out the codebase |
| `/remove` | `/dump` | Dump docs from your stash |
| `/list` | `/check` | Check what's in your stash |

### `/save` or `/stash` - Stash Your Work

```bash
/stash --type bugfix --tags "auth,session" --title "Session timeout fix"
/save   # auto-detect everything
```

**Args:**
- `--type`: Work type (bugfix, feature, refactor, analysis)
- `--title`: Document title (auto-generated if omitted)
- `--tags`: Tags (comma-separated)
- `--namespace`: Project namespace

### `/search` or `/grab` - Grab Past Solutions

```bash
/grab "session timeout error"
/search "authentication" --type bugfix --limit 3
```

### `/index` or `/rack` - Bulk Index Docs

```bash
/rack
/index --path ./docs/knowledge --namespace my-project
```

### `/analyze` or `/scope` - Scope the Codebase

```bash
/scope
/analyze --depth 5 --top 30
```

### `/check` or `/list` - See Your Stash

```bash
/check --namespace my-project
/list --stats
```

### `/dump` or `/remove` - Clean Up

```bash
/dump --id "doc-id-123"
/remove --older-than 90 --confirm
```

## Auto-RAG (Automatic Knowledge Retrieval)

When enabled, code-crib automatically searches your knowledge stash when you ask questions and injects relevant context into responses.

### How It Works

```
You ask question → Auto-search past knowledge → Context injected → Informed response
```

### Enable Auto-RAG

Run `/setup` and select "Enabled" for Auto-RAG, or add to `code-crib.local.md`:

```yaml
auto_rag:
  enabled: true
  max_results: 3
  min_relevance: 0.7
```

### Example

**Without Auto-RAG:**
> You: "Why is auth timing out?"
> Claude: (Analyzes from scratch)

**With Auto-RAG:**
> You: "Why is auth timing out?"
> Claude: "Based on your previous fix for 'Session timeout in auth middleware' (Jan 15), this looks like the same issue..."

### Configuration Options

| Option | Default | Description |
|--------|---------|-------------|
| `enabled` | `false` | Master switch for auto-RAG |
| `max_results` | `3` | Number of documents to retrieve |
| `min_relevance` | `0.7` | Similarity threshold (0-1) |

---

## 설치

```bash
# 마켓플레이스 추가
/plugin marketplace add s1ckdark/claude-crib

# 플러그인 설치
/plugin install code-crib@claude-crib --scope project
```

## 설정

### 벡터 DB 옵션

| 옵션 | 장점 | 설정 |
|------|------|------|
| **Pinecone** (기본) | 관리 불필요, 확장성 | `PINECONE_API_KEY` 환경변수 |
| **Chroma** (로컬) | 무료, 프라이버시 | Docker 필요 |
| **MongoDB Atlas** | 익숙함, 풍부한 쿼리 | `MONGODB_URI` 환경변수 |

### Pinecone 설정 (권장)

Claude Code에 Pinecone MCP가 내장되어 있습니다.

1. [Pinecone](https://pinecone.io)에서 API 키 발급
2. `~/.claude/settings.json`에 추가:
   ```json
   {
     "env": {
       "PINECONE_API_KEY": "your-api-key"
     }
   }
   ```
3. 인덱스 생성: `/pinecone quickstart` 또는 콘솔에서 직접

## 명령어

모든 명령어는 **일반** 버전과 **슬랭** 버전이 있습니다:

| 일반 | 슬랭 | 설명 |
|------|------|------|
| `/save` | `/stash` | 작업을 지식 창고에 저장 |
| `/search` | `/grab` | 저장된 문서 검색 |
| `/index` | `/rack` | 로컬 문서 일괄 인덱싱 |
| `/analyze` | `/scope` | 코드베이스 분석 |
| `/remove` | `/dump` | 저장된 문서 삭제 |
| `/list` | `/check` | 저장된 문서 목록 확인 |

### `/save` 또는 `/stash` - 작업 저장

```bash
/stash --type bugfix --tags "auth,session" --title "세션 타임아웃 수정"
/save   # 모든 것 자동 감지
```

**인자:**
- `--type`: 작업 유형 (bugfix, feature, refactor, analysis)
- `--title`: 문서 제목 (생략시 자동 생성)
- `--tags`: 태그 (쉼표 구분)
- `--namespace`: 프로젝트 네임스페이스

### `/search` 또는 `/grab` - 솔루션 검색

```bash
/grab "세션 타임아웃 에러"
/search "인증" --type bugfix --limit 3
```

### `/index` 또는 `/rack` - 문서 일괄 인덱싱

```bash
/rack
/index --path ./docs/knowledge --namespace my-project
```

### `/analyze` 또는 `/scope` - 코드베이스 분석

```bash
/scope
/analyze --depth 5 --top 30
```

### `/check` 또는 `/list` - 저장 목록 확인

```bash
/check --namespace my-project
/list --stats
```

### `/dump` 또는 `/remove` - 정리

```bash
/dump --id "doc-id-123"
/remove --older-than 90 --confirm
```

## Auto-RAG (자동 지식 검색)

활성화하면 질문할 때 자동으로 과거 지식을 검색해서 응답에 컨텍스트를 주입합니다.

### 작동 방식

```
질문 → 과거 지식 자동 검색 → 컨텍스트 주입 → 맥락있는 응답
```

### Auto-RAG 활성화

`/setup` 실행 후 "Enabled" 선택, 또는 `code-crib.local.md`에 직접 추가:

```yaml
auto_rag:
  enabled: true
  max_results: 3
  min_relevance: 0.7
```

### 예시

**Auto-RAG 없이:**
> 사용자: "왜 인증이 타임아웃 되지?"
> Claude: (처음부터 분석)

**Auto-RAG 활성화:**
> 사용자: "왜 인증이 타임아웃 되지?"
> Claude: "이전에 해결했던 '세션 타임아웃 수정' (1월 15일) 건과 비슷해 보이는데..."

### 설정 옵션

| 옵션 | 기본값 | 설명 |
|------|--------|------|
| `enabled` | `false` | Auto-RAG 활성화 여부 |
| `max_results` | `3` | 검색할 문서 수 |
| `min_relevance` | `0.7` | 유사도 임계값 (0-1) |

---

## Project Structure / 프로젝트 구조

```
claude-crib/
├── plugins/
│   └── code-crib/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── commands/           # Slash commands (normal + slang)
│       │   ├── save.md / stash.md
│       │   ├── search.md / grab.md
│       │   ├── index.md / rack.md
│       │   ├── analyze.md / scope.md
│       │   ├── remove.md / dump.md
│       │   └── list.md / check.md
│       ├── agents/
│       │   ├── documenter.md
│       │   └── codebase-analyzer.md
│       ├── skills/
│       │   └── save/, search/, index/, analyze/
│       ├── hooks/
│       │   └── auto-document.md
│       └── templates/
│           └── bugfix.md, feature.md, refactor.md, analysis.md
└── README.md
```

## Token Savings / 토큰 절약

| Scenario / 시나리오 | Before / 이전 | After / 이후 |
|---------------------|---------------|--------------|
| Same bug recurs / 동일 버그 재발 | Full code re-analysis / 전체 코드 재분석 | Instant grab from stash / 즉시 검색 |
| Architecture Q / 아키텍처 질문 | Explore from scratch / 처음부터 탐색 | Reuse saved analysis / 저장된 분석 재사용 |
| Repeated patterns / 반복 패턴 | Write from scratch / 처음부터 작성 | Use templates / 템플릿 사용 |

## License

MIT
