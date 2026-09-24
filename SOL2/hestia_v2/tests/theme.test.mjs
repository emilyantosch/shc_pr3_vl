import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { runInNewContext } from 'node:vm';
import { test } from 'node:test';

const layout = readFileSync(new URL('../src/layouts/Layout.astro', import.meta.url), 'utf8');
const script = layout.match(/<script is:inline>([\s\S]*?)<\/script>/)[1];

test('theme follows system, persists toggles, and works without storage', () => {
  for (const saved of [null, 'hestia', 'hestia-dark']) {
    for (const systemDark of [false, true]) {
      for (const blocked of [false, true]) {
        const root = { dataset: {} };
        const meta = {};
        const favicon = {};
        const button = {
          setAttribute(name, value) { this[name] = value; },
          addEventListener(_, callback) { this.click = callback; },
        };
        let ready, change, stored;
        runInNewContext(script, {
          document: {
            documentElement: root,
            querySelector(selector) {
              if (selector.startsWith('meta')) return meta;
              if (selector.startsWith('link')) return favicon;
              return button;
            },
            addEventListener(_, callback) { ready = callback; },
          },
          window: { matchMedia: () => ({ matches: systemDark, addEventListener(_, callback) { change = callback; } }) },
          localStorage: {
            getItem() { if (blocked) throw Error('Blocked'); return saved; },
            setItem(key, value) { if (blocked) throw Error('Blocked'); assert.equal(key, 'hestia-theme'); stored = value; },
          },
        });
        const dark = !blocked && saved ? saved === 'hestia-dark' : systemDark;
        ready();
        assert.equal(root.dataset.theme, dark ? 'hestia-dark' : 'hestia');
        assert.equal(button['aria-pressed'], String(dark));
        change({ matches: !systemDark });
        const beforeClick = root.dataset.theme === 'hestia-dark';
        assert.equal(beforeClick, !blocked && saved ? dark : !systemDark);
        button.click();
        assert.equal(button['aria-pressed'], String(!beforeClick));
        assert.equal(meta.content, beforeClick ? '#f5f1e4' : '#171a15');
        assert.ok(favicon.href.includes(beforeClick ? '_light_' : '_dark_'));
        if (!blocked) assert.equal(stored, root.dataset.theme);
        change({ matches: beforeClick });
        assert.equal(button['aria-pressed'], String(!beforeClick));
      }
    }
  }
});
