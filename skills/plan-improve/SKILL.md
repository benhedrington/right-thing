---
name: plan-improve
description: "Red-pen an existing PRD: emit a defect list (each defect named, quoted, must-fix vs nit) and a rewritten build-ready PRD. Use when a PRD of unknown quality exists and needs to become usable."
metadata:
  version: "0.4.0"
  inspired-by: "pratikshadake/claude-product-management-skills :: prd-critic (verdict-with-findings format); pratikshadake/claude-product-management-skills :: problem-clarity (evidence gate); pratikshadake/claude-product-management-skills :: roadmap-reality-checker (capacity/dependency checks); kazdenc/builder-skills :: prd (what good looks like)"
---

# plan-improve — defect list + build-ready rewrite

**Output is always a file:** `<dir>/plan-improve-<slug>.md` (artifacts directory, else working directory; never the input's), path named in the closing message. Refusals write it too; chat alone is an incomplete run. It opens `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**), which alone may answer a quick question, file still written.

## Inputs

- Required: the existing PRD, verbatim — the defect records quote it.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the docs, tickets and data the PRD references itself. Fetched data counts as
  evidence only when it carries a cited path or query; uncited fetched data is an assumption; data
  that exists nowhere is a named data pull, never a finding.
- Persistence: before starting, look in `<dir>` for any existing PRD, often plan-prd's
  (`plan-prd-*.md`).

## Stance

An existing PRD of unknown quality gets two outputs, in strict order: the defect list first, the
rewrite second. The rewrite is derived from the critique — never written around it, never
written before it.

## Procedure

### Pass 1 — the defect list (COMPLETE before any rewriting)

Read the PRD once end-to-end, then sweep the full taxonomy below. Every defect is a record:

    D-n | taxonomy name | verbatim quote from the original | must-fix or nit | what-fixed-looks-like (one line)

Verbatim quotes only. A critique that cannot be anchored to text is an opinion.

### The taxonomy — sweep all 11, every time

One record per distinct quoted span. Multiple instances in one category yield multiple records.
A span that offends two categories yields two records. Quote distinct substrings so no span is
counted twice in one category.

1. weak-problem-framing — solution-first or adjectives-as-problem; no user behavior cited
2. unmeasurable-success — "satisfaction goes up"; goals without baseline, target, or timeframe
3. vague-requirements — "ideally", "eventually", "snappy", "intuitive"
4. missing-acceptance-criteria — nothing a QA could pass or fail
5. invisible-risks-dependencies — committed work or shared systems, unmentioned
6. timeline-without-capacity — dates with no stated effort or team basis
7. undefined-jargon — terms doing load-bearing work, never defined ("next-gen workspace", "smart assist")
8. bundled-scope — two unrelated features riding in one PRD
9. marketing-tone — "world-class" and "game-changing" standing in for outcomes
10. fake-non-goals — "Out of scope: TBD" is not a non-goal; real non-goals name what was
    considered and declined
11. false-completeness — "Open questions: n/a" while unknowns visibly exist in the text

### Severity rule — tests, not vibes

must-fix = the defect blocks a testable requirement, a measurable goal, or an honest scope
statement. nit = style, wording, missing exemplar detail.
Tiebreaker question: could an engineer, given only this PRD, build it and know they are done?
If no — must-fix.

### Pass 2 — the rewrite

- Fix every must-fix. Nits: fix the cheap ones — those fixable inside the rewrite without new
  information — and list the rest, unfixed, as the last line of the defect list, immediately
  before the verdict.
- Preserve the author's structure and voice where sound — improve, don't replace.
- Every false-completeness defect converts into a real Open Questions table
  (question | owner | deadline). Unknowns are surfaced, never smoothed away or deleted.
- Every requirement: numbered, cited where possible, pass/fail testable.
- Every timeline: a capacity basis, or a "no basis stated" flag.
- Bundled scope: split into separate PRDs, or recommend the split and rewrite the primary PRD to
  cover the core problem only.

## Output contract

Decision header, first: a one-sentence verdict (build-ready,
needs-revision, or not-a-PRD, with the must-fix count); confidence (high/medium/low) with its
basis; the top 3 actions, each with an owner.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Output 1 — numbered defect list; each record is a compact block, one field per line (id |
taxonomy | quote | severity | what-fixed-looks-like). The verdict closes the defect-list section:
build-ready | needs-revision | not-a-PRD.
- needs-revision is a verdict on the input PRD. The must-fixes are applied in the rewrite, and
  residual risk is named there.
- not-a-PRD means the rewrite is not attempted; explain why.

Output 2 — the rewritten PRD, standalone and self-contained. Everything between the verdict and
the rewrite (split recommendations, notes) is Pass-2 scaffolding, labeled as such.

## Micro-example (defect record)

    D-2
    unmeasurable-success
    "Success: members love the new onboarding and churn improves."
    must-fix
    "Early churn: week-one cancellations among new members (23% baseline, June cohort report)
    drop to 17% or less within 45 days of launch, measured by the cohort dashboard."
