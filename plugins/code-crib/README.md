# code-crib

> Your knowledge stash for Claude Code - Save work sessions, search past solutions, analyze your codebase
>
> Claude Code를 위한 지식 창고 - 작업 세션 저장, 과거 솔루션 검색, 코드베이스 분석

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

# Run setup
/code-crib:setup
```

## Setup

### Vector DB Options

| Option | Pros | Setup |
|--------|------|-------|
| **Chroma** (recommended) | Free, local, privacy | Docker required |
| **Pinecone** | Zero maintenance, scalable | `PINECONE_API_KEY` env var |

### Chroma Setup (Recommended)

```bash
# Start Chroma with Docker
docker run -d -p 8000:8000 chromadb/chroma

# Run setup wizard
/code-crib:setup
```

## Commands

| Command | Description |
|---------|-------------|
| `/code-crib:stash` | Save your work session to knowledge stash |
| `/code-crib:grab` | Search docs from your stash |
| `/code-crib:rack` | Bulk index local markdown files |
| `/code-crib:list` | List documents in your stash |
| `/code-crib:remove` | Delete documents from stash |
| `/code-crib:analyze` | Analyze and document codebase structure |
| `/code-crib:scope` | Same as analyze |
| `/code-crib:rag` | RAG mode control (on/off/query) |
| `/code-crib:inject` | Manual file injection into context |
| `/code-crib:toggle-rag` | Toggle Auto-RAG on/off |
| `/code-crib:setup` | Configuration wizard |
| `/code-crib:update` | Update plugin to latest version |

### `/code-crib:stash` - Save Your Work

```bash
/code-crib:stash
/code-crib:stash --type bugfix --tags "auth,session" --title "Session timeout fix"
```

**Args:**
- `--type`: Work type (bugfix, feature, refactor, analysis)
- `--title`: Document title (auto-generated if omitted)
- `--tags`: Tags (comma-separated)
- `--namespace`: Project namespace

### `/code-crib:grab` - Search Past Solutions

```bash
/code-crib:grab "session timeout error"
/code-crib:grab "authentication" --type bugfix --limit 3
```

### `/code-crib:rack` - Bulk Index Docs

```bash
/code-crib:rack
/code-crib:rack --path ./docs/knowledge
```

### `/code-crib:analyze` - Analyze Codebase

```bash
/code-crib:analyze
/code-crib:analyze --depth 5 --top 30
```

### `/code-crib:rag` - RAG Mode Control

```bash
/code-crib:rag              # Show current status
/code-crib:rag on           # Enable RAG mode
/code-crib:rag off          # Disable RAG mode
/code-crib:rag "question"   # One-shot RAG query
```

### `/code-crib:inject` - Manual Context Injection

```bash
/code-crib:inject src/auth/login.ts      # Single file
/code-crib:inject src/components/*.tsx   # Glob pattern
/code-crib:inject src/api/ --depth 2     # Directory
```

---

## 설치

```bash
# 마켓플레이스 추가
/plugin marketplace add s1ckdark/claude-crib

# 플러그인 설치
/plugin install code-crib@claude-crib --scope project

# 설정 실행
/code-crib:setup
```

## 설정

### 벡터 DB 옵션

| 옵션 | 장점 | 설정 |
|------|------|------|
| **Chroma** (권장) | 무료, 로컬, 프라이버시 | Docker 필요 |
| **Pinecone** | 관리 불필요, 확장성 | `PINECONE_API_KEY` 환경변수 |

### Chroma 설정 (권장)

```bash
# Docker로 Chroma 시작
docker run -d -p 8000:8000 chromadb/chroma

# 설정 마법사 실행
/code-crib:setup
```

## 명령어

| 명령어 | 설명 |
|--------|------|
| `/code-crib:stash` | 작업 세션을 지식 창고에 저장 |
| `/code-crib:grab` | 저장된 문서 검색 |
| `/code-crib:rack` | 로컬 마크다운 파일 일괄 인덱싱 |
| `/code-crib:list` | 저장된 문서 목록 |
| `/code-crib:remove` | 저장된 문서 삭제 |
| `/code-crib:analyze` | 코드베이스 구조 분석 및 문서화 |
| `/code-crib:scope` | analyze와 동일 |
| `/code-crib:rag` | RAG 모드 제어 (on/off/query) |
| `/code-crib:inject` | 수동 파일 컨텍스트 주입 |
| `/code-crib:toggle-rag` | Auto-RAG 토글 |
| `/code-crib:setup` | 설정 마법사 |
| `/code-crib:update` | 플러그인 최신 버전으로 업데이트 |

### `/code-crib:stash` - 작업 저장

```bash
/code-crib:stash
/code-crib:stash --type bugfix --tags "auth,session" --title "세션 타임아웃 수정"
```

**인자:**
- `--type`: 작업 유형 (bugfix, feature, refactor, analysis)
- `--title`: 문서 제목 (생략시 자동 생성)
- `--tags`: 태그 (쉼표 구분)
- `--namespace`: 프로젝트 네임스페이스

### `/code-crib:grab` - 솔루션 검색

```bash
/code-crib:grab "세션 타임아웃 에러"
/code-crib:grab "인증" --type bugfix --limit 3
```

### `/code-crib:rack` - 문서 일괄 인덱싱

```bash
/code-crib:rack
/code-crib:rack --path ./docs/knowledge
```

### `/code-crib:analyze` - 코드베이스 분석

```bash
/code-crib:analyze
/code-crib:analyze --depth 5 --top 30
```

### `/code-crib:rag` - RAG 모드 제어

```bash
/code-crib:rag              # 현재 상태 표시
/code-crib:rag on           # RAG 모드 활성화
/code-crib:rag off          # RAG 모드 비활성화
/code-crib:rag "질문"       # 일회성 RAG 쿼리
```

### `/code-crib:inject` - 수동 컨텍스트 주입

```bash
/code-crib:inject src/auth/login.ts      # 단일 파일
/code-crib:inject src/components/*.tsx   # Glob 패턴
/code-crib:inject src/api/ --depth 2     # 디렉토리
```

---

## Project Structure

```
plugins/code-crib/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── code-crib:stash.md
│   ├── code-crib:grab.md
│   ├── code-crib:rack.md
│   ├── code-crib:list.md
│   ├── code-crib:remove.md
│   ├── code-crib:analyze.md
│   ├── code-crib:scope.md
│   ├── code-crib:rag.md
│   ├── code-crib:inject.md
│   ├── code-crib:toggle-rag.md
│   ├── code-crib:setup.md
│   └── code-crib:update.md
├── skills/
│   └── save/, search/, index/, analyze/, ...
├── agents/
│   ├── documenter.md
│   └── codebase-analyzer.md
├── hooks/
│   └── hooks.json
├── templates/
│   └── bugfix.md, feature.md, ...
└── code-crib.local.md
```

## License

MIT
