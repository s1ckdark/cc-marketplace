# Dave's CC Marketplace

개인용 Claude Code 플러그인 마켓플레이스

## 설치

```bash
claude plugin marketplace add github:s1ckdark/cc-marketplace
```

## 플러그인 목록

| 플러그인 | 설명 | 상태 |
|----------|------|------|
| **claude-code-rag** | RAG 기반 지식 관리 - 작업 내역을 벡터 DB에 저장/검색 | 개발 중 |

## 플러그인 개별 설치

마켓플레이스 등록 후:
```bash
claude plugin install claude-code-rag
```

## 구조

```
cc-marketplace/
├── plugins/
│   └── claude-code-rag/
│       ├── plugin.json
│       ├── commands/
│       ├── agents/
│       ├── hooks/
│       └── templates/
└── README.md
```

## 라이선스

MIT
