---
name: plan-split
description: "Slice a PRD into epics and stories with testable acceptance criteria and dependency edges. Use after plan-prd when build planning starts, or when a plan needs to become assignable engineering work."
metadata:
  version: "0.4.0"
  inspired-by: "pratikshadake/claude-product-management-skills :: roadmap-reality-checker (dependency checks); kazdenc/builder-skills :: prd (testability gates, citation discipline)"
---

# plan-split — PRD to epics and stories

**Output is always a file:** `<dir>/plan-split-<slug>.md` (artifacts directory, else working directory; never the input's), path named in the closing message. Refusals write it too; chat alone is an incomplete run. It opens `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**), which alone may answer a quick question, file still written.

## Inputs

- Required: a PRD whose requirements are pass/fail testable — if they are not, run plan-improve
  first.
- Missing pieces: ask at most 2 questions (team capacity and target date come first), then proceed
  on stated assumptions. If the input is already a complete dossier, proceed with zero questions.
- The agent may fetch the PRD's referenced docs, team capacity and calendars, and committed work
  in the tracker itself. Fetched data counts as evidence only when it carries a cited path or
  query; uncited fetched data is an assumption; data that exists nowhere is a named data pull,
  never a finding.
- Persistence: before starting, look in `<dir>` for plan-prd's PRD (`plan-prd-*.md`) or
  plan-improve's rewrite (`plan-improve-*.md`).

## Stance

Slicing is where scope quietly grows and traceability quietly dies. Every story keeps the PRD's
citations and pass/fail discipline; every slice is independently demoable. If the input PRD's
requirements are not testable, STOP — run plan-improve first. Splitting a vague PRD just
distributes the vagueness.

## Procedure

### 1. Map requirements to epics
An epic is a user-visible outcome slice: something an end user, a customer, or a customer-side
admin can experience (a recurring report an admin reads qualifies); plumbing that serves no
visible outcome does not. An epic is never a team's component (no "backend epic", no "infra
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
demoable story inside two weeks of work is re-sliced. Put story size estimates in the story id
cell or in the size-check section, and say which.

### 6. Traceability
Every acceptance criterion traces to its requirement; every requirement traces to its epic.
The PRD's fragment citations ride along — a reviewer can walk story -> requirement -> evidence.

## Output format

1. Decision header, first: a one-sentence verdict (assignable now, or blocked
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

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

## Anti-patterns

- Component epics; stories without demos; criteria that restate the story title
- Conditional requirements treated as unconditional (the plan silently assumes the happy path)
- Overflow "handled" by stretching an epic until it fits

## Micro-example (story + blocked-by edge)

    EXT-1: flaky-test list API — platform team, committed for sprint 42

    | id | job story | acceptance criteria | blocked-by | carries-metrics |
    | S2.1 (3 days) | When my pipeline fails on a test I suspect is flaky, I want to see that on
      the failed-run page, so I can re-run without digging | AC1 [R2]: a run that fails on a
      test from the flaky list shows the flag. AC2 [R2]: a run that fails on a test not on the
      list shows no flag. | EXT-1 | re-runs of an unchanged commit (27% baseline, F06) |

    S2.2 (clear the flag after the test passes 20 consecutive runs) is blocked-by S2.1.
