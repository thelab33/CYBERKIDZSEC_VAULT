// ⭐ Starforge Enhancements JS

// Auto-add .appear on scroll fade-in elements
document.querySelectorAll('.fade-in').forEach(el => {
  new IntersectionObserver(([entry]) => {
    if (entry.isIntersecting) entry.target.classList.add('appear');
  }).observe(el);
});

// Glow Mode toggle via #glow URL hash
if (location.hash === '#glow') {
  document.body.classList.add('glow-cta');
}

// Confetti on vault level-up
if (window.vault?.levelUp) {
  import('https://cdn.skypack.dev/canvas-confetti').then(m => m.default());
}

// Keyboard ESC closes open modals
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') {
    document.querySelectorAll('.modal.open').forEach(m => m.classList.remove('open'));
  }
});

// Simple tooltip polyfill (hook for enhancement)
document.querySelectorAll('[title]').forEach(el => {
  el.addEventListener('mouseenter', () => {
    // TODO: Custom tooltip enhancements here
  });
});
