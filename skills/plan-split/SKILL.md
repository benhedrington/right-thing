---
name: plan-split
description: "Slice a PRD into epics and stories with testable acceptance criteria and dependency edges. Use after plan-prd when build planning starts, or when a plan needs to become assignable engineering work."
metadata:
  version: "0.3.5"
  inspired-by: "pratikshadake/claude-product-management-skills :: roadmap-reality-checker (dependency checks); kazdenc/builder-skills :: prd (testability gates, citation discipline)"
---

# plan-split — PRD to epics and stories

**Output is a file, always.** The deliverable is a written artifact, not a chat reply: the request
is answered inside the artifact's decision header, the file is saved, and its path is named in the
closing message. A conversational answer alone is an incomplete run. Put the file in the working directory (or the artifacts directory if one exists) — never inside the inputs. The decision header is the artifact's first section, under the exact heading `## Decision header`, with **Verdict:**, **Confidence:** and **Top 3 actions** labelled as such.

## Inputs

- Required: a PRD whose requirements are pass/fail testable — if they are not, run plan-improve
  first.
- Missing pieces: ask at most 2 questions (team capacity and target date come first), then proceed
  on stated assumptions. If the input is already a complete dossier, proceed with zero questions.
- The agent may fetch the PRD's referenced docs, team capacity and calendars, and committed work
  in the tracker itself. Fetched data counts as evidence only when it carries a cited path or
  query; uncited fetched data is an assumption; data that exists nowhere is a named data pull,
  never a finding.
- Persistence: the artifact is the deliverable; its absence is an incomplete run. Never skip the file because the request reads as a conversation. Save the output to `<dir>/plan-split-<slug>.md` (`<dir>` = the session's
  working-artifacts directory, or the working directory if none exists; never into the input directory itself); before starting, look in `<dir>` for
  plan-prd's PRD (`plan-prd-*.md`) or plan-improve's rewrite (`plan-improve-*.md`).

## Stance

Slicing is where scope quietly grows and traceability quietly dies. Every story keeps the PRD's
citations and pass/fail discipline; every slice is independently demoable. If the input PRD's
requirements are not testable, STOP — run plan-improve first. Splitting a vague PRD just
distributes the vagueness.

## Procedure

### 1. Map requirements to epics
An epic is a user-visible outcome slice: something an end user, a customer, or a customer-side
admin can experience. A recurring report a customer-side admin reads counts; plumbing that serves
no visible outcome does not. An epic is never a team's component (no "backend epic", no "infra
epic"). Every requirement lands in exactly one epic. One requirement may span several stories,
and each of those stories inherits that requirement's criteria. Requirements that fit nowhere go
to the overflow table. Overflow is resolved BEFORE build starts, by descoping or re-scoping the
PRD, never by silent stretching.

### 2. Slice each epic into stories
Job-story format: "When [situation], I want to [motivation], so I can [expected outcome]."
Walking-skeleton first: the first story of each epic is the thinnest end-to-end slice that demos
the outcome — plumbing-only stories come after something demoable exists.

### 3. Acceptance criteria per story
Each story carries pass/fail criteria a QA can run on a build, inherited from its requirement's
criteria — never restating the story title. A story with no testable criteria is not a story;
it is a wish with an estimate.

### 4. Dependency edges
blocked-by edges between STORIES (not epics), including edges to committed work outside this
PRD — external commitments and decision gates are named nodes (EXT-n / DEC-n) declared before
the story tables. A dependency that is also a contingency (a conditional requirement) is marked conditional
with its condition; the plan states what the epic looks like both ways.

### 5. Size check
A story bigger than ~one week or needing two engineers together is split again. An epic with no
demoable story inside two weeks of work is re-sliced. Story size estimates ride in the story id
cell or in a dedicated size-check section — state which.

### 6. Traceability
Every acceptance criterion traces to its requirement; every requirement traces to its epic.
The PRD's fragment citations ride along — a reviewer can walk story -> requirement -> evidence.

## Output format

**The artifact is the deliverable, not a chat reply.** If the request reads as a question, the
decision header is the answer — and the full artifact is still produced and saved to the path below.
A message in the conversation may summarize it; a summary never replaces it.

1. Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (assignable now, or blocked
   by overflow, an open conditional, or untestable requirements — with epic and story counts);
   confidence (high/medium/low) with its basis; the top 3 actions, each with an owner.
2. Epic list — one outcome statement per epic, with its requirements
3. External commitments and decision gates — the EXT-n / DEC-n node table, declared before the
   story tables
4. Per-epic story table: id | job story | acceptance criteria | blocked-by | carries-metrics
   (which PRD outcome metric this story moves, if any)
5. Size check (story estimates vs the ~one-week / two-engineer bar)
6. Overflow table (unplaceable requirements + resolution)
7. Conditional requirements: condition, gate, and what the epic looks like both ways (when any exist)
8. Open questions (owned + dated)

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

- Component epics; stories without demos; criteria that restate the story title
- Conditional requirements treated as unconditional (the plan silently assumes the happy path)
- Overflow "handled" by stretching an epic until it fits
