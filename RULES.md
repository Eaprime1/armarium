# Armarium rules

`prima-clock: 202610172354`
`status: the hash rule is ratified by the Shepherd; protection is declared policy, not enforced.`

This file is the short version of how the Armarium is kept. The reasoning lives in custos at
`atelier/heritage-pipeline/ARMARIUM.md`. The record of the ratification is the custos carrier
`moav/armarium_moav_hashrule001.json`.

## 1. The hash rule (ratified)

The Shepherd agreed in a review comment on custos PR #463 (202610172244 UTC) and said "hash rule yes set it
up please" in the conversation after 202610172338 UTC (the message's own time was not recorded).

1. **An origin is hashed as the SHA-256 of its exact bytes.** No cleaning, no normalization.
2. **The hash lives beside the file** (`origin.sha256`), never inside it.
3. **The authoritative check is `sha256sum -c`.** Any machine has it, a phone in Termux included.
4. **An edit makes a new hash.** For an origin that means an amendment in `amendments/`, never a replacement.
5. Where a document must carry an embedded passport (the older format), the hash covers everything
   *before* one exact marker line, in one shared module, tested against `sha256sum` on the same bytes.

`bash tools/verify.sh` checks every origin and every commission pack against its hash file.

## 2. Additive only

Origins are not edited and not deleted. A correction is a dated file in `amendments/` that points at the
origin. A retired origin stays where it is; a note in `genizah/` (if that folder is ever built) says it
was retired and why. The original is untouched.

## 3. Protection: declared, not enforced

GitHub does not enforce branch protection or rulesets on a **private** repository outside a Team or
Enterprise account. So nothing technical stops a force-push or a deletion on `main`. The protection
here is therefore a promise, written down:

- **Nobody force-pushes `main`.** Not a person, not an assistant, not a bot.
- **Nobody deletes or rewrites anything under `origins/`.** A change is an amendment.
- **Every push to `origins/` is one origin per commit,** with `bash tools/verify.sh` passing first.
- **If this rule is ever broken,** say so in a dated file here, name what changed, and restore from the
  last good copy. Do not hide it.

What stands in for enforcement today is detection: `tools/verify.sh` shows any origin that no longer
matches its hash. A check that runs it automatically on every push is **not built yet**. If the plan is
ever upgraded, branch protection on `main` and a required check become possible, and this section is
replaced.

## 4. Time

Stamps are `YYYYMMDDHHMM` in UTC (`date -u '+%Y%m%d%H%M'`).

- Give a **start and a finish** when both are known.
- Where a time was not recorded, give a **best guess close to the real one and say it is a guess and how it
  was reached.** Never write an exact-looking stamp that was made up.
- A time typed by a person is read as the local time they wrote it in unless they say otherwise; when it
  is converted, the conversion is stated.

## 5. Commission packs

A **commission pack** is how documents move here from another repo (for example from the custos
atelier). It is a folder under `commissions/<YYYYMMDDHHMM>-<slug>/` with `manifest.json`, `files.sha256`
and `files/`. The sender keeps a **shadow copy** and a record of the hashes. A pack is checked on arrival
with `sha256sum -c files.sha256` (run `bash tools/verify.sh`). A pack is not an origin: it is the
carriage, and what it carries is judged separately. The design is in custos at
`atelier/heritage-pipeline/COMMISSION-PACK.md`.
