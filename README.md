# right-thing

**[superpowers](https://github.com/obra/superpowers) teaches your coding agent to build it right.
right-thing teaches it to build the right thing — and to learn whether it did.**

Eight skills for the product-management side of agent work: **Plan, Launch, Learn.** Build is
deliberately missing — your build harness owns that. Nothing here depends on superpowers, and
superpowers does not depend on this. Each works without the other.

> **Status: early.** These are version 0.4.0. So far they have been tried only on our own sample
> inputs, and we have not yet checked how they behave when the input is genuinely sound, so a
> cautious verdict (no-go, needs-revision, a discovery note instead of a PRD) may be over-cautious.
> Expect changes. Treat the output as a first draft a good PM would review, not a finished
> document — nothing here is claimed as proven or production-ready, and 1.0.0 will mark the first
> version we consider stable.

## The skills

### Plan — before the build

| Skill | What it does |
|---|---|
| `plan-direction` | Weighs 2-4 competing directions and recommends one: frozen criteria, reasoning-trap audit, reversibility, kill criteria, dated predictions. |
| `plan-prd` | Turns messy real-world input (sales notes, stakeholder asks, call summaries) into a problem-anchored PRD with cited requirements. |
| `plan-improve` | Red-pens an existing PRD: a quoted, severity-rated defect list plus a build-ready rewrite. |
| `plan-split` | Slices a PRD into epics and stories with testable acceptance criteria, dependency edges, and traceability. |

### Launch — before it ships

| Skill | What it does |
|---|---|
| `launch-read` | Pre-ship audit: seven evidence checks, ending in go, go-with-conditions, or no-go. |

### Learn — after it ships

| Skill | What it does |
|---|---|
| `learn-retro` | Compares expected vs. actual with quoted expectations, draws learnings that change behavior, and checks how well past predictions held up. |
| `learn-experiment` | Turns a falsifiable hypothesis into a pre-registered experiment card: decision rule first, arithmetic shown, guardrails, stop conditions. |
| `learn-triage` | Turns a feedback dump into a ledger, pain clusters, verification, and routing (fix-now / to-plan / to-experiment / to-relationship / dismiss). |

Each skill opens its output with a short decision header (verdict, confidence, top three actions
with owners) and saves the result to a file, so the next skill in the loop can pick it up.

## Words the skills use

- **Fragment:** one line of the input (a quote or short paraphrase) with its source, so later
  sections can point back to it.
- **Evidence:** a claim that comes from a named source someone else could check.
- **Assumption:** a claim that is plausible but has not been checked.
- **Unknown:** something nobody knows yet. It gets an owner and a date, not a guess.
- **Named data pull:** a specific query or export someone must run to answer a question. The
  skills list it instead of inventing the answer.
- **Decision clock:** a real date pushing the decision, such as a renewal or a board meeting, plus
  a plain statement of what that date does and does not justify.
- **Kill criteria:** a result and a date, written in advance, that mean "stop or rethink" if the
  numbers land there.
- **ITT (intention to treat):** count everyone put in each group of a test, even people who never
  saw the change.
- **Per-protocol:** count only the people who actually got the change. This tends to make results
  look better, so the skills ask you to say which count you used.

## Install

Every skill is one self-contained directory: `skills/<name>/SKILL.md`. Installing means copying
the directories you want. There is no plugin, and none is planned for v1.

**Claude Code.** Claude Code's documentation says personal skills go in
`~/.claude/skills/<skill-name>/SKILL.md`, and project skills go in
`.claude/skills/<skill-name>/SKILL.md`. To install one skill for yourself:

```sh
git clone https://github.com/benhedrington/right-thing.git
mkdir -p ~/.claude/skills
cp -r right-thing/skills/launch-read ~/.claude/skills/
```

Or copy all eight:
`cp -r right-thing/skills/plan-* right-thing/skills/launch-* right-thing/skills/learn-* ~/.claude/skills/`.
For one project only, use that project's `.claude/skills/` as the destination instead (create it
with `mkdir -p` first). Then type a skill's name as a command, such as `/launch-read`, followed by
your input, or describe the task and let the agent pick the skill.

What has been verified: the install path, with Claude Code on Linux, at version 0.3.3. All eight
skills loaded from a project's `.claude/skills/`, and one or all eight loaded from
`~/.claude/skills/`. `/launch-read`, invoked by name, ran from the project install and from the
one-skill personal install. In one try, the agent also picked `launch-read` without being named.
Every change since 0.3.3 is to skill prose and rules only; the file layout and the install steps
are unchanged, but the install has not been re-run on 0.4.0. Not yet run at any version: the
`git clone` step itself. If a skill fails to load, please open an issue.

**Codex / GPT agents.** Not yet verified by us. Codex's documentation places personal skills in
`~/.agents/skills/<skill-name>/` and repository skills in `.agents/skills/`, and requires `name` and
`description` in the frontmatter — ours have both. We have not run an install on a Codex machine, so
treat that path as documented, not tested. This section stays provisional until we have.

## Credits

The skills are original work. Some ideas in their structure came from skills we studied by
other authors. Those authors are credited in [CREDITS.md](CREDITS.md) and in each skill's
`inspired-by:` frontmatter. No third-party content is included in this repository.

Positioning nod: [obra/superpowers](https://github.com/obra/superpowers), the build-side
harness these skills are designed to sit alongside.

## License

MIT — see [LICENSE](LICENSE). Changes: [CHANGELOG.md](CHANGELOG.md). Contributing:
[CONTRIBUTING.md](CONTRIBUTING.md).
