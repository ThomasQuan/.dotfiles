---
name: code-commenting
description: Use when writing, adding, reviewing, cleaning up, simplifying, or explaining comments in code — Go, Node.js, TypeScript, JavaScript, React, Svelte, Python, or Liquid. Applies five comment patterns (external reference, section separator, actionable marker, why-not-what, documentation block) plus best-practice rules for writing high-signal comments.
---

# Code Commenting

## When to use
Any task that touches comments: writing new ones, reviewing or pruning existing ones, simplifying an over-commented file, or explaining what a piece of code does/why it's written the way it is. Applies across Go, Node.js, TypeScript, JavaScript, React, Svelte, Python, and Liquid.

## Golden rule
Code tells you *how*, comments tell you *why*. Only write a comment when it carries information the code itself can't express. A bad comment is worse than no comment — it adds clutter and rots the moment the code changes under it.

## Before writing any comment, ask
- Would a better variable/function name make this comment unnecessary? If yes, rename instead of commenting.
- Am I about to restate the line in English (`i += 1 // add one to i`)? If yes, delete it.
- Is there a real, non-obvious reason driving this code — a bug workaround, a spec requirement, a business rule, an external source? If yes, that reason is the comment.

## The five patterns

### 1. External Reference
Use when code implements a formula, ported snippet, algorithm, or requirement sourced from outside the codebase (Stack Overflow, RFC, ticket, paper, security advisory). Link it directly above the code with one line of context — don't paraphrase the source, point to it.

```go
// Implementation derived from the spatial clustering algorithm detailed in:
// https://example-academic-archive.org
func clusterDataPoints(points []Point) {
```

```python
# Ported from https://stackoverflow.com/a/46018816 (Tomas Prochazka) —
# converts to bitmap using integer-only math for perf on this device.
def to_bitmap(...):
```

```ts
// See RFC 4180 (https://tools.ietf.org/html/rfc4180): CSV lines must be
// terminated with CRLF, hence the \r\n below.
csvBuilder.append("\r\n");
```

Use for: SO answers, Jira/Linear/GitHub issues, RFCs, security advisories, math/algorithm sources, license attribution (Stack Overflow code is CC-BY-SA and requires it).

### 2. Section Separator
Use only in long files or classes to mark real architectural phase boundaries (config, lifecycle methods, event handlers, parsing pipeline). Skip it in short files — it's just noise there.

```go
// ==========================================
// EVENT HANDLERS
// ==========================================
```

```python
# ------------------------------------------------------------------
# DATA VALIDATION
# ------------------------------------------------------------------
```

Same banner style works in Node/TS/JS and inside a Svelte `<script>` block.

### 3. Actionable Marker
Flag work that's intentionally out of scope right now with a recognized, greppable marker:

- `TODO:` — planned, not done yet
- `FIXME:` — known broken, needs a fix
- `HACK:` — works, but is a workaround rather than the right fix
- `NOTE:` — important context, not an action item

Link an issue when one exists so the "why" survives past the comment:

```go
// TODO(hal): decimal separator is hardcoded to '.' regardless of locale —
// see ISSUE-1425 for the follow-up.
```

Applies the same way in every language (`//` or `#` depending on syntax).

### 4. Why-Not-What (Intent/Context)
The default pattern for everyday inline comments. Explain *why* the code is non-obvious, in plain language a teammate can read without deep domain knowledge. Never restate *what* the line already says, and don't reach for low-level or overly technical wording — keep it simple enough that anyone on the team can follow it.

```python
# Anti-pattern (avoid):
# Increment index by 1
index += 1

# Pattern (good):
# Shift the index forward to skip the leading carriage-return byte
# required by the legacy hardware integration spec (v2.1).
index += 1
```

Rules of thumb:
- If you can't write the "why" clearly, that's a signal the code needs to be clearer — rewrite before commenting.
- No cleverness or inside jokes; a comment that needs its own comment has failed.
- Explain unidiomatic-looking code so nobody "cleans it up" into a bug.
- Add or update this-style comments when you fix a bug, referencing the issue/ticket if one exists.

