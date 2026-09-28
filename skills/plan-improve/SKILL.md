---
name: plan-improve
description: "Red-pen an existing PRD: emit a defect list (each defect named, quoted, must-fix vs nit) and a rewritten build-ready PRD. Use when a PRD of unknown quality exists and needs to become usable."
metadata:
  version: "0.3.5"
  inspired-by: "pratikshadake/claude-product-management-skills :: prd-critic (verdict-with-findings format); pratikshadake/claude-product-management-skills :: problem-clarity (evidence gate); pratikshadake/claude-product-management-skills :: roadmap-reality-checker (capacity/dependency checks); kazdenc/builder-skills :: prd (what good looks like)"
---

# plan-improve — defect list + build-ready rewrite

**Output is a file, always.** The deliverable is a written artifact, not a chat reply: the request
is answered inside the artifact's decision header, the file is saved, and its path is named in the
closing message. A conversational answer alone is an incomplete run. Put the file in the working directory (or the artifacts directory if one exists) — never inside the inputs. The decision header is the artifact's first section, under the exact heading `## Decision header`, with **Verdict:**, **Confidence:** and **Top 3 actions** labelled as such.

## Inputs

- Required: the existing PRD, verbatim — the defect records quote it.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the docs, tickets and data the PRD references itself. Fetched data counts as
  evidence only when it carries a cited path or query; uncited fetched data is an assumption; data
  that exists nowhere is a named data pull, never a finding.
- Persistence: the artifact is the deliverable; its absence is an incomplete run. Never skip the file because the request reads as a conversation. Save the output to `<dir>/plan-improve-<slug>.md` (`<dir>` = the session's
  working-artifacts directory, or the working directory if none exists; never into the input directory itself); before starting, look in `<dir>` for any
  existing PRD, often plan-prd's (`plan-prd-*.md`).

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

- Fix every must-fix. Nits: fix the cheap ones. Cheap means fixable inside the rewrite without
  new information. The rest are listed unfixed at the end of Output 1: the unfixed-nits line
  closes the defect list, immediately before the verdict.
- Preserve the author's structure and voice where sound — improve, don't replace.
- Every false-completeness defect converts into a real Open Questions table
  (question | owner | deadline). Unknowns are surfaced, never smoothed away or deleted.
- Every requirement: numbered, cited where possible, pass/fail testable.
- Every timeline: a capacity basis, or a "no basis stated" flag.
- Bundled scope: split into separate PRDs, or recommend the split and rewrite the primary PRD to
  cover the core problem only.

## Output contract

**The artifact is the deliverable, not a chat reply.** If the request reads as a question, the
decision header is the answer — and the full artifact is still produced and saved to the path below.
A message in the conversation may summarize it; a summary never replaces it.

Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (build-ready,
needs-revision, or not-a-PRD, with the must-fix count); confidence (high/medium/low) with its
basis; the top 3 actions, each with an owner.

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
