#!/usr/bin/env bash

set -euo pipefail

echo " Starforge Motion Setup Started..."

# Paths
CSS_UTILS="static/css/utilities/animations.css"
JS_INIT="static/js/init.js"
HUD_STATUS="templates/components/hud_status.html"

# 1. Append CSS utilities for glow, fade, pulse, tooltip, and HUD blink
cat >> "$CSS_UTILS" <<'EOF'

/* Starforge Motion CSS Enhancements */

/* Glow on hover/focus */
.hover-glow {
  transition: box-shadow 0.3s ease-in-out, transform 0.3s ease-in-out;
}
.hover-glow:hover, .hover-glow:focus-visible {
  box-shadow: 0 0 12px var(--orangeLuxe);
  transform: scale(1.07);
}

/* Fade-in animation */
.fade-in {
  opacity: 0;
  transform: translateY(30px);
  transition: opacity 0.6s ease-out, transform 0.6s ease-out;
}
.fade-in.appear {
  opacity: 1;
  transform: none;
}

/* Pulse animation for alerts and status strip */
.alert-pulse {
  animation: pulse 1s infinite alternate;
}
.status-strip {
  animation: pulse 1.4s ease-in-out infinite alternate;
}
@keyframes pulse {
  from { opacity: 1; }
  to { opacity: 0.7; }
}

/* HUD blinking live dot */
.hud-blink {
  color: var(--orangeLuxe);
  animation: hud-blink 1.5s infinite;
  font-weight: bold;
  user-select: none;
}
@keyframes hud-blink {
  0%, 50%, 100% { opacity: 1; }
  25%, 75% { opacity: 0.3; }
}

/* Tooltip on buttons */
button[data-tooltip]:hover::after {
  content: attr(data-tooltip);
  position: absolute;
  bottom: 120%;
  left: 50%;
  transform: translateX(-50%);
  background: var(--orangeLuxe);
  color: #000;
  padding: 0.25em 0.5em;
  border-radius: 0.25rem;
  font-size: 0.75rem;
  white-space: nowrap;
  pointer-events: none;
  opacity: 0.9;
  z-index: 9999;
}
EOF

echo " CSS utilities appended to $CSS_UTILS"

# 2. Append JS features to init.js, avoid duplicates by checking first

if ! grep -q 'Starforge Motion JS Enhancements' "$JS_INIT"; then
  cat >> "$JS_INIT" <<'EOF'

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

EOF
  echo " JS enhancements appended to $JS_INIT"
else
  echo " JS enhancements already present in $JS_INIT, skipping append."
fi

# 3. Inject HUD blinking live dot if not present
if ! grep -q 'hud-blink' "$HUD_STATUS"; then
  # Insert after first opening tag <div ...> or <section ...> (adjust this selector if needed)
  sed -i '/<div[^>]*>/a <span class="hud-blink" aria-live="polite" role="status" title="Live status indicator"></span>' "$HUD_STATUS"
  echo " HUD blinking dot added to $HUD_STATUS"
else
  echo " HUD blinking dot already present in $HUD_STATUS, skipping insert."
fi

echo " Starforge Motion Setup Complete! Reload your browser to see it live."

