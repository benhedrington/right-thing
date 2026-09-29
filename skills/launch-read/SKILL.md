---
name: launch-read
description: "Pre-ship audit of a feature or product: instrument check, criteria sweep, risk and support readiness, open-question audit. Outputs go / go-with-conditions / no-go. Use before GA or a major release."
metadata:
  version: "0.4.0"
  inspired-by: "right-thing :: plan-prd (testable-requirements gate -> the criteria sweep)"
---

# launch-read — pre-ship audit, go/no-go

Audits a release candidate on seven checks, scaled to its launch tier, and returns go, go-with-conditions or no-go.

**Output is always a file:** `<dir>/launch-read-<slug>.md`, opening `## Decision header` (**Verdict:**, **Confidence:**, **Top 3 actions**); chat alone is an incomplete run.

## Inputs

- Required: the release state — the PRD (requirements, outcome metrics, open questions, kill
  criteria) plus QA, risk, support and comms facts for the release candidate. The launch tier
  (flagged ramp, beta or GA) is the first question when it is not stated.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch staging dashboards, the risk register, the comms plan, and QA results
  itself. Fetched data counts as evidence only when it carries a cited path or query; uncited
  fetched data is an assumption; data that exists nowhere is a named data pull, never a finding.
- In a repo, check instrumentation, flags, migrations and tests before marking a check failed.
- Persistence: before starting, look in `<dir>` for plan-prd and plan-split outputs, and kill
  criteria from plan-prd or plan-direction.

## Stance

Launches fail on the unmeasured and the unrehearsed. Readiness is evidence on a checklist, not a
confidence. "Ready except QA" is not ready. No stakeholder — not the loudest account, not the
founder — gets a veto that skips an audit line; pressure is recorded as pressure, never as
evidence.

## Procedure — the seven checks

Where a check needs an artifact that neither the input nor a cited fetch provides (a risk
register, a comms plan, a metric inventory), the check fails on that absence — owners are
recorded as "unnamed — must be named", never invented.

**Launch tier first.** Name the tier; it sets which checks apply in full and which are relaxed.
If the tier is neither stated nor answered, audit at GA and say so.

- **Flagged ramp** — behind a feature flag, reaching a small share of users (e.g. 5%): checks 1,
  2, 3, 6 and 7 in full. Check 4 relaxes to: support or on-call knows the flag is live, what it
  changes, and who can turn it off. Check 5 relaxes to internal comms only.
- **Beta** — internal or opt-in users who know it is a beta: checks 1, 2, 3, 6 and 7 in full.
  Check 4 relaxes to a named feedback channel with an owner; check 5 to internal comms plus the
  beta invitation and its exit terms.
- **GA** — every user, or any external announcement or press: all seven checks in full.

A relaxed check is audited against its relaxed bar and marked "relaxed (tier)" in the checklist.
The no-go rules and the three-failure limit apply at every tier. Widening a ramp or beta to GA is
a new audit at GA tier.

1. **Instrument check.** Every PRD outcome metric has a live dashboard or report that already
   works on staging with seeded data. A launch whose success cannot be observed on day one is a
   failed launch with a press release. Unmeasurable metric = condition or no-go. A number with
   no named source — furnished in the input, or fetched with a cited path or query — is an
   assumption, never a finding.
2. **Criteria sweep.** Every requirement's pass/fail actually run on the release candidate — full
   sweep, no sampling. List the unverified explicitly; unverified is not unknown, it is a number.
3. **Risk sweep.** Top-3 failure scenarios, each with: owner, detection signal (where the alarm
   appears), and first response. The rollback plan is named and rehearsed — "just roll it back"
   without data/reverse-migration consideration is a wish, not a plan. A feature-flag kill switch
   is a valid rollback when it has been tested: the flag was turned off on staging or in
   production and the feature went dark, on a stated date. The flag does not undo data the
   feature already wrote; name what stays behind and how it is handled.
