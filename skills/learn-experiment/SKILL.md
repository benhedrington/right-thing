---
name: learn-experiment
description: "Design a validation experiment: falsifiable hypothesis, decision rule set before data, sample-size arithmetic, guardrails, stop conditions. Use when a belief needs testing before it becomes a build."
metadata:
  version: "0.4.0"
  inspired-by: "right-thing :: plan-direction (kill-criteria discipline -> pre-registration)"
---

# learn-experiment — belief to tested decision

**Output is always a file:** `<dir>/learn-experiment-<slug>.md` (artifacts directory, else working directory; never the input's), path named in the closing message. Refusals write it too; chat alone is an incomplete run. It opens `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**), which alone may answer a quick question, file still written.

## Inputs

- Required: the belief to test, plus the baseline rate and available volume for the metric it
  claims to move.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch baseline rates, volume counts, and the calendar of concurrent launches and
  campaigns itself. Fetched data counts as evidence only when it carries a cited path or query;
  uncited fetched data is an assumption; data that exists nowhere is a named data pull, never a
  finding.
- Persistence: before starting, look in `<dir>` for learn-triage's to-experiment clusters
  (`learn-triage-*.md`).

## Stance

An experiment is a decision tool, not a feature demo. The decision rule is written before the data
exists; the arithmetic must be able to detect the effect claimed; and winning is not winning if a
guardrail broke. Write it all down before launch — the experiment card IS the pre-registration;
edits after data starts are logged as revisions.

## Procedure

1. **Hypothesis, falsifiable:** "We believe [change] will move [metric] by [size] because
   [mechanism]." No mechanism, no hypothesis — return to the drawing board.
2. **Decision rule FIRST:** what result ships it, kills it, or iterates — numeric thresholds set
   before any data. A test with no decision rule is a demo with extra steps.
3. **Method:** control vs variant; assignment (randomized? cohort? geo?); exposure definition —
   who is in, when they enter, when they count. State ITT or per-protocol. An ITT denominator
   counts every assigned unit, including undelivered and unopened ones.
4. **Arithmetic.** Baseline rate, minimum detectable effect, available volume, runtime: the test
   must be ABLE to detect the claimed effect within the window. If the numbers say it cannot,
   redesign — bigger effect, longer window, more volume, the non-randomized branch below, or don't
   run the test. Show the math, including the conventions (power, alpha, baseline) — numbers
   without conventions are not arithmetic.
   For a conversion-rate metric use the two-proportion sample size, per arm:

       n = ( z_a * sqrt(2 * pbar * (1 - pbar)) + z_b * sqrt(p1*(1 - p1) + p2*(1 - p2)) )^2 / (p2 - p1)^2
       p1 = baseline, p2 = baseline + MDE, pbar = (p1 + p2) / 2,
       z_a = 1.96 (alpha 0.05, two-sided), z_b = 0.8416 (power 0.8); round n up

   Assumptions: a two-sided test, equal arms, independent units, and the same metric definition
   in both arms. When any fails (unequal split, clustered units, a ratio or mean metric), say so
   and use the matching formula. Where a shell is available, compute n with a short script;
   either way, the card shows the inputs and each step, and runtime = 2n / eligible units per day.

   Worked example: baseline 4%, MDE +0.5 pp, alpha 0.05, power 0.8.
   p1 = 0.04, p2 = 0.045, pbar = 0.0425.
   2 * 0.0425 * 0.9575 = 0.0813875, sqrt = 0.285285; 1.96 * 0.285285 = 0.559158.
   0.04 * 0.96 + 0.045 * 0.955 = 0.0384 + 0.042975 = 0.081375, sqrt = 0.285263;
   0.8416 * 0.285263 = 0.240077.
   (0.559158 + 0.240077)^2 = 0.799235^2 = 0.638777; 0.638777 / 0.005^2 = 0.638777 / 0.000025
   = 25,551.1 -> n = 25,551 per arm, 51,102 in total. At an illustrative 2,000 eligible users a
   day that is a 26-day runtime (51,102 / 2,000 = 25.6, rounded up).
5. **Guardrails.** Metrics that must not degrade, with thresholds — success on the target metric
   while a guardrail breaks is a kill, not a win. Include the adjacent surfaces the change touches.
6. **Attribution honesty.** What else changes in the window (seasonality, campaigns, other
   launches); how confounds are handled; what would make the read untrustworthy.
7. **Stop conditions.** Early-stop rules and their triggers, dated — anchored to a stated Day 0
   (the first randomized exposure) when no calendar date is given; a peek without a pre-set stop
   rule is an unregistered test.

### Non-randomized branch

At low volume, or when the question is "will anyone want this" or "can they use it" rather than
"how much does it move the metric", a non-randomized test is often the right test — not "don't
run". Name the type: fake door or painted door (an entry point to a feature that does not exist
yet, measuring who tries it; tell those users afterwards), concierge (the service delivered by hand
to a few users), or a 5-user usability test (tasks observed, failures recorded). Its decision rule
is still set before data: a threshold on a count, e.g. "at least 30 of the first 600 exposed users
click the fake door ships the design work; fewer than 10 kills it; in between, iterate the copy
once", or "3 or more of 5 users fail task 2 blocks the build until it is redesigned". Honest
limits: it can show that interest exists, that a usability problem exists, or that people will use
a hand-run version; it cannot show a causal lift, the size of an effect, retention, or a rate that
generalizes beyond the sample. The card says which of these the result can and cannot support, and
a claimed metric lift still needs the randomized design.

## Output format

Decision header, first: a one-sentence verdict (run, redesign, or don't run; a run names
randomized or non-randomized — can the arithmetic detect the claimed effect, or what can the
non-randomized test establish?); confidence (high/medium/low) with its basis; the top 3 actions,
each with an owner.

Then the experiment card: hypothesis | decision rule | method | arithmetic (shown) | guardrails | stop conditions |
runtime | owner | analysis plan (metrics, cuts, what each result means).

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

## Anti-patterns

- "Let's A/B it" with no decision rule; peeking without stop rules
- Testing effects the arithmetic cannot detect at available volume
- Declaring victory without reading guardrails; post-hoc metric shopping
