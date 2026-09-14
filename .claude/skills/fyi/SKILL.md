---
name: fyi
description: Capture a quick side note while working on a code feature — a fix, a good pattern, an edge case, something to revisit later or in another session. Appends to a running inbox in Thomas's vault rather than writing a polished note. Usage — /fyi <note> (or with no args, jot down whatever was just discussed or found in the current conversation)
---

# FYI

## When to use
Thomas is mid-feature in some codebase and wants to jot something down without breaking flow — a bug worth fixing later, a pattern that worked well, an edge case to remember, something to pick up in a future session. This is raw capture, not writing. Don't polish it into vault voice (that's the separate `field-note` skill) — a short line or two, or a couple of bullets, is fine and usually better here.

## Where it goes
Every `/fyi` capture, from any project, is appended to a single running inbox file in Thomas's vault:

`/Users/thanhquan/Documents/thomas little library/Inbox/FYI Log.md`

Before appending, confirm the vault root actually exists at that path. If it's missing — new machine, moved vault, different user — don't guess at a replacement. Ask Thomas where the vault lives now, then:
- append the note to `Inbox/FYI Log.md` inside the path he gives you, and
- edit this file (the path above, and the one in Steps) to the new location, so future invocations don't have to ask again.

## Steps
1. Figure out what's being captured from whatever Thomas typed after `/fyi`, or from the current conversation if no argument was given. Keep it short — a sentence or two, or a couple of bullets if there's more than one distinct thing.
2. Note the source context: which project (repo folder name) and today's date. That's what makes the inbox scannable later.
3. Open `Inbox/FYI Log.md`. If a heading for today's date already exists, append under it; otherwise add a new `## <date>` heading. Group by project under that heading if more than one project has entries that day.
4. Write the entry as a raw, unpolished line or short bullet list — don't rewrite it into prose, don't add frontmatter, don't try to make it read well. The point is speed; Thomas (or a later `/field-note` pass) can turn it into something real when he reviews the inbox.
5. Confirm back in one line what was appended and where — don't repeat the whole inbox, just the new entry.
