# Contributing

Thanks for looking. Issues and pull requests are welcome. Please read the rules below first:
they are strict because the skills are small, and small things break quietly.

## The roster is capped at eight

There are eight plays, and that is the limit. We cover the execution slice of product work:
Plan, Launch, Learn. We are not trying to cover all of product management. A proposal for a new
play has to show both of these:

- a real phase gap that none of the eight covers, and
- test mechanics that are clearly different from the existing plays.

Covering a topic for its own sake is not enough. If a proposal would push the roster above
eight, it has to say which play it replaces.

## Changes need evidence

Every change to a SKILL.md must cite evidence, in one of two forms:

- **A test log.** A transcript or output where the play failed, or did worse than it should
  have, on a realistic input. Show the input (redacted is fine), the output, and the exact line
  where it went wrong.
- **A cited review finding.** A specific defect in the skill text, quoted, with the reason it
  misleads an agent.

"It would be nicer if…" is not evidence. Wording polish without a failure behind it will
usually be declined, because every edit risks a regression somewhere else.

The maintainers re-test changed plays on an internal test suite before merging. That suite is
not published: its scenarios work like an exam, and publishing them would spoil it. You don't
need it to contribute. A reproducible failure on your own input is the evidence we want.

## Style rules for SKILL.md

- **Trigger-first descriptions.** The frontmatter `description` says what the skill does and
  when to use it, in that order, in one or two sentences. It is how an agent decides to load the
  skill, so write it for that.
- **Verbatim anchoring.** A play that makes a claim about the user's input quotes the input.
  Paraphrasing is not allowed where a quote is possible.
- **No invented data.** A number, owner, date, or quote that is not in the input, and was not
  fetched with a cited path or query, is an assumption and must be labeled as one. If data is
  missing, the play names the data pull that would get it. Inventing data is never acceptable,
  even as a placeholder.
- **Decision header first.** Every play's output opens with a header of at most 120 words:
  verdict, confidence with its basis, and the top three actions with owners.
- **Outputs under ~1,500 words** unless the user asks for depth. This is a soft cap. Required
  sections are finished, never cut to fit, and nothing is padded.
- **Neutral, generic examples.** Examples inside a skill should be short and domain-generic.
  Don't lift them from a real company or a known test scenario.
- **Versioning.** Bump the skill's `version:` and add a CHANGELOG entry. 1.0.0 marks the first
  stable release, and only the maintainer sets it.

## Credits

If a change borrows an idea from someone else's work, add it to the skill's `inspired-by:`
frontmatter and to [CREDITS.md](CREDITS.md). Credit the idea; don't paste the text. We don't
vendor third-party skills.

By contributing, you agree that your contribution is licensed under the repository's MIT
license.
