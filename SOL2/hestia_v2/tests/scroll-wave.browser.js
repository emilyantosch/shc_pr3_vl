// Run in the homepage browser console (with reduced motion disabled).
(async () => {
  const wave = document.querySelector('.scroll-wave');
  const originalY = scrollY;
  const settle = () => new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)));
  const hidden = () => parseFloat(wave.style.getPropertyValue('--wave-hidden'));
  const check = (condition, message) => { if (!condition) throw new Error(message); };
  try {
    check(!!wave, 'Homepage wave exists');
    check(!matchMedia('(prefers-reduced-motion: reduce)').matches, 'Disable reduced motion for the scrolling check');
    scrollTo({ top: 0, behavior: 'instant' });
    await settle();
    const start = hidden();
    scrollTo({ top: document.documentElement.scrollHeight, behavior: 'instant' });
    await settle();
    check(hidden() < start && hidden() === 0, 'Wave extends to the footer');
    scrollTo({ top: 0, behavior: 'instant' });
    await settle();
    check(Math.abs(hidden() - start) < .01, 'Wave retracts when scrolling up');
    check(getComputedStyle(wave.querySelector('path')).stroke === getComputedStyle(document.querySelector('.footer')).backgroundColor, 'Wave matches footer purple');
    check(document.documentElement.scrollWidth <= innerWidth, 'No horizontal overflow');
    return 'Scroll wave checks passed';
  } finally {
    scrollTo({ top: originalY, behavior: 'instant' });
  }
})();