### 5. Documentation Block
Use for exported/public functions, components, and any surface where callers need a contract — especially in untyped languages (JS, Svelte, Liquid) where the type system can't tell the reader anything. Skip it where the language's own signature already documents the contract well enough.

**JS / Node (untyped — include `{type}`):**
```js
/**
 * Calculates the total cost including tax.
 * @param {number} price - The base price of the item.
 * @param {number} taxRate - The tax rate applied (e.g., 0.13).
 * @returns {number} The total calculated cost.
 * @throws {TypeError} If parameters are not numeric values.
 */
function calculateTotal(price, taxRate) {
```

**TypeScript / TSX (typed — omit `{type}`, the signature already has it):**
```ts
/**
 * Calculates the total cost including tax.
 * @param price - The base price of the item.
 * @param taxRate - The tax rate applied (e.g., 0.13).
 * @returns The total calculated cost.
 */
function calculateTotal(price: number, taxRate: number): number {
```

**Go (godoc — sentence starts with the symbol name, no `@param` tags):**
```go
// CalculateTotal returns price plus tax at the given taxRate.
// taxRate is a fraction, e.g. 0.13 for 13%.
func CalculateTotal(price, taxRate float64) float64 {
```

**Python (docstring, Google style):**
```python
def calculate_total(price: float, tax_rate: float) -> float:
    """Calculate the total cost including tax.

    Args:
        price: The base price of the item.
        tax_rate: The tax rate applied (e.g., 0.13).

    Returns:
        The total calculated cost.
    """
```

**React (TSX component props):**
```tsx
/**
 * Product card with an optional price line.
 * @param product - Product to render.
 * @param showPrice - Whether to render the price row.
 */
function ProductCard({ product, showPrice }: ProductCardProps) {
```

**Svelte (component-level, top of `<script>`):**
```svelte
<!--
  @component
  Renders a product card with an optional price line.
  - `product`: product object to render
  - `showPrice`: whether to display the price
-->
<script lang="ts">
```

**Liquid (snippet-level `{% doc %}` block):**
```liquid
{% doc %}
  @param {product} product - The product object to render.
  @param {boolean} show_price - Whether to display the product price.
  @param {string} image_size - Image size, e.g. '300x300'.

  @example
  {% render 'product-card', product: product, show_price: true, image_size: '300x300' %}
{% enddoc %}
```

## Nine best-practice rules (condensed)
1. **Don't duplicate the code.** `i += 1 // add one to i` says nothing new — delete it.
2. **A good comment doesn't excuse unclear code.** If a name needs a comment to explain it, rename the thing instead.
3. **If you can't write a clear comment, the code has a problem.** Rewrite until you can explain it plainly — never write the equivalent of "you are not expected to understand this."
4. **Comments should dispel confusion, not cause it.** No riddles or in-jokes a future reader has to reverse-engineer.
5. **Explain unidiomatic code.** If something looks redundant or removable but isn't, say why — so nobody "cleans it up" into a bug.
6. **Link the source of copied code.** Stack Overflow answers, tutorials, gists — link both for context and attribution.
7. **Link external references** (RFCs, specs, advisories) right where they matter, not just buried in a design doc.
8. **Comment when fixing bugs.** Reference the issue/ticket so the "why" survives past the commit message.
9. **Mark incomplete work explicitly** with `TODO`/`FIXME` (pattern 3) rather than silently shipping a known gap.

## Quick checklist before finishing a commenting pass
- [ ] No comment merely restates its line or block.
- [ ] Every "why" comment is plain language, not jargon-heavy.
- [ ] External sources (SO, RFC, ticket, paper) are linked, not paraphrased from memory.
- [ ] Section separators appear only in long files, at real phase boundaries.
- [ ] `TODO`/`FIXME`/`HACK`/`NOTE` used consistently, issue-linked where possible.
- [ ] Public/exported functions have a documentation block in the language's native doc style (JSDoc, godoc, docstring, Liquid `{% doc %}`, Svelte `@component`).
- [ ] TypeScript docs skip redundant `{type}` tags since the signature already types it.
