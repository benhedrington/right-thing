---
name: plan-prd
description: "Turn messy real-world PM input — forwarded sales notes, stakeholder asks, call summaries — into a problem-anchored PRD. Use when raw product requests arrive and a PRD is needed, not when a clean spec already exists."
metadata:
  version: "0.3.4"
  inspired-by: "kazdenc/builder-skills :: prd (section skeleton, testability gates); pratikshadake/claude-product-management-skills :: outcome-definition (metric-baseline-timeframe chain); pratikshadake/claude-product-management-skills :: problem-clarity (workarounds as evidence); RefoundAI/lenny-skills :: defining-product-strategy (crux framing, clarity over certainty); alirezarezvani/claude-skills :: code-to-prd (evidence tagging, dependency mapping)"
---

# plan-prd — from messy input to a problem-anchored PRD

## Inputs

- Required: the raw input — forwarded notes, stakeholder asks, call summaries — plus any
  first-party facts that bear on it.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch referenced docs and exports (support exports, analytics queries, account
  records, prior PRDs) itself. Fetched data counts as evidence only when it carries a cited path
  or query; uncited fetched data is an assumption; data that exists nowhere is a named data pull,
  never a finding.
- Persistence: save the output to `<dir>/plan-prd-<slug>.md` (`<dir>` = the session's
  working-artifacts directory; ask once if not obvious); before starting, look in `<dir>` for
  learn-triage's to-plan signal memo (`learn-triage-*.md`) — its verified clusters enter the ledger.

## Stance

Real PM input is noisy: forwarded sales notes, stakeholder asks, call summaries — every narrator
biased toward their own outcome. This play never adopts the stated solution as the problem. It
converts fragments into evidence, and evidence into a bounded, testable PRD.

## Procedure

### 1. Build the fragment ledger

Decompose ALL input into one-line fragments before writing anything:

    [F01] "quote or one-line paraphrase" — source | kind | confidence

- kind: problem-signal | proposed-solution | constraint | fact | open-question
- confidence: evidence (named, checkable source) | assumption (plausible, unverified) | unknown
- A documented ask (a record that someone asked for something) splits: the record's existence is
  a fact at evidence confidence; the demand behind it is an assumption.

A number with no named source (input-furnished, or fetched with a cited path or query) is an
assumption, never a finding; inventing a datum is never allowed. A named source is a checkable
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
- FEWER THAN 2 EVIDENCE FRAGMENTS: do not write the full PRD. Output a discovery note instead
  (what to learn, from whom, by when). A PRD built on one narrator is a mirror, not a decision.

### 3. Define outcomes as a chain

behavior change -> metric -> baseline -> target -> timeframe -> measurement method.

No baseline? Then instrumenting it is deliverable #1. "Success: users are happier" fails the chain
(no baseline, no size-of-win, no method).

### 4. Sweep dependencies

List committed work, other teams' calendars, and shared systems this touches. Every swept dependency ends with a disposition: conflicts get wait | decouple | descope; non-conflicting dependencies get "no conflict — monitor". "We'll figure it out later" is a defect in the PRD, not a plan.

### 5. Bound the scope

- 8 requirements max in v1. More = reclassify or split the document.
- Every requirement cites at least one fragment ID and is labeled stated-solution (customer asked for this shape) or inferred-problem (we designed this shape to serve the problem). Tie-break for mixed citations: label by the evidence that justifies the requirement's SHAPE, not its existence.
- Every requirement is pass/fail testable. "Smooth and modern" is not a requirement; "an account
  admin who removes a user sees that user's sessions end within one minute" is.
- No solutions hiding as requirements: describe the user-visible behavior and its boundary, not the
  implementation.

### 6. Handle the decision clock

If a dated pressure exists (renewal, board date, compliance deadline), state it, then decide
explicitly what it does and does not buy. The honest options: serve-the-clock (ship a narrow
version), decouple (commit comms without the build), decline (say no, with reasons). Name the
choice and the reason. Clock pressure never silently expands scope.

### 7. Close with owned unknowns

Open questions table: question | owner | deadline | consequence-if-unanswered.
"None" is allowed only when the ledger holds zero unknown-confidence fragments.

## Output format

1. Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (the first move: full PRD,
   narrowed PRD, or discovery note, and why); confidence (high/medium/low) with its basis; the
   top 3 actions, each with an owner.
2. PRD: Problem (with fragment citations) / Outcomes chain / Non-goals /
   Requirements (cited, testable) / Dependencies & conflicts (with resolutions) / Decision clock /
   Open questions table
3. Appendix A — fragment ledger (compact)
4. Appendix B — scope decisions: accepted vs rejected requirements, with rationale on BOTH sides — why each accepted requirement earns its slot, and the fragment or reasoning behind each rejection

Budget and overflow: length is a judgement, not a line count. The header runs as long as the
verdict, its confidence and the top actions need, and then stops — no padding, no restating the
verdict, no qualifier that changes nothing. If it would grow past that, each action compresses to a
single clause and any rider (note, caveat, aside) moves to the body. The body carries the argument
and the evidence; if it is running well past what the work needs, the excess moves to an appendix
after the header, at the end of the artifact (the old ~1,500-word guide is a useful smell test, not
a limit to hit). This is how completeness and length coexist: every mandated section is still
completed — never cut to fit, nothing padded — by keeping its conclusion in the body and moving its
supporting detail (full tables, ledgers, workings) to the appendix. Material is relocated, never
dropped.

Derived numbers: every number derived from the input — a count, sum, share, percentage, delta or
rate — is recomputed once from its source before it is published, with the arithmetic shown beside
it (numerator and denominator, or the formula), and any claim resting on it (meets a target, a
majority, the largest) asserts no more than that arithmetic shows. In the header, where words are
capped, the arithmetic may sit at the figure's first statement in the body. Stating a real
derivation wrongly is a different failure from inventing a datum; both are forbidden.

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
