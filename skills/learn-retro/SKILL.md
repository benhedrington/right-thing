---
name: learn-retro
description: "Compare expected vs actual after a launch or planning cycle; extract behavior-changing learnings and a prediction-calibration note. Use 60-90 days post-launch, post-quarter, or after any plan's results are in."
metadata:
  version: "0.5.1"
  inspired-by: "see CREDITS.md"
---

# learn-retro — expected vs actual, honestly

Scores a plan's quoted expectations against actuals and turns each gap into a learning that changes how the team works.

**Output is always a file:** `<dir>/learn-retro-<slug>-YYYY-MM-DD.md`, opening `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

## Inputs

- Required: the plan artifacts with quotable expectations (PRD outcomes, memo predictions, dates,
  targets) and the results in.
- Missing pieces: ask at most 2 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch the dashboards, exports and account records behind the actuals itself.
  Fetched data counts as evidence only when it carries a cited path or query; uncited fetched
  data is an assumption; data that exists nowhere is a named data pull, never a finding.
- Persistence: before starting, look in `<dir>` for plan-prd's outcome targets (`plan-prd-*.md`,
  or plan-improve's rewrite `plan-improve-*.md` when it is the newer PRD for the topic),
  plan-direction's predictions (`plan-direction-*.md`), and learn-experiment's pre-registered
  decision rules and guardrail thresholds (`learn-experiment-*.md`).

## Stance

A retro that changes no behavior is theater. The discipline: quote what the plan said would
happen, measure what did, and make every learning a change to how we work. Hindsight re-litigation
without new information is banned; misses are named as misses, unmeasured rows are defects of the
plan, not passes.

## Procedure

1. **Expectation table.** Pull from the plan artifacts (PRD outcomes, dates, adoption targets) —
   quoted, with source (plan-prd section, memo line). No paraphrasing the plan into what we now
   wish it said. Compound expectations ("median load under 800 ms AND no regression on older
   devices") split into separate rows so each clause gets its own delta. An experiment card's
   pre-registered decision rule, its hypothesized effect size and each guardrail threshold are
   quoted expectations too, scored against the rule as written before the data — never as
   reread after it.
2. **Actuals table.** Same rows, measured values, each with a named source (dashboard, export,
   support tags). A number with a checkable source named for it — whether furnished in the input
   or fetched with a cited path or query — is evidence; a number with no named source is an
   assumption, never a finding. An unsourced
   qualitative actual is an anecdote, marked as one. Where a holdout or control group exists, the
   actual shows both the value as written and the treatment-minus-control lift: the delta scores
   the plan as written, and the calibration note uses the lift, so drift and seasonality are not
   credited to the feature. Where actuals exist per platform or segment and diverge in direction,
   add diagnostic sub-rows (not tallied) and name the divergence in the header.
3. **Delta per row:** beat | met | missed | unmeasured. Unmeasured is a defect of the plan — the
   retro names which planning choice caused the gap (usually an outcome chain without its
   measurement deliverable). An expectation the record never addresses is unmeasured, not met,
   and is traced like any other unmeasured row.
4. **Surprise audit.** The top 3 things that happened that were in no plan row. Unknown unknowns
   are where the next cycle's risk list comes from.
5. **Learning extraction.** Each learning states a CHANGE, not an observation. "Comms were late" is
   an observation; "launch-comms owner is now named at plan-prd's decision-clock stage" is a
   learning. Each learning has an owner and lands somewhere (a skill, a plan item, a policy).
6. **Calibration note.** State the fraction of predictions that proved right, separately for
   outcome predictions and delivery predictions (dates, scope), scoring
   plan-direction's dated predictions and learn-experiment's hypothesized effect sizes where they
   exist. Name any over-optimism or over-pessimism; the note feeds the confidence levels of
   future plan-direction memos.
7. **Next-cycle feed.** Which learnings change which upcoming decisions, stated as handoffs.

## Output format

Decision header, first: a one-sentence verdict (did the plan land — the
primary outcome's delta first, then the beat / met / missed / unmeasured tally); confidence (high/medium/low) with its basis; the top 3
actions, each with an owner.

Then: expectation vs actual table (row | expected, quoted | actual + source | delta) -> surprises ->
learnings (change | owner | lands-where) -> calibration note -> next-cycle handoffs.
Steps 1-2 may share one merged table, provided it keeps the source column.

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

## Rules that always apply

Output file: `<dir>` is the working directory, unless the user or harness names another; never the folder the input file sits in unless the user or harness named that folder. Name the file in the closing message; where files do not persist between sessions (a chat app), add one line telling the user to save it where the next skill can find it, such as the project's files. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Files between skills: another run's file may be in `<dir>`, attached by the user, or in the project's files; look in all that exist. When this skill's inputs say to read an upstream file and none is found, ask the user once whether one exists to attach — it counts toward the question budget — then proceed without it and say so. When reading another run's file, use the most recent one whose topic matches the input and name the file used in the body; if more than one plausibly matches, ask — it counts toward the question budget. Never overwrite: the filename carries the date (`<skill>-<slug>-YYYY-MM-DD.md`); if today's file already exists, add `-2` (then `-3`) and say so in the body. Never silently replace an earlier run's file.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it. The closing message offers it in one line, since most users will not know to ask.
