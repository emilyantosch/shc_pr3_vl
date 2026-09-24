# Hestia v2

An independent Astro landing page for Hestia, styled with Tailwind CSS v4.

## Run locally

```sh
npm install
npm run dev
```

Open http://127.0.0.1:4325.

```sh
npm run check
npm run build
npm run preview
```

## Design

Based on the [MindMarket design reference and instructions on Refero](https://styles.refero.design/style/9130ad37-bf80-458f-b808-ac0ef6a8d1e9). The implementation uses its cream canvas, Inter typography, exact color palette, large headline scale, floating pill navigation, rounded white cards, flat illustrated sections, and yellow footer. Hestia content and the existing project link come from the sibling `hestia` project. This is a separate implementation; the original page is unchanged.

The design tokens are in `src/styles/global.css`. Inter is bundled locally through Fontsource. Illustrations are local assets generated specifically for this page; no third-party image requests are made in the browser. See `ARTWORK.md` for generation prompts.

Navigation, keyboard-accessible accordions, and the tag example work without a framework runtime. The core content and accordion interactions work without JavaScript. The navigation dropdown supports Escape and outside click, and the tag example announces changes. Motion respects the reduced-motion preference.

Hestia is described as being in early development. Primary actions link to the project's existing GitHub destination, rather than implying a packaged download exists. No repository, remote, or deployment is created by this project.
