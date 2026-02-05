---
description: Start an AI cypher - multi-model freestyle debate on a topic
argument-hint: "<topic>" [--crew model1,model2,...] [--mc model]
allowed-tools: Bash, Read, Write, Task
---

<!--
Usage examples:
  /cypher:start "REST vs GraphQL for mobile apps"
  /cypher:start "Best testing strategy for microservices" --crew claude,gpt,ollama
  /cypher:start "Database choice for real-time app" --mc claude --crew gpt,gemini,ollama
-->

# AI Cypher Session

Topic: $ARGUMENTS

## Instructions

1. **Parse Arguments**
   - Extract the topic (quoted string)
   - Extract --crew if provided (comma-separated model names, replaces --participants)
   - Extract --mc if provided (the host model, replaces --host)
   - If no crew specified, use default: claude, gpt, ollama

2. **Load Configuration**
   Check for user settings at `.claude/ai-cypher.local.md` for:
   - API configurations
   - Default crew members
   - Custom model commands

3. **Determine Cypher Format**
   Analyze the topic and decide:
   - **Round-based**: For structured debates (A vs B comparisons, pros/cons analysis)
   - **Free-form**: For brainstorming, exploration, open-ended questions

   Also determine optimal round count (2-5) based on topic complexity.

4. **Select MC (Host Model)**
   If --mc not specified, select based on topic:
   - Technical/code topics -> Claude or GPT
   - Creative/open topics -> Claude
   - Research/factual -> Gemini or GPT

   MC responsibilities:
   - Moderate the cypher
   - Ensure all crew members contribute
   - Synthesize viewpoints
   - Draft conclusion

5. **Initialize Cypher**
   Create cypher record:
   ```
   cyphers/YYYY-MM-DD-HH-MM-topic-slug.json
   ```

   Structure:
   ```json
   {
     "id": "uuid",
     "topic": "...",
     "format": "round|free",
     "rounds": N,
     "mc": "model-name",
     "crew": ["model1", "model2", ...],
     "startedAt": "ISO-timestamp",
     "transcript": [],
     "conclusion": null,
     "consensus": null
   }
   ```

6. **Execute Cypher**
   Use the Task tool with `cypher-host` agent to:
   - Coordinate crew responses via CLI tools
   - Manage turn-taking
   - Track cypher progress
   - Display real-time transcript

7. **Validate Consensus with Ralph Loop**
   After MC drafts conclusion:
   - Trigger ralph-loop to verify consensus quality
   - Check if all perspectives were fairly represented
   - Validate logical consistency of conclusion
   - Iterate if consensus is weak

8. **Finalize and Report**
   - Update JSON with final conclusion
   - Display formatted summary:
     - Topic and crew
     - Key points from each model
     - Areas of agreement/disagreement
     - Final consensus
     - Validation status

## Model CLI Commands Reference

Use these CLI patterns to invoke models (actual commands depend on user's setup):

- **Claude**: `claude --print -p "prompt"` or API
- **OpenAI/GPT**: `openai api chat.completions.create -m gpt-4 -g user "prompt"`
- **Ollama**: `ollama run modelname "prompt"`
- **Gemini**: Via API or configured CLI

Check `.claude/ai-cypher.local.md` for user's specific configurations.

## Output Format

Display cypher progress in real-time:

```
=== AI CYPHER: [Topic] ===
Format: [Round/Free] | Rounds: N | MC: [Model]
Crew: [list]

--- Round 1: Opening Bars ---
[Claude]: ...
[GPT]: ...
[Ollama]: ...

--- Round 2: Call and Response ---
...

--- MC Summary ---
[MC synthesizes cypher]

--- Ralph Loop Validation ---
Consensus Quality: [Strong/Moderate/Weak]
Representation: [Fair/Needs improvement]
Logic: [Consistent/Issues found]

=== Conclusion ===
[Final consensus statement]
```
