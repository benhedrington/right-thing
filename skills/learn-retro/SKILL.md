---
name: learn-retro
description: "Compare expected vs actual after a launch or planning cycle; extract behavior-changing learnings and a prediction-calibration note. Use 60-90 days post-launch, post-quarter, or after any plan's results are in."
metadata:
  version: "0.3.4"
  inspired-by: "right-thing :: plan-prd (fragment-ledger discipline -> quoted expectations)"
---

# learn-retro — expected vs actual, honestly

## Inputs

- Required: the plan artifacts with quotable expectations (PRD outcomes, memo predictions, dates,
  targets) and the results in.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the dashboards, exports and account records behind the actuals itself.
  Fetched data counts as evidence only when it carries a cited path or query; uncited fetched
  data is an assumption; data that exists nowhere is a named data pull, never a finding.
- Persistence: save the output to `<dir>/learn-retro-<slug>.md` (`<dir>` = the session's
  working-artifacts directory; ask once if not obvious); before starting, look in `<dir>` for
  plan-prd's outcome targets (`plan-prd-*.md`) and plan-direction's predictions
  (`plan-direction-*.md`).

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
   support tags). A number with no named source (input-furnished, or fetched with a cited path
   or query) is an assumption, never a finding; inventing a datum is never allowed. An unsourced
   qualitative actual is an anecdote, marked as one.
3. **Delta per row:** beat | met | missed | unmeasured. Unmeasured is a defect of the plan — the
   retro names which planning choice caused the gap (usually an outcome chain without its
   measurement deliverable). An expectation the record never addresses is unmeasured — never
   "met" by inference from framing — and is traced like any other unmeasured row.
4. **Surprise audit.** The top 3 things that happened that were in no plan row. Unknown unknowns
   are where the next cycle's risk list comes from.
5. **Learning extraction.** Each learning states a CHANGE, not an observation. "Comms were late" is
   an observation; "launch-comms owner is now named at plan-prd's decision-clock stage" is a
   learning. Each learning has an owner and lands somewhere (a play, a plan item, a policy).
6. **Calibration note.** What fraction of predictions were right — scoring plan-direction's
   dated predictions where present? Over-optimism or over-pessimism, named — feeds the
   confidence levels of future plan-direction memos.
7. **Next-cycle feed.** Which learnings change which upcoming decisions, stated as handoffs.

## Output format

Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (did the plan land — the
beat / met / missed / unmeasured tally); confidence (high/medium/low) with its basis; the top 3
actions, each with an owner.

Then: expectation vs actual table (row | expected, quoted | actual + source | delta) -> surprises ->
learnings (change | owner | lands-where) -> calibration note -> next-cycle handoffs.
Expectations and actuals may be one merged table with that source column — one table satisfies
both procedure steps 1-2 and this format.

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

- "We learned a lot" — no behavior change named
- Actuals without sources; misses softened with narrative ("we basically hit it")
- Re-arguing decisions with hindsight but no new information
