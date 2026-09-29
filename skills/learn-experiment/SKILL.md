---
name: learn-experiment
description: "Design a validation experiment: falsifiable hypothesis, decision rule set before data, sample-size arithmetic, guardrails, stop conditions. Use when a belief needs testing before it becomes a build."
metadata:
  version: "0.4.0"
  inspired-by: "right-thing :: plan-direction (kill-criteria discipline -> pre-registration)"
---

# learn-experiment — belief to tested decision

Turns a belief into a pre-registered experiment card: hypothesis, decision rule, sample size, guardrails and stop conditions.

**Output is always a file:** `<dir>/learn-experiment-<slug>.md`, opening `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

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
   before any data. A test with no decision rule is a demo with extra steps. The rule reads ONE
   primary metric, named before data; every other metric is a guardrail or a secondary metric
   (reported, never decided on). If the user insists on several primary metrics, or on several
   variants (A/B/n, each compared with control), divide alpha by the number of comparisons
   (Bonferroni) and carry that alpha into the arithmetic.
3. **Method:** control vs variant(s); assignment (randomized? cohort? geo?) and the planned split;
   exposure definition — who is in, when they enter, when they count. State ITT or per-protocol.
   An ITT denominator counts every assigned unit, including undelivered and unopened ones.
4. **Arithmetic.** Baseline rate, minimum detectable effect, available volume, runtime: the test
   must be ABLE to detect the claimed effect within the window. If the numbers say it cannot,
   redesign — bigger effect, longer window, more volume, fewer variants, the non-randomized branch
   below, or don't run the test. Show the math, including the conventions (power, alpha,
   baseline) — numbers without conventions are not arithmetic.
   For a conversion-rate metric use the two-proportion sample size, per arm:

       n = ( z_a * sqrt(2 * pbar * (1 - pbar)) + z_b * sqrt(p1*(1 - p1) + p2*(1 - p2)) )^2 / (p2 - p1)^2
       p1 = baseline, p2 = baseline + MDE, pbar = (p1 + p2) / 2,
       z_a = 1.96 (alpha 0.05, two-sided), z_b = 0.8416 (power 0.8); round n up

   With a Bonferroni alpha, z_a changes: three comparisons give alpha 0.05 / 3 = 0.0167 and
   z_a = 2.394 (two-sided).

   For a mean metric per randomized unit (revenue per user, minutes per subscriber), per arm:

       n = 2 * (z_a + z_b)^2 * sigma^2 / delta^2
       sigma = the metric's standard deviation per unit, from a pre-period of the same population
       delta = the MDE in the metric's units; round n up

   sigma is a required input: without a sourced sigma there is no n, only a named data pull.
   Illustrative: sigma 30 minutes, delta 2 minutes -> 2 * 2.8016^2 * 900 / 4 = 2 * 7.84896 *
   900 / 4 = 3,532.03 -> n = 3,533 per arm. A ratio whose denominator is not the randomized unit
   (minutes per session when users are randomized) needs the delta method: compute it with a
   script and state its inputs (per-unit means, variances and covariance of numerator and
   denominator).

   Assumptions: a two-sided test, equal arms, independent units, and the same metric definition
   in both arms. When any fails (unequal split, clustered units), say so and use the matching
   formula. Where a shell is available, compute n with a short script; either way, the card shows
   the inputs and each step, and runtime = (number of arms x n) / eligible units per day, rounded
   up to whole weeks (at least one): run whole weeks so weekly cycles fall evenly in every arm,
   even when n is reached sooner.

   Worked example: baseline 4%, MDE +0.5 pp, alpha 0.05, power 0.8.
   p1 = 0.04, p2 = 0.045, pbar = 0.0425.
   2 * 0.0425 * 0.9575 = 0.0813875, sqrt = 0.285285; 1.96 * 0.285285 = 0.559158.
   0.04 * 0.96 + 0.045 * 0.955 = 0.0384 + 0.042975 = 0.081375, sqrt = 0.285263;
   0.8416 * 0.285263 = 0.240077.
   (0.559158 + 0.240077)^2 = 0.799235^2 = 0.638777; 0.638777 / 0.005^2 = 0.638777 / 0.000025
   = 25,551.1 -> n = 25,551 per arm, 51,102 in total. At an illustrative 2,000 eligible users a
   day that is 26 days (51,102 / 2,000 = 25.6, rounded up), run as 4 whole weeks (28 days).
5. **Guardrails.** Metrics that must not degrade, with thresholds — success on the target metric
   while a guardrail breaks is a kill, not a win. Include the adjacent surfaces the change touches.
   The first guardrail is the sample-ratio check: before any result is read, compare the observed
   arm counts with the planned split. For two arms on a 50/50 plan, chi-square = (n_A - n_B)^2 /
   (n_A + n_B); above 10.83 (p < 0.001) is a mismatch. A mismatch means assignment or logging is
   broken: read no result, find the cause, and rerun or repair before any decision.
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

Then the experiment card: hypothesis | decision rule (primary metric named) | method | arithmetic
(shown) | guardrails | stop conditions | runtime (whole weeks) | owner | analysis plan
(sample-ratio check first, then metrics, cuts, what each result means). learn-retro scores the
decision rule and plan-prd ledgers a ship result, so write both to be quoted.

## Anti-patterns

- "Let's A/B it" with no decision rule; peeking without stop rules
- Testing effects the arithmetic cannot detect at available volume
- Declaring victory without reading guardrails; post-hoc metric shopping
- Reading a result before the sample-ratio check; stopping mid-week because n arrived early

## Rules that always apply

Output file: `<dir>` is the artifacts directory, else the working directory, never the input's; name the path in the closing message. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it.
