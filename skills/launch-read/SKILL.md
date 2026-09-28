---
name: launch-read
description: "Pre-ship audit of a feature or product: instrument check, criteria sweep, risk and support readiness, open-question audit. Outputs go / go-with-conditions / no-go. Use before GA or a major release."
metadata:
  version: "0.3.4"
  inspired-by: "right-thing :: plan-prd (testable-requirements gate -> the criteria sweep)"
---

# launch-read — pre-ship audit, go/no-go

## Inputs

- Required: the release state — the PRD (requirements, outcome metrics, open questions, kill
  criteria) plus QA, risk, support and comms facts for the release candidate.
- Missing pieces: ask at most 3 questions, then proceed on stated assumptions. If the input is
  already a complete dossier, proceed with zero questions.
- The agent may fetch staging dashboards, the risk register, the comms plan, and QA results
  itself. Fetched data counts as evidence only when it carries a cited path or query; uncited
  fetched data is an assumption; data that exists nowhere is a named data pull, never a finding.
- In a repo, check instrumentation, flags, migrations and tests before marking a check failed.
- Persistence: save the output to `<dir>/launch-read-<slug>.md` (`<dir>` = the session's
  working-artifacts directory; ask once if not obvious); before starting, look in `<dir>` for
  plan-prd and plan-split outputs, and kill criteria from plan-prd or plan-direction.

## Stance

Launches fail on the unmeasured and the unrehearsed. Readiness is evidence on a checklist, not a
confidence. "Ready except QA" is not ready. No stakeholder — not the loudest account, not the
founder — gets a veto that skips an audit line; pressure is recorded as pressure, never as
evidence.

## Procedure — the seven checks

Where a check needs an artifact that neither the input nor a cited fetch provides (a risk
register, a comms plan, a metric inventory), the check fails on that absence — owners are
recorded as "unnamed — must be named", never invented.

1. **Instrument check.** Every PRD outcome metric has a live dashboard or report that already
   works on staging with seeded data. A launch whose success cannot be observed on day one is a
   failed launch with a press release. Unmeasurable metric = condition or no-go. A number with
   no named source (input-furnished, or fetched with a cited path or query) is an assumption,
   never a finding; inventing a datum is never allowed.
2. **Criteria sweep.** Every requirement's pass/fail actually run on the release candidate — full
   sweep, no sampling. List the unverified explicitly; unverified is not unknown, it is a number.
3. **Risk sweep.** Top-3 failure scenarios, each with: owner, detection signal (where the alarm
   appears), and first response. The rollback plan is named and rehearsed — "just roll it back"
   without data/reverse-migration consideration is a wish, not a plan.
4. **Support readiness.** Who answers, with what doc, and the escalation path. Predict the top-5
   inbound questions and confirm each has an answer somewhere findable.
5. **Comms readiness.** Who hears what, when: internal, customers, and any specifically loud
   stakeholder. Dates, owners, drafted artifacts.
6. **Open-question audit.** Any PRD open question past its deadline blocks launch until re-dated
   with reason or closed. Stale unknowns do not age into safety.
7. **Kill criteria armed.** The launch has its own dated, metric-triggered kill criteria (from
   plan-prd/plan-direction). If none exist, that is itself a finding.

## Verdict

- **go** — all checks pass with evidence
- **go-with-conditions** — conditions named: what, owner, deadline, and what happens if the
  deadline passes (auto-no-go or re-audit). An ordinary failed check is a condition, unless
  failed checks accumulate.
- **no-go** — with the shortest path to go, as a re-audit checklist. An unmeasurable primary metric,
  an unrun security-boundary criterion, or an open question past deadline is no-go-level, not a condition

## Output format

Decision header, first — as long as the verdict and its actions need, and no longer: a one-sentence verdict (go, go-with-conditions, or
no-go); confidence (high/medium/low) with its basis; the top 3 actions, each with an owner.

Then: checklist table (check | evidence found | pass/condition/fail) -> conditions or path to go
-> risk table (scenario | owner | detection | first response).

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

- Percent-complete readiness ("QA is 80% done" — which 20%, and is a security-boundary criterion in it?)
- Rollback as a verb with no rehearsal; dashboards that exist but show nothing on staging
- An external date pinned right after GA (a keynote, a big customer's demo) treated as a reason to skip checks
