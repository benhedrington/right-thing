---
name: learn-retro
description: "Compare expected vs actual after a launch or planning cycle; extract behavior-changing learnings and a prediction-calibration note. Use 60-90 days post-launch, post-quarter, or after any plan's results are in."
metadata:
  version: "0.4.0"
  inspired-by: "right-thing :: plan-prd (fragment-ledger discipline -> quoted expectations)"
---

# learn-retro — expected vs actual, honestly

**Output is always a file:** `<dir>/learn-retro-<slug>.md` (artifacts directory, else working directory; never the input's), path named in the closing message. Refusals write it too; chat alone is an incomplete run. It opens `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**), which alone may answer a quick question, file still written.

## Inputs

- Required: the plan artifacts with quotable expectations (PRD outcomes, memo predictions, dates,
  targets) and the results in.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the dashboards, exports and account records behind the actuals itself.
  Fetched data counts as evidence only when it carries a cited path or query; uncited fetched
  data is an assumption; data that exists nowhere is a named data pull, never a finding.
- Persistence: before starting, look in `<dir>` for plan-prd's outcome targets (`plan-prd-*.md`) and
  plan-direction's predictions (`plan-direction-*.md`).

## Stance

A retro that changes no behavior is theater. The discipline: quote what the plan said would
happen, measure what did, and make every learning a change to how we work. Hindsight re-litigation
without new information is banned; misses are named as misses, unmeasured rows are defects of the
plan, not passes.

## Procedure

1. **Expectation table.** Pull from the plan artifacts (PRD outcomes, dates, adoption targets) —
   quoted, with source (plan-prd section, memo line). No paraphrasing the plan into what we now
   wish it said. Compound expectations ("median load under 800 ms AND no regression on older
   devices") split into separate rows so each clause gets its own delta.
2. **Actuals table.** Same rows, measured values, each with a named source (dashboard, export,
   support tags). A number with no named source — furnished in the input, or fetched with a cited
   path or query — is an assumption, never a finding. An unsourced
   qualitative actual is an anecdote, marked as one.
3. **Delta per row:** beat | met | missed | unmeasured. Unmeasured is a defect of the plan — the
   retro names which planning choice caused the gap (usually an outcome chain without its
   measurement deliverable). An expectation the record never addresses is unmeasured, not met,
   and is traced like any other unmeasured row.
4. **Surprise audit.** The top 3 things that happened that were in no plan row. Unknown unknowns
   are where the next cycle's risk list comes from.
5. **Learning extraction.** Each learning states a CHANGE, not an observation. "Comms were late" is
   an observation; "launch-comms owner is now named at plan-prd's decision-clock stage" is a
   learning. Each learning has an owner and lands somewhere (a play, a plan item, a policy).
6. **Calibration note.** State the fraction of predictions that proved right, scoring
   plan-direction's dated predictions where they exist. Name any over-optimism or
   over-pessimism; the note feeds the confidence levels of future plan-direction memos.
7. **Next-cycle feed.** Which learnings change which upcoming decisions, stated as handoffs.

## Output format

Decision header, first: a one-sentence verdict (did the plan land — the
beat / met / missed / unmeasured tally); confidence (high/medium/low) with its basis; the top 3
actions, each with an owner.

Then: expectation vs actual table (row | expected, quoted | actual + source | delta) -> surprises ->
learnings (change | owner | lands-where) -> calibration note -> next-cycle handoffs.
Steps 1-2 may share one merged table, provided it keeps the source column.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

## Anti-patterns

- "We learned a lot" — no behavior change named
- Actuals without sources; misses softened with narrative ("we basically hit it")
- Re-arguing decisions with hindsight but no new information

## Micro-example (expectation row + learning)

    | Row | Expected, quoted | Actual + source | Delta |
    | E-1 | "week-one cancellations among new members ... drop to 17% or less within 45 days of
      launch" (plan-prd, Outcomes) | 19.0% — 412 / 2,168 new members cancelled in week one,
      days 1-45 (cohort dashboard) | missed |

    L-1 — change: new-member targets are set per acquisition channel before plan-prd freezes
    them, because gift signups never saw the new onboarding. Owner: growth PM. Lands in: the
    outcomes chain of the next onboarding PRD.
