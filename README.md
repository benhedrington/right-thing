# right-thing

**Eight skills that make an AI agent do product-management work the way a strong PM would: PRDs
anchored in evidence, launch go/no-go audits, feedback triage, experiment design and honest
retros.**

For agent builders: [superpowers](https://github.com/obra/superpowers) teaches your coding agent
to build it right; right-thing teaches it to build the right thing, and to learn whether it did.
Neither depends on the other.

## Try it first

1. Install `plan-improve` (see [Install](#install)), then type `/plan-improve` and paste a PRD.
2. You get a severity-rated defect list, each defect quoting the PRD, plus a build-ready rewrite.
3. Both are saved to one file, `plan-improve-<slug>-YYYY-MM-DD.md`, and the agent tells you its
   path.

## What a run produces

Every skill's file opens with a short decision header of the same shape, so the answer comes
first. This is `plan-improve`'s (invented content):

    ## Decision header
    **Verdict:** needs-revision — 4 must-fixes; the bulk-export PRD has no success metric.
    **Top must-fixes:** no success metric; two open questions undated; scheduling bundled in.
    **Confidence:** medium — the pain is quoted from 6 support tickets, the size is not measured.
    **Top 3 actions:** (1) add a baseline export-time metric — PM; (2) date the two open
    questions — PM; (3) re-scope the scheduling add-on into its own PRD — PM.

The full defect list, tables and workings follow below the header.

## Which skill do I need?

Start from where you are. You don't have to run the skills in order.

| You have… | Run |
|---|---|
| Messy notes, stakeholder asks or feedback, and no PRD yet | `plan-prd` |
| A draft PRD, yours or someone else's | `plan-improve` |
| Two to four competing options, and a debate about which to back | `plan-direction` |
| A PRD that engineering needs to start building | `plan-split` |
| A belief you want to test before building, or a ramp that is the test | `learn-experiment` |
| A release about to ship | `launch-read` |
| A pile of feedback, reviews or tickets | `learn-triage` |
| Results in, 60-90 days after launch or at quarter end | `learn-retro` |

## The skills

### Plan — before the build

| Skill | What it does |
|---|---|
| `plan-direction` — direction choice | Weighs 2-4 competing directions and recommends one: frozen criteria, reasoning-trap audit, reversibility, kill criteria, dated predictions. |
| `plan-prd` — PRD writing | Turns messy real-world input (sales notes, stakeholder asks, call summaries) into a problem-anchored PRD with cited requirements. |
| `plan-improve` — PRD review | Reviews an existing PRD and fixes it: a quoted, severity-rated defect list plus a build-ready rewrite. |
| `plan-split` — story breakdown | Slices a PRD into epics and stories with testable acceptance criteria, dependency edges, and traceability. |

### Launch — before it ships

| Skill | What it does |
|---|---|
| `launch-read` — launch readiness | Pre-ship audit: seven evidence checks, ending in go, go-with-conditions, or no-go. |

### Learn — after it ships

| Skill | What it does |
|---|---|
| `learn-retro` — retrospective | Compares expected vs. actual with quoted expectations, draws learnings that change behavior, and checks how well past predictions held up. |
| `learn-experiment` — experiment design | Turns a falsifiable hypothesis into a pre-registered experiment card: decision rule first, arithmetic shown, guardrails, stop conditions. |
| `learn-triage` — feedback triage | Turns a feedback dump into a ledger, pain clusters, verification, and routing (fix-now / to-plan / to-experiment / to-relationship / dismiss). |

> **Status: early, version 0.5.0.** We ran each skill blind on a deliberately strong input,
> written by the same team that wrote the skills. Most gave the expected verdict. `plan-improve`
> and `learn-triage` leaned cautious and were recalibrated; on re-test they returned
> build-ready-with-fixes and to-plan (pending pull). If a verdict seems too harsh, push back. The
> runs also caught real errors in the inputs themselves, which is what the skills are for.
> Treat the output as a strong first draft for a good PM to review, not a finished document.
> Expect changes; 1.0.0 will mark the first version we consider stable.

## The loop, and where the files go

When you do run several, they hand off to each other in this order, each one picking up the
earlier ones' files:

learn-triage → plan-prd → plan-improve → plan-split → launch-read → learn-retro →
plan-direction → plan-prd

with a side branch for tests: learn-triage, plan-direction or plan-prd → learn-experiment →
launch-read (when a ramp carries the test) → plan-prd / learn-retro.

Each file is saved to the working directory, unless you or the agent's harness name another.
Before starting, each skill looks there for what came before it:

- `plan-prd` reads learn-triage's to-plan clusters, learn-retro's handoffs addressed to it,
  plan-direction's chosen direction (with its riskiest assumption and kill criteria), and
  learn-experiment's ship results.
- `plan-improve` reads the PRD you give it; with none given, an existing PRD, often plan-prd's.
- `plan-split` reads plan-prd's PRD or plan-improve's rewrite.
- `launch-read` reads plan-prd (or plan-improve's rewrite, whichever is newer) and plan-split,
  kill criteria from plan-prd or plan-direction, and learn-experiment's cards when the release
  carries a test. Run learn-experiment first when a ramp is the test.
- `learn-retro` reads plan-prd's (or plan-improve's) outcome targets, plan-direction's predictions, and
  learn-experiment's decision rules and guardrails.
- `plan-direction` reads learn-retro's handoffs to the next cycle.
- `learn-experiment` reads learn-triage's to-experiment clusters, plan-direction's riskiest
  assumption, plan-prd's outcomes, counter-metrics and the open questions it hands over, and
  learn-retro's calibration note.
- `learn-triage` reads earlier triage runs (to reuse their weight scale) and launch-read's
  predicted inbound questions.

The loop closes on its own: `plan-prd` reads the direction memo, so a new PRD starts from the
chosen direction without you carrying it over.

**Run each initiative in its own folder.** The shared folder is what makes the loop work, and a
folder per initiative keeps one product's PRD from being built on another product's triage memo.
If a folder holds more than one file from the same skill, each skill uses the most recent one
whose topic matches your input, names the file it used, and asks you when more than one fits. A
re-run never overwrites an earlier file: the date is in the name.

**What to forward.** The full file is a working document. The decision header, and the shareable
version when you ask for one, is what you send on.

## What the skills need

- **File writes.** Every run saves its result to a file. Without a filesystem the run still
  answers in chat, but the handoff to the next skill is lost.
- **Fetching a cited source.** The skills can fetch the dashboards, exports and docs your input
  points to. Without that, anything not pasted in becomes a named data pull for you to run.
- **A shell,** for `learn-experiment`'s sample-size arithmetic. Without one, the card still shows
  every step of the arithmetic by hand, for you to check.

**Your data.** The skills invite pasting customer feedback, sales notes and account records: strip
personal data first, or follow your company's AI data policy.

## Words the skills use

- **Decision header:** the short block every output opens with: the verdict, how confident it
  is and why, and the top three actions with owners.
- **Go-with-conditions:** a launch verdict meaning "ship, if these named conditions are met by
  these dates", each with an owner and what happens if the date passes.
- **Provisional:** a feedback cluster sent on to planning even though the data to verify it does
  not exist yet. It says what is missing and what would settle it.
- **Pending pull:** a feedback cluster sent on to planning while the data to verify it exists but
  has not been checked yet. The pull, its owner and its date are the gate.
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

The copy-and-load install was verified with Claude Code on Linux at version 0.3.3 (the `git clone`
step itself was not run); the file layout has not changed since. If a skill fails to load, please open an issue.

**Codex / GPT agents.** Not yet verified by us. Codex's documentation places personal skills in
`~/.agents/skills/<skill-name>/` and repository skills in `.agents/skills/`, and requires `name` and
`description` in the frontmatter — ours have both. We have not run an install on a Codex machine, so
treat that path as documented, not tested. This section stays provisional until we have.

**Using these in a chat app.** Not yet verified by us. Where a chat app supports custom skills,
upload the skill's folder (often as a zip), or paste the contents of its `SKILL.md` where the app
accepts instructions. We have not tried this in any chat app, so treat it as untested.

## Credits

The skills are original work. Some ideas in their structure came from skills we studied by
other authors. Those authors are credited in [CREDITS.md](CREDITS.md). No third-party content is included in
this repository.

Positioning nod: [obra/superpowers](https://github.com/obra/superpowers), the build-side
harness these skills are designed to sit alongside.

## License

MIT — see [LICENSE](LICENSE). Changes: [CHANGELOG.md](CHANGELOG.md). Contributing:
[CONTRIBUTING.md](CONTRIBUTING.md).
