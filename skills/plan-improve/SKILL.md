---
name: plan-improve
description: "Review an existing PRD and fix it: a list of the problems found (each quoted, must-fix or nit) and a rewritten, build-ready PRD. Use when a draft or existing PRD needs checking before the team builds from it."
metadata:
  version: "0.5.1"
  inspired-by: "see CREDITS.md"
---

# plan-improve — defect list + build-ready rewrite

Reviews an existing PRD and fixes it: a quoted defect list against a 14-item taxonomy, then a build-ready rewrite derived from it.

**Output is always a file:** `<dir>/plan-improve-<slug>-YYYY-MM-DD.md`, opening `## Decision header` (**Verdict:**, **Top must-fixes:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

## Inputs

- Required: the existing PRD, verbatim — the defect records quote it.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the docs, tickets and data the PRD references itself. Fetched data counts as
  evidence only when it carries a cited path or query; uncited fetched data is an assumption; data
  that exists nowhere is a named data pull, never a finding.
- Persistence: a PRD the user supplied or named is the input; files in `<dir>` are context.
  When a plan-prd PRD for the same topic exists, the rewrite names which document it supersedes,
  so later skills read one PRD.
  When none was supplied, look in `<dir>` for an existing PRD, often plan-prd's
  (`plan-prd-*.md`).

## Stance

An existing PRD of unknown quality gets two outputs, in strict order: the defect list first, the
rewrite second. The rewrite is derived from the critique — never written around it, never
written before it.

A strong PRD should come back with few must-fixes. If you find more than about eight, check each
one against the severity test before recording it.

## Procedure

### Pass 1 — the defect list (COMPLETE before any rewriting)

Read the PRD once end-to-end, then sweep the full taxonomy below. Every defect is a record:

    D-n | taxonomy name | verbatim quote(s) from the original | must-fix or nit | what-fixed-looks-like (one line)

Verbatim quotes only. A critique that cannot be anchored to text is an opinion.

One record per root cause. Spans that fail for the same reason — the same undefined term, the same
unscoped rule — go in one record carrying several quotes, each verbatim, so the count is of
distinct problems, not distinct spans.

### The taxonomy — sweep all 14, every time

Distinct root causes in one category yield separate records; repeats of one cause share a record.
A span that offends two categories yields two records, counted once in the verdict's must-fix
count. No span is quoted twice in one category. A category with nothing to quote is listed as
clean, never filled with a stretched quote.

1. weak-problem-framing — solution-first or adjectives-as-problem; no user behavior cited
2. unmeasurable-success — "satisfaction goes up"; goals without baseline, target, or timeframe
3. vague-requirements — "ideally", "eventually", "snappy", "intuitive"
4. missing-acceptance-criteria — nothing a QA could pass or fail
5. invisible-risks-dependencies — committed work or shared systems, unmentioned; or goals and
   requirements that contradict each other (a new notification in a PRD whose goal is fewer
   opt-outs)
6. timeline-without-capacity — dates with no stated effort or team basis
7. undefined-jargon — terms doing load-bearing work, never defined ("next-gen workspace", "smart assist")
8. bundled-scope — two unrelated features riding in one PRD
9. marketing-tone — "world-class" and "game-changing" standing in for outcomes
10. fake-non-goals — "Out of scope: TBD" is not a non-goal; real non-goals name what was
    considered and declined
11. false-completeness — "Open questions: n/a" while unknowns visibly exist in the text
12. missing-user-definition — no named user or segment: "users" or "customers" with no who, which
    plan or role, or how many
13. missing-NFRs — no security, privacy, accessibility or performance requirement where the
    feature touches one (sign-in or permissions, personal data, a new screen, a latency-sensitive
    path). "Fast" with no number is vague-requirements; a missing performance line is this.

14. missing-rollout — no statement of how the build reaches users (flagged ramp, beta, GA;
    per platform when it ships in an app) for launch-read to audit.

Where the missing thing leaves no span to quote (12, 13, 14), quote the sentence or heading where it
should have been — the problem statement, the requirements list.

### Severity rule — tests, not vibes

must-fix = two competent engineers, given only this PRD, would build different things, or no one
could say whether the goal was met. Everything else is a nit: style, wording, missing exemplar
detail. A term a practitioner in the domain would read the same way is a nit, or at most an open
question — not a must-fix. An unanswered question is not a must-fix unless its answer changes
what gets built or how success is judged. Under the second clause, a date that the PRD's own
stated durations cannot meet, or a success claim whose metric cannot be read by the stated date,
is a must-fix.

### Pass 2 — the rewrite

- Fix every must-fix. Nits: fix the cheap ones — those fixable inside the rewrite without new
  information — and list the rest, unfixed, as the last line of the defect list, immediately
  before the verdict.
- Preserve the author's structure and voice where sound — improve, don't replace.
- Every false-completeness defect converts into a real Open Questions table
  (question | owner | deadline). Unknowns are surfaced, never smoothed away or deleted.
- Every requirement: numbered, cited where possible, pass/fail testable. A draft item that
  cannot be made testable without new information moves to the Open Questions table; it is not
  kept as a numbered requirement.
- Every timeline: a capacity basis, or a "no basis stated" flag.
- Bundled scope: split into separate PRDs, or recommend the split and rewrite the primary PRD to
  cover the core problem only.
- missing-user-definition gets a Target users and segment section; missing-NFRs a Non-functional
  requirements line; missing-rollout a Rollout section. Each entry is testable or, when the PRD gives no basis, an owned open
  question — never an invented segment or threshold.

## Output contract

Decision header, first: a one-sentence verdict (one of the four below, with the must-fix
count); the top 3-5 must-fixes (all, if fewer) by D-number, one clause each, most consequential first,
then any "exposed" nits: an unsourced fact or a date with no capacity basis that the decision
rests on, which stays a nit by the severity rule but can embarrass the PRD in review (its record
stays in the appendix);
confidence (high/medium/low) with its basis; the top 3 actions, each with an owner.

Output 1 — numbered defect list; each record is a compact block, one field per line (id |
taxonomy | quote(s) | severity | what-fixed-looks-like). The body carries the headline
must-fixes named in the header; every other record goes to the end appendix, same D-numbers —
relocated, never dropped. The verdict closes the defect-list section:
- build-ready — no must-fixes.
- build-ready-with-fixes — every must-fix is local: fixing it edits the quoted requirement,
  metric or term and leaves the problem statement, the target users and the in/out-of-scope
  list unchanged.
- needs-revision — at least one must-fix cannot be fixed without changing the problem statement,
  the target users or the scope. One such must-fix decides it, whatever the count.
- not-a-PRD — the rewrite is not attempted; explain why.

Verdicts judge the input PRD. Under build-ready-with-fixes and needs-revision the rewrite applies
every must-fix and names the residual risk.

Output 2 — the rewritten PRD, standalone and self-contained. Everything between the verdict and
the rewrite (split recommendations, notes) is Pass-2 scaffolding, labeled as such.

## Micro-example (defect record)

    D-2
    unmeasurable-success
    "Success: members love the new onboarding and churn improves."
    must-fix
    "Early churn: week-one cancellations among new members (23% baseline, June cohort report)
    drop to 17% or less within 45 days of launch, measured by the cohort dashboard."

## Rules that always apply

Output file: `<dir>` is the working directory, unless the user or harness names another; never the folder the input file sits in unless the user or harness named that folder. Name the path in the closing message. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Files between skills: when reading another run's file, use the most recent one whose topic matches the input and name the file used in the body; if more than one plausibly matches, ask — it counts toward the question budget. Never overwrite: the filename carries the date (`<skill>-<slug>-YYYY-MM-DD.md`); if today's file already exists, add `-2` (then `-3`) and say so in the body. Never silently replace an earlier run's file.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, the top must-fixes, the confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it. The closing message offers it in one line, since most users will not know to ask.
