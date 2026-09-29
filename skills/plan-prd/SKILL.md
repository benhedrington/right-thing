---
name: plan-prd
description: "Turn messy real-world PM input — forwarded sales notes, stakeholder asks, call summaries — into a problem-anchored PRD. Use when raw product requests arrive and a PRD is needed, not when a clean spec already exists."
metadata:
  version: "0.4.0"
  inspired-by: "kazdenc/builder-skills :: prd (section skeleton, testability gates); pratikshadake/claude-product-management-skills :: outcome-definition (metric-baseline-timeframe chain); pratikshadake/claude-product-management-skills :: problem-clarity (workarounds as evidence); RefoundAI/lenny-skills :: defining-product-strategy (crux framing, clarity over certainty); alirezarezvani/claude-skills :: code-to-prd (evidence tagging, dependency mapping)"
---

# plan-prd — from messy input to a problem-anchored PRD

Turns sales notes, stakeholder asks and call summaries into a problem-anchored PRD with cited, pass/fail-testable requirements.

**Output is always a file:** `<dir>/plan-prd-<slug>-YYYY-MM-DD.md`, opening `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

## Inputs

- Required: the raw input — forwarded notes, stakeholder asks, call summaries — plus any
  first-party facts that bear on it.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch referenced docs and exports (support exports, analytics queries, account
  records, prior PRDs) itself. Fetched data counts as evidence only when it carries a cited path
  or query; uncited fetched data is an assumption; data that exists nowhere is a named data pull,
  never a finding.
- Persistence: before starting, look in `<dir>` for learn-triage's to-plan signal memo
  (`learn-triage-*.md`) — its verified clusters enter the ledger; plan-direction's memo
  (`plan-direction-*.md`) — its chosen direction, riskiest assumption and kill criteria feed the
  problem statement, the open questions and the outcomes; and learn-experiment's cards
  (`learn-experiment-*.md`) — a ship result is evidence for the ledger.

## Stance

Real PM input is noisy: forwarded sales notes, stakeholder asks, call summaries — every narrator
biased toward their own outcome. This skill never adopts the stated solution as the problem. It
converts fragments into evidence, and evidence into a bounded, testable PRD.

## Procedure

### 1. Build the fragment ledger

Decompose ALL input into one-line fragments before writing anything:

    [F01] "quote or one-line paraphrase" — source | kind | confidence

- kind: problem-signal | proposed-solution | constraint | fact | open-question
- confidence: evidence (named, checkable source) | assumption (plausible, unverified) | unknown
- A documented ask (a record that someone asked for something) splits: the record's existence is
  a fact at evidence confidence; the demand behind it is an assumption.
- Upstream artifacts enter as fragments with the file as source. A plan-direction memo is a
  decision, not evidence: its direction and kill criteria are constraints, its riskiest
  assumption an open-question, and only the evidence it cites counts toward the gate in step 2.
  A learn-experiment card whose decision rule returned ship is evidence for what the card
  measured and no more — a non-randomized result shows interest or usability, never a lift. A
  card with no result yet is an assumption.

A number with no named source — furnished in the input, or fetched with a cited path or
query — is an assumption, never a finding. A named source is a checkable
one ("the August billing export", not "we hear"). A venue without a named owner ("a figure
someone quoted at the offsite") is an assumption, not evidence. Commercial or commitment claims
("they'd roll it out to every region") are problem-signal (demand-side) at assumption confidence
until the commitment is in writing.
The ledger is the audit trail: every later section cites fragment IDs.

### 2. Name the problem

- The problem statement cites at least 2 independent fragments by ID.
- Independent means from different named sources; two IDs from the same source count once.
  Independence is a property of sources, not fragments. One fragment citing two sources can
  satisfy the gate. Several fragments relayed by one narrator (a forwarded sales note) are still
  one source. Distinct first-party datasets (export, telemetry, account records) are distinct
  sources.
- Existing behavior and workarounds are the strongest problem evidence — people already paying a
  cost to route around a gap is signal; people merely requesting a thing is noise.
- Stated solutions are recorded as proposed-solution fragments: inputs to weigh, never the frame.
- When a plan-direction memo exists, the problem statement serves its chosen direction and crux;
  a PRD that departs from them says why.
- Name the target users or segment the problem belongs to — who, which plan or role, how many —
  cited like the problem. "All users" needs a fragment that shows it.
- FEWER THAN 2 EVIDENCE FRAGMENTS: do not write the full PRD. Output a discovery note instead
  (what to learn, from whom, by when). A PRD built on one narrator is a mirror, not a decision.
- WORKING WITH THIN DATA: when exactly one independent source is at evidence confidence and the
  second does not exist in the org (no export, no telemetry, no second channel; not merely
  unfetched), write a narrowed PRD, not a discovery note. It opens with "Central risk: thin
  evidence", which names the one source, states plainly what is missing, and names the source that
  would upgrade it to a full PRD. Scope is cut to what that one source supports; producing the
  missing second source is requirement #1; confidence is never high. Zero evidence sources, or a
  second source that exists but was not fetched, still gets the discovery note or the named data
  pull.

### 3. Define outcomes as a chain

behavior change -> metric -> baseline -> target -> timeframe -> measurement method.

No baseline? Then instrumenting it is deliverable #1. "Success: users are happier" fails the chain
(no baseline, no size-of-win, no method).

plan-direction's kill criteria and dated predictions enter the outcomes quoted — as kill
criteria and outcome targets — so launch-read and learn-retro read the same numbers.

### 4. Sweep dependencies

List committed work, other teams' calendars, and shared systems this touches. Every swept dependency ends with a disposition: conflicts get wait | decouple | descope; non-conflicting dependencies get "no conflict — monitor". "We'll figure it out later" is a defect in the PRD, not a plan.

### 5. Bound the scope

- 8 requirements max in v1. More = reclassify or split the document.
- Every requirement cites at least one fragment ID and is labeled stated-solution (customer asked for this shape) or inferred-problem (we designed this shape to serve the problem). Tie-break for mixed citations: label by the evidence that justifies the requirement's SHAPE, not its existence.
- Every requirement is pass/fail testable. "Smooth and modern" is not a requirement; "an account
  admin who removes a user sees that user's sessions end within one minute" is.
- No solutions hiding as requirements: describe the user-visible behavior and its boundary, not the
  implementation.
- Non-functional requirements — security, privacy, accessibility, performance — get one line
  each: a testable bar, "not touched" with the reason, or an owned open question. They do not
  count toward the 8.
- Rollout: how the build reaches users (flagged ramp, beta, GA) and in what stages — the tier
  launch-read will audit.

### 6. Handle the decision clock

If a dated pressure exists (renewal, board date, compliance deadline), state it, then decide
explicitly what it does and does not buy. The honest options: serve-the-clock (ship a narrow
version), decouple (commit comms without the build), decline (say no, with reasons). Name the
choice and the reason. Clock pressure never silently expands scope.

### 7. Close with owned unknowns

Open questions table: question | owner | deadline | consequence-if-unanswered.
"None" is allowed only when the ledger holds zero unknown-confidence fragments. plan-direction's
riskiest assumption is a row unless a ledgered result has retired it.

## Output format

1. Decision header, first: a one-sentence verdict (the first move: full PRD,
   narrowed PRD (including the thin-data path), or discovery note, and why); confidence (high/medium/low) with its basis; the
   top 3 actions, each with an owner.
2. PRD: Problem (with fragment citations) / Target users and segment / Outcomes chain / Non-goals /
   Requirements (cited, testable) / Non-functional requirements (security, privacy,
   accessibility, performance) / Dependencies & conflicts (with resolutions) / Rollout /
   Decision clock / Open questions table
3. Appendix A — fragment ledger (compact)
4. Appendix B — scope decisions: accepted vs rejected requirements, with rationale on BOTH sides — why each accepted requirement earns its slot, and the fragment or reasoning behind each rejection

## Anti-patterns

- "Our users want..." — which fragment? who exactly?
- Solution-first framing (the ask becomes the title)
- A requirement without a citation
- A timeline without a capacity basis
- Unknowns rounded down to zero

## Micro-example (ledger -> requirement)

    [F02] "each squad loses about a day a month re-running flaky builds" — Priya (platform lead) relaying three squads | problem-signal | assumption
    [F06] "27% of failed pipeline runs in August were re-runs of an unchanged commit" — CI run-log export, August | problem-signal | evidence

    R2 (inferred-problem): An engineer whose pipeline fails on a known-flaky test sees that test
    flagged as flaky on the failed-run page [F02, F06]. Pass: a run that fails on a test from the
    flaky list shows the flag. Fail: the engineer must re-run blind to find out.

## Rules that always apply

Output file: `<dir>` is the working directory, unless the user or harness names another; never the input's own directory. Name the path in the closing message. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Files between skills: when reading another run's file, use the most recent one whose topic matches the input and name the file used in the body; if more than one plausibly matches, ask — it counts toward the question budget. Never overwrite: the filename carries the date (`<skill>-<slug>-YYYY-MM-DD.md`); if today's file already exists, add `-2` (then `-3`) and say so in the body. Never silently replace an earlier run's file.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it.
