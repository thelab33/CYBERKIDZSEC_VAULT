// init logic placeholder

document.addEventListener('keydown', e => { if (e.key === 'Escape') document.querySelectorAll('.modal.open').forEach(m => m.classList.remove('open')); });

if(localStorage.getItem('theme')==='dark'){document.documentElement.classList.add('dark')}else{document.documentElement.classList.remove('dark')}
document.addEventListener('keydown', e => { if (e.key === 'Escape') document.querySelectorAll('.modal.open').forEach(m => m.classList.remove('open')); });
if(localStorage.getItem('theme')==='dark'){document.documentElement.classList.add('dark')}else{document.documentElement.classList.remove('dark')}

document.querySelectorAll('.fade-in').forEach(el => new IntersectionObserver(([e]) => e.isIntersecting && e.target.classList.add('appear')).observe(el));

if (location.hash === '#glow') document.body.classList.add('glow-cta');

if (window.vault?.levelUp) import('https://cdn.skypack.dev/canvas-confetti').then(m => m.default());

// Confetti on vault level-up
if(window.vault?.levelUp){import('https://cdn.skypack.dev/canvas-confetti').then(m=>m.default());}

document.addEventListener('DOMContentLoaded', () => {
  const obs = new IntersectionObserver(([e]) => {
    if(e.isIntersecting){
      import('./bug_tales.js');
      obs.disconnect();
    }
  });
  const el = document.querySelector('.bug-tales');
  if(el) obs.observe(el);
});

document.getElementById('themeToggle')?.addEventListener('click', () => {
  if(document.documentElement.classList.toggle('dark')){
    localStorage.setItem('theme', 'dark');
  } else {
    localStorage.setItem('theme', 'light');
  }
});

// Starforge Motion JS Enhancements

// Fade-in appear on scroll using IntersectionObserver
document.querySelectorAll('.fade-in').forEach(el =>
  new IntersectionObserver(([entry]) => {
    if (entry.isIntersecting) {
      entry.target.classList.add('appear');
      entry.target.dispatchEvent(new CustomEvent('fadein:visible'));
    }
  }, { threshold: 0.15 }).observe(el)
);

// Close all modals on Escape key
document.addEventListener('keydown', e => {
  if (e.key === 'Escape') {
    document.querySelectorAll('.modal.open').forEach(modal => modal.classList.remove('open'));
  }
});

// Launch confetti on vault level-up event
function launchConfetti() {
  import('https://cdn.skypack.dev/canvas-confetti').then(({ default: confetti }) => {
    confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } });
  });
}
document.addEventListener('vault:levelup', () => {
  launchConfetti();
});

// Theme toggle button wiring (expects #themeToggle in DOM)
document.getElementById('themeToggle')?.addEventListener('click', () => {
  if (document.documentElement.classList.toggle('dark')) {
    localStorage.setItem('theme', 'dark');
  } else {
    localStorage.setItem('theme', 'light');
  }
});

// Smooth scroll progress bar update (#scrollProgress)
window.addEventListener('scroll', () => {
  const scrollProgress = document.getElementById('scrollProgress');
  if (!scrollProgress) return;
  const scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
  const scrollHeight = document.documentElement.scrollHeight - document.documentElement.clientHeight;
  const scrolled = (scrollTop / scrollHeight) * 100;
  scrollProgress.style.width = scrolled + '%';
});

// Bug Tales lazy load
document.addEventListener('DOMContentLoaded', () => {
  const observer = new IntersectionObserver(([entry]) => {
    if(entry.isIntersecting) {
      import('./bug_tales.js');
      observer.disconnect();
    }
  });
  const bugTalesEl = document.querySelector('.bug-tales');
  if(bugTalesEl) observer.observe(bugTalesEl);
});

// Glow mode injection from URL hash (#glow)
if (location.hash === '#glow') document.body.classList.add('glow-cta');

