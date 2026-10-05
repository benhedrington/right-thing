---
name: learn-experiment
description: "Design a validation experiment: falsifiable hypothesis, decision rule set before data, sample-size arithmetic, guardrails, stop conditions. Use when a belief needs testing before it becomes a build."
metadata:
  version: "0.5.0"
  inspired-by: "see CREDITS.md"
---

# learn-experiment — belief to tested decision

Turns a belief into a pre-registered experiment card: hypothesis, decision rule, sample size, guardrails and stop conditions.

**Output is always a file:** `<dir>/learn-experiment-<slug>-YYYY-MM-DD.md`, opening `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

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
  (`learn-triage-*.md`), plan-direction's riskiest assumption and kill criteria
  (`plan-direction-*.md`), and plan-prd's outcomes, counter-metrics and the open questions it
  hands to learn-experiment (`plan-prd-*.md`, or plan-improve's rewrite `plan-improve-*.md` when it
  is the newer PRD for the topic), and learn-retro's calibration note (`learn-retro-*.md`) for
  effect sizes the team has actually seen. Name the file each belief, baseline and guardrail came
  from.

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
   (reported, never decided on). The ship threshold is a significant result in the right
   direction (or a confidence-interval lower bound above a stated floor) — never an observed
   effect at least as large as the MDE: a test powered at the MDE that also demands an observed
   effect of that size ships a true MDE-sized effect only about half the time. The MDE sets n,
   not the bar. When the primary metric is a proxy for revenue or margin, name the money metric
   as a guardrail or secondary and say how the two could diverge. If the user insists on several primary metrics, or on several
   variants (A/B/n, each compared with control), divide alpha by the number of comparisons
   (Bonferroni) and carry that alpha into the arithmetic. When plan-prd set per-platform targets
   but per-platform volume cannot power each read, pool the platforms as the primary metric and
   read each platform as a secondary with a tripwire; say which was chosen. When the card's
   earliest read date differs from an upstream kill-criterion date, the card's read date governs
   and the kill criterion is re-dated, with the reason, in the PRD's open questions.
3. **Method:** control vs variant(s); assignment (randomized? cohort? geo?) and the planned split;
   exposure definition — who is in, when they enter, when they count. State ITT or per-protocol.
   An ITT denominator counts every assigned unit, including undelivered and unopened ones.
   For a change that ships in an app binary: the minimum app version, how existing users reach
   it (version adoption, new installs vs existing users as strata), whether assignment survives
   a cold start or an offline launch, and how the change is turned off without a new release.
4. **Arithmetic.** Baseline rate, minimum detectable effect, available volume, runtime: the test
   must be ABLE to detect the claimed effect within the window. If the numbers say it cannot,
   redesign — bigger effect, longer window, more volume, fewer variants, the non-randomized branch
   below, or don't run the test. Show the math, including the conventions (power, alpha,
   baseline) — numbers without conventions are not arithmetic.
   The MDE is the smallest effect worth shipping for, set from the business case before looking
   at volume; never back-solved from the sample you have. When an input to the business case is
   unknown (margin per unit, cost per treated user), state the break-even as a formula in that
   input, label where the MDE came from instead (a plan-direction kill criterion, a user
   statement), and name the data pull that would check it.
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
   denominator). With no shell, a ratio or mean metric's computation is named as a data pull for
   an analyst, with the inputs it needs: sigma from the pre-period and delta for a mean; those
   per-unit moments for a ratio.

   Unequal arms (a ramp with k control units per treatment unit, e.g. k = 3 for 25/75), with
   p1 = control and p2 = treatment:

       pbar = (p2 + k * p1) / (1 + k)
       n_t = ( z_a * sqrt(pbar * (1 - pbar) * (1 + 1/k)) + z_b * sqrt(p2*(1 - p2) + p1*(1 - p1)/k) )^2 / (p2 - p1)^2
       n_c = k * n_t; round both up. With k = 1 this is the equal-arm formula above.

   Assumptions: a two-sided test, equal arms unless the unequal formula is used, independent units, and the same metric definition
   in both arms. When any fails (unequal split, clustered units), say so and use the matching
   formula. For clustered units (households sharing an account, users within one store), multiply
   n by the design effect 1 + (m - 1) x ICC, where m is the mean cluster size and ICC the
   intra-cluster correlation from a pre-period; without a sourced ICC it is a named data pull.
   Where a shell is available, compute n with a short script; either way, the card shows
   the inputs and each step, and runtime = (the sum of every arm's n) / eligible units per day, rounded
   up to whole weeks (at least one): run whole weeks so weekly cycles fall evenly in every arm,
   even when n is reached sooner. When the metric is read a fixed time after entry (week-4
   retention, trial conversion at day 8, 30-day repeat purchase), the earliest read date is the
   end of enrollment plus that window; the card names that date, not just the enrollment
   runtime. When the eligible volume is itself an assumption, show the runtime at its low and
   high ends.

   Worked example: baseline 4%, MDE +0.5 pp, alpha 0.05, power 0.8.
   p1 = 0.04, p2 = 0.045, pbar = 0.0425.
   2 * 0.0425 * 0.9575 = 0.0813875, sqrt = 0.285285; 1.96 * 0.285285 = 0.559158.
   0.04 * 0.96 + 0.045 * 0.955 = 0.0384 + 0.042975 = 0.081375, sqrt = 0.285263;
   0.8416 * 0.285263 = 0.240077.
   (0.559158 + 0.240077)^2 = 0.799235^2 = 0.638777; 0.638777 / 0.005^2 = 0.638777 / 0.000025
   = 25,551.1 -> n = 25,552 per arm (rounded up), 51,104 in total. At an illustrative 2,000
   eligible users a day that is 26 days (51,104 / 2,000 = 25.6, rounded up), run as 4 whole
   weeks (28 days).
5. **Guardrails.** Metrics that must not degrade, with thresholds — success on the target metric
   while a guardrail breaks is a kill, not a win. Include the adjacent surfaces the change touches
   (notification opt-outs, checkout or paywall conversion, cost or margin per order, crash-free
   rate). State whether n can detect each guardrail's threshold; one it cannot is labeled a
   tripwire for gross harm, never read as proof of no harm.
   The first guardrail is the sample-ratio check: before any result is read, compare the observed
   arm counts with the planned split: chi-square = the sum over arms of (observed - expected)^2 /
   expected, where expected = total x the arm's planned share (for two arms on a 50/50 plan this
   is (n_A - n_B)^2 / (n_A + n_B)); with two arms, above 10.83 (p < 0.001) is a mismatch. A mismatch means assignment or logging is
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

Then the experiment card, as a table or as labeled sections: hypothesis | decision rule (primary metric named) | method | arithmetic
(shown) | guardrails | stop conditions | runtime (whole weeks) and earliest read date | owner | analysis plan
(sample-ratio check first, then metrics, cuts, what each result means). learn-retro scores the
decision rule and plan-prd ledgers a ship result, so write both to be quoted.

## Anti-patterns

- "Let's A/B it" with no decision rule; peeking without stop rules
- Testing effects the arithmetic cannot detect at available volume
- Declaring victory without reading guardrails; post-hoc metric shopping
- Reading a result before the sample-ratio check; stopping mid-week because n arrived early

## Rules that always apply

Output file: `<dir>` is the working directory, unless the user or harness names another; never the folder the input file sits in unless the user or harness named that folder. Name the path in the closing message. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Files between skills: when reading another run's file, use the most recent one whose topic matches the input and name the file used in the body; if more than one plausibly matches, ask — it counts toward the question budget. Never overwrite: the filename carries the date (`<skill>-<slug>-YYYY-MM-DD.md`); if today's file already exists, add `-2` (then `-3`) and say so in the body. Never silently replace an earlier run's file.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it. The closing message offers it in one line, since most users will not know to ask.
