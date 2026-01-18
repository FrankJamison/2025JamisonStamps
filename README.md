# Jamison Stamps & Books (2025 site)

Static business website for Jamison Enterprises Stamps & Books.

This repo is mostly “plain HTML + CSS + JavaScript” (no build step). Pages share a common header/menu/footer/sidebar via small JavaScript include files that write HTML into the page. The stamps catalog page (`stamps/USA.htm`) is a client-side app that renders a large stamp inventory list from a JavaScript data array and integrates with PayPal’s cart.

## Tech stack

- **HTML/CSS**: Hand-authored static pages + a shared template stylesheet.
- **JavaScript**:
	- Site-wide template scripts (header/menu/footer/sidebar/calendar/contact).
	- A small jQuery utility file for the mobile menu toggle and the “scroll to top” arrow.
	- A standalone vanilla-JS catalog renderer for the stamp inventory.
- **Third-party**:
	- **jQuery 1.11.3**: `JQuery/jquery-1.11.3.min.js` (used by `js/javascripts.js`).
	- **PayPal Cart (NCP)**: loaded from `https://www.paypalobjects.com/ncp/cart/cart.js` on the stamps page.
	- `JQuery/jquery.simplePagination.js` exists in the repo but is not currently used by the stamps page (pagination is implemented in `stamps/js/stamps_v3.js`).

## Project layout (high level)

Key files/folders:

- `index.html`: Homepage.
- `about.htm`, `contact.htm`, `resources.htm`, `testimonials.htm`, `site_map.htm`, `thanks*.htm`: Content pages.
- `css/style.css`, `css/media-queries.css`: Global styling + responsive overrides.
- `js/`:
	- `header.js`: Injects the site header + logo.
	- `menu.js`: Injects the navigation links + mobile “hamburger” icon.
	- `footer.js`: Injects the footer and the “scroll to top” anchor.
	- `sidebar.js`: Injects the site-wide sidebar topic box.
	- `calendar.js`: Injects a small month calendar widget.
	- `contact.js`: Injects the contact/address block used on some pages.
	- `javascripts.js`: jQuery behaviors (scroll-to-top + mobile menu toggling/click-away).
- `picts/`: Images.
- `stamps/`: Stamps catalog mini-site (own `css/` and `js/`).
	- `stamps/USA.htm`: Catalog page (filters/sort/pagination + PayPal cart).
	- `stamps/css/stamps.css`: Catalog-specific styling.
	- `stamps/js/stamps_v3.js`: Inventory data + filter/sort/pagination + PayPal Add-to-Cart integration.

## How pages are composed (template-style “includes”)

Most pages follow the same pattern as `index.html`:

1. Load the global stylesheet(s).
2. Load jQuery and `js/javascripts.js` (site behaviors).
# Jamison Stamps & Books (2025)

This repository contains the 2025 version of the Jamison Stamps & Books website.

It’s intentionally simple and production-friendly: **static HTML + CSS + JavaScript** with no build step. Common page sections (header/nav/footer/sidebar) are shared via lightweight JavaScript “includes”, and the U.S. stamps catalog is a client-side, data-driven page with PayPal cart integration.

## Highlights (what I’m proud of)

- **Zero-build static site**: easy to host and maintain.
- **Shared layout without duplication**: header/menu/footer/sidebar are injected consistently across pages.
- **Stamps catalog UX**: client-side filter/search/sort/pagination for a large inventory dataset.
- **Performance-minded PayPal integration**: add-to-cart initialization is lazy so the page stays responsive.
- **SEO + accessibility improvements**:
  - Landmarks (`<header>`, `<nav>`, `<main>`, `<aside>`, `<footer>`), skip links, improved form semantics.
  - Canonicals + Open Graph/Twitter tags on core pages.
  - `robots.txt` + `sitemap.xml` included.

## Tech stack

- **HTML/CSS**: hand-authored pages + shared global styles.
- **JavaScript**:
  - Shared layout scripts in `js/` (header/menu/footer/sidebar/calendar/contact).
  - Small jQuery behaviors in `js/javascripts.js` (mobile menu + scroll-to-top).
  - Catalog logic + inventory data in `stamps/js/USA.js`.
- **Third-party**:
  - **jQuery 1.11.3** (`JQuery/jquery-1.11.3.min.js`).
  - **PayPal Cart (NCP)** (`https://www.paypalobjects.com/ncp/cart/cart.js`) on the stamps page.

## Project layout

- Core pages: `index.html`, `about.htm`, `contact.htm`, `resources.htm`, `site_map.htm`
- Utility/noindex pages: `missing.html`, `thanks.htm`, `thanks-payment.htm`
- Global styles: `css/style.css`, `css/media-queries.css`
- Shared scripts: `js/`
- Images: `picts/`
- Stamps mini-site:
  - Page: `stamps/USA.htm`
  - Styles: `stamps/css/stamps.css`
  - Logic + data: `stamps/js/USA.js`

## How pages are composed (shared “includes”)

Most pages load shared sections via `<script src="./js/header.js"></script>` style includes. Those scripts output HTML into the page (template-style) so I don’t have to copy/paste the same header/menu/footer into every file.

Important note: these scripts write markup during initial parsing, so they should not be deferred.

## The U.S. stamps catalog

The catalog lives at `stamps/USA.htm` and is rendered client-side by `stamps/js/USA.js`.

At a high level, it:

1. Uses a JavaScript `stamps` array as the inventory.
2. Filters by Scott # text search and dropdown selections.
3. Sorts by Scott # or price.
4. Paginates the results and renders each item as a stamp “card/row”.

### PayPal cart integration

The page loads PayPal’s cart SDK and renders add-to-cart buttons per item. PayPal initialization is done lazily (via `IntersectionObserver`) so only items that scroll into view incur setup work.

## Running locally

Because this includes third-party scripts (PayPal), it’s best to serve over HTTP rather than opening files directly.

### Option A: Use the VS Code task

This workspace includes a task that opens:

- `http://2025jamisonstamps.localhost/`

Run task: **Open in Browser**

### Option B: Any static server

Use any local static web server and point it at the repo root.

Examples:

```bash
# Python
python -m http.server 8080

# Node (if you have it installed)
npx serve .
```

## SEO and crawl control

- Sitemap: `sitemap.xml`
- Robots: `robots.txt`
- `/extras/` is intentionally excluded from indexing.

## Maintenance tips

- Header/logo: `js/header.js`
- Navigation: `js/menu.js`
- Footer: `js/footer.js`
- Inventory updates: `stamps/js/USA.js`

## Notes

- Some legacy template files include vendor notices. I keep those intact when the files are used.
	 - Sorts by Scott or price.