4. **Support readiness.** Who answers, with what doc, and the escalation path. Predict the top-5
   inbound questions and confirm each has an answer somewhere findable.
5. **Comms readiness.** Who hears what, when: internal, customers, and any specifically loud
   stakeholder. Dates, owners, drafted artifacts.
6. **Open-question audit.** Any PRD open question past its deadline blocks launch until re-dated
   with reason or closed. Stale unknowns do not age into safety.
7. **Kill criteria armed.** The launch has its own dated, metric-triggered kill criteria (from
   plan-prd/plan-direction). If none exist, that is itself a finding.

## Verdict

- **go** — all checks pass with evidence.
- **go-with-conditions** — conditions named: what, owner, deadline, and what happens if the
  deadline passes (auto-no-go or re-audit). One or two ordinary failed checks are conditions;
  three or more failed checks make the verdict no-go.
- **no-go** — with the shortest path to go, as a re-audit checklist. An unmeasurable primary metric,
  an unrun security-boundary criterion, or an open question past deadline is a no-go on its own,
  never a condition.
- **Working with thin data:** when the org has no staging dashboards or no clean instrumentation
  at all, a primary metric that can still be read on day one by a named interim method (a saved
  production query, a manual export, a log count) is measurable but unverified, and gets
  go-with-conditions, not no-go. The condition states plainly what is unverified (the metric has
  not been seen on staging), names the interim method, and says what would settle it: the method
  run and returning a number by a named date, with an owner, and auto-no-go or rollback if it
  does not. It counts as one failed check toward the three-failure limit. A primary metric with no
  way to be read at all stays a no-go.

## Output format

Decision header, first: a one-sentence verdict (go, go-with-conditions, or
no-go, with the tier); confidence (high/medium/low) with its basis; the top 3 actions, each with
an owner.

Then: launch tier and its basis -> checklist table (check | evidence found | pass/condition/fail,
or relaxed (tier)) -> conditions or path to go -> risk table (scenario | owner | detection | first
response) -> the top-5 predicted inbound questions, for learn-triage to check after launch.

## Anti-patterns

- Percent-complete readiness ("QA is 80% done" — which 20%, and is a security-boundary criterion in it?)
- Rollback as a verb with no rehearsal; dashboards that exist but show nothing on staging
- An external date pinned right after GA (a keynote, a big customer's demo) treated as a reason to skip checks
- GA-grade comms demanded of a 5% flagged ramp; a flag "we can always turn off" that no one has turned off

## Micro-example (checklist row + condition)

    | Check | Evidence found | Result |
    | 1. Instrument check | Primary metric "weekly listening minutes per subscriber" renders on
      staging with seeded data (dashboard staging/listening-weekly); secondary metric "offline
      plays synced" has no panel anywhere | condition |

    C-1: Build the offline-plays-synced panel and show it populated with seeded data on staging.
    Owner: analytics lead. Deadline: 2027-01-12, one week before GA. If missed: auto-no-go until
    check 1 re-passes on staging.

## Rules that always apply

Output file: `<dir>` is the artifacts directory, else the working directory, never the input's; name the path in the closing message. Refusals write the file too. The decision header alone may answer a quick question; the file is still written.

Owners: every owner is a role ("growth PM", "eng lead") or a person the user supplied; never guess a person's name. An owner the run cannot know is recorded as "unnamed — must be named", so no header assigns work to someone who never agreed to it.

Budget and overflow: the header holds only the verdict, its confidence and one-clause actions. Complete every mandated section; when the body runs long, move supporting detail (tables, workings) to an end appendix — relocated, never dropped.

Derived numbers: recompute every derived number from its source and show the arithmetic beside it (a header figure's may sit in the body); a claim asserts no more than its arithmetic shows. Never invent a datum or present an unsupported derivation as a source figure.

Shareable version: if the user asks for one, produce the same document with the ledger and appendices removed and citations kept as footnotes; the decision header still opens it.
