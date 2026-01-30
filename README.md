# claude-crib 🏠

> **Where Claude Code comes to crash.**
>
> A curated collection of plugins, skills, and workflows that make Claude Code feel like home.
>
> Claude Code가 편히 쉬어가는 곳 — 플러그인, 스킬, 워크플로우 모음

[![Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blue.svg)](https://github.com/s1ckdark/claude-crib)
[![Version](https://img.shields.io/badge/version-2.0.0-green.svg)](https://github.com/s1ckdark/claude-crib)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

[English](#whats-this) | [한국어](#이게-뭐야)

---

## What's This?

Your personal plugin crib for [Claude Code](https://claude.ai/claude-code).

Think of it as your toolbox, your cheat codes, your secret sauce — all the stuff that turns Claude from "helpful assistant" into "coding partner who actually gets it."

## The Lineup

### 📦 [codecrib](./plugins/codecrib/)
> *Your knowledge stash for Claude Code*

RAG-powered memory that never forgets. Stash your wins, grab past solutions, never solve the same bug twice.

```bash
codecrib:stash --type bugfix --title "That auth bug that took 3 hours"
codecrib:grab "session timeout"  # boom, instant recall with related docs
```

**Core Features:**
- 💾 **Stash & Grab** — Save work context to vector DB, search with semantic understanding
- 🔗 **Related Docs** — Auto-discover related solutions when you search
- 🤖 **Auto-Document** — Session hook that saves significant work automatically
- 🏷️ **Smart Tagging** — Enhanced auto-tagging by domain, tech, pattern, and issue type
- 📊 **Codebase Analysis** — Scope out any codebase structure
- 🔀 **Collection Modes** — Project isolation or cross-project shared search

**Skills (codecrib: prefix):**
| Skill | What it does |
|-------|--------------|
| `codecrib:setup` | Interactive setup wizard |
| `codecrib:update` | Update plugin to latest version |
| `codecrib:stash` | Stash your work to the knowledge crib |
| `codecrib:grab` | Grab docs from your stash |
| `codecrib:rack` | Rack up local docs into the stash |
| `codecrib:list` | Check what's in your stash |
| `codecrib:remove` | Remove docs from your stash |
| `codecrib:analyze` | Analyze codebase structure |

**Agents:**
- `documenter` — Analyzes sessions, generates structured docs with smart tagging
- `codebase-analyzer` — Deep analysis of project structure and architecture

**Collection Modes:**

| Mode | Collection Name | Use Case |
|------|-----------------|----------|
| `project` | `codecrib-{project}` | Isolated per project (default) |
| `shared` | `codecrib` | Cross-project search enabled |

```bash
# Project mode (default) - isolated search
codecrib:grab "auth bug"

# Shared mode - search across all projects
codecrib:grab "auth bug" --project other-app
```

Configure in `plugins/codecrib/codecrib.local.md`:
```yaml
collection_mode: project  # or "shared"
```

---

## Quick Start

```bash
# Add the crib
/plugin marketplace add s1ckdark/claude-crib

# Install the plugin
/plugin install codecrib@claude-crib --scope project

# Run setup wizard
codecrib:setup
```

The setup wizard will guide you through:
1. **Vector DB** — Chroma (Docker/Local) or Pinecone (Cloud)
2. **Collection Mode** — Project isolation or shared search

Each project can have different settings stored in `codecrib.local.md`.

### Manual Setup (Alternative)

If you prefer manual configuration:

#### Option A: Pinecone (Cloud)
```bash
# 1. Get API key from https://pinecone.io
# 2. Add to ~/.claude/settings.json:
{
  "env": {
    "PINECONE_API_KEY": "your-api-key"
  }
}
# 3. Create index via Pinecone console or:
/pinecone quickstart
```

#### Option B: Chroma (Local)
```bash
# 1. Enable in plugins/codecrib/.mcp.json:
{
  "mcpServers": {
    "chroma": {
      "disabled": false  # Change to false
    }
  }
}

# 2. Run Chroma server (choose one):

# Option B-1: Docker (recommended)
docker run -p 8000:8000 chromadb/chroma

# Option B-2: Python local install
pip install chromadb
chroma run --host localhost --port 8000
```

See [codecrib README](./plugins/codecrib/README.md) for more details.

---

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│                      Your Coding Session                     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  🤖 Auto-Document Hook (on session end)                     │
│  - Detects significant work (bugs fixed, features added)    │
│  - Triggers documenter agent automatically                  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  📝 Documenter Agent                                        │
│  - Classifies work type (bugfix/feature/refactor/analysis)  │
│  - Extracts smart tags (domain, tech, pattern, issue)       │
│  - Generates structured markdown document                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  💾 Vector DB (Pinecone/Chroma)                             │
│  - Stores embeddings for semantic search                    │
│  - Links related documents by shared tags                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  🔍 Future Sessions                                         │
│  codecrib:grab "auth timeout" → Instant recall + related    │
└─────────────────────────────────────────────────────────────┘
```

---

## Philosophy

**Less searching. More shipping.**

Every plugin here exists because we got tired of:
- Re-explaining the same context every session
- Losing that perfect solution from 3 months ago
- Starting from scratch when the same bug hits again

This is the fix.

---

## 이게 뭐야?

[Claude Code](https://claude.ai/claude-code)를 위한 개인 플러그인 모음집입니다.

당신의 툴박스, 치트 코드, 비밀 소스 — Claude를 "도움이 되는 어시스턴트"에서 "진짜 이해하는 코딩 파트너"로 바꿔주는 모든 것.

### 핵심 기능

- 💾 **저장 & 검색** — 작업 컨텍스트를 벡터 DB에 저장하고 시맨틱 검색
- 🔗 **관련 문서** — 검색 시 관련 솔루션 자동 발견
- 🤖 **자동 문서화** — 세션 종료 시 의미있는 작업을 자동 저장
- 🏷️ **스마트 태깅** — 도메인, 기술, 패턴, 이슈 타입별 자동 태깅
- 📊 **코드베이스 분석** — 프로젝트 구조 심층 분석
- 🔀 **컬렉션 모드** — 프로젝트별 격리 또는 크로스 프로젝트 공유 검색

### 컬렉션 모드

| 모드 | 컬렉션 이름 | 용도 |
|------|------------|------|
| `project` | `codecrib-{프로젝트}` | 프로젝트별 격리 (기본값) |
| `shared` | `codecrib` | 크로스 프로젝트 검색 |

```bash
# Project 모드 (기본) - 격리된 검색
codecrib:grab "auth bug"

# Shared 모드 - 다른 프로젝트 검색
codecrib:grab "auth bug" --project other-app
```

설정 파일: `plugins/codecrib/codecrib.local.md`

### 빠른 시작

```bash
# 마켓플레이스 추가
/plugin marketplace add s1ckdark/claude-crib

# 플러그인 설치
/plugin install codecrib@claude-crib --scope project

# 설정 마법사 실행
codecrib:setup
```

설정 마법사가 안내합니다:
1. **Vector DB** — Chroma (Docker/로컬) 또는 Pinecone (클라우드)
2. **Collection 모드** — 프로젝트 격리 또는 공유 검색

각 프로젝트마다 다른 설정 가능 (`codecrib.local.md`).

### 수동 설정 (대안)

수동 설정을 원하면:

#### 옵션 A: Pinecone (클라우드)
```bash
# 1. https://pinecone.io 에서 API 키 발급
# 2. ~/.claude/settings.json에 추가:
{
  "env": {
    "PINECONE_API_KEY": "your-api-key"
  }
}
# 3. 인덱스 생성 (Pinecone 콘솔 또는):
/pinecone quickstart
```

#### 옵션 B: Chroma (로컬)
```bash
# 1. plugins/codecrib/.mcp.json에서 활성화:
{
  "mcpServers": {
    "chroma": {
      "disabled": false  # false로 변경
    }
  }
}

# 2. Chroma 서버 실행 (둘 중 선택):

# 옵션 B-1: Docker (권장)
docker run -p 8000:8000 chromadb/chroma

# 옵션 B-2: Python 로컬 설치
pip install chromadb
chroma run --host localhost --port 8000
```

자세한 설정은 [codecrib README](./plugins/codecrib/README.md)를 참조하세요.

---

## Project Structure

```
claude-crib/
├── .claude-plugin/
│   └── plugin.json          # Bundle manifest (v2.0.0)
├── .rag-docs/
│   └── structure/           # Codebase structure docs
├── plugins/
│   └── codecrib/
│       ├── .claude-plugin/
│       │   └── plugin.json  # Plugin manifest
│       ├── .mcp.json        # MCP servers (Chroma)
│       ├── codecrib.local.md # Collection mode config
│       ├── agents/          # documenter, codebase-analyzer
│       ├── skills/          # 8 skills (setup, update, stash, grab, rack, list, remove, analyze)
│       ├── hooks/           # auto-document on Stop
│       └── templates/       # bugfix, feature, refactor, analysis
└── README.md
```

---

## Coming Soon

- **claude-snippets** — Code templates that actually match your style
- **claude-flows** — Workflow automation for repetitive tasks
- **claude-collab** — Team knowledge sharing

---

## Contributing

Got a plugin idea? A workflow that changed your life?

PRs welcome. Keep it useful, keep it vibes.

## License

MIT — Do whatever. Credit appreciated but not required.

---

<p align="center">
  <i>Built with Claude, for Claude users.</i><br>
  <i>Claude로 만들고, Claude 유저를 위해.</i>
</p>
