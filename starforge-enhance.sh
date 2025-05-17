#!/usr/bin/env bash
set -euo pipefail

echo " Starforge Overdrive: Applying Forgemaster Enhancements"

# 1. Create utilities/variables.css if missing
mkdir -p static/css/utilities
if ! grep -q ':root' static/css/utilities/variables.css 2>/dev/null; then
  cat << EOF > static/css/utilities/variables.css
:root {
  --orangeLuxe: #facc15;
  --cyberNight: #0f172a;
  --cyberNightGlow: #12182f;
  --font-sans: 'Inter', sans-serif;
}
.focus-visible:focus {
  outline: 2px solid var(--orangeLuxe);
  outline-offset: 2px;
}
.hover-glow:hover {
  box-shadow: 0 0 10px var(--orangeLuxe);
  transition: box-shadow 0.3s ease-in-out;
}
.fade-in {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.6s ease-out, transform 0.6s ease-out;
}
.fade-in.appear {
  opacity: 1;
  transform: none;
}
EOF
  echo " Created static/css/utilities/variables.css"
else
  echo " static/css/utilities/variables.css exists, skipping creation"
fi

# 2. Inject import to variables.css in app.min.css if missing
if ! grep -q '@import "utilities/variables.css";' static/css/app.min.css; then
  sed -i '1i@import "utilities/variables.css";' static/css/app.min.css
  echo " Injected import of variables.css into app.min.css"
else
  echo " variables.css already imported in app.min.css"
fi

# 3. Add aria-labels to all nav links in header.html
find templates/components -name 'header.html' -exec sed -i 's/<a /<a aria-label="Navigation Link" /g' {} +
echo " Added aria-labels to nav links in header.html"

# 4. Lazy-load bug_tales.js using IntersectionObserver in init.js
if ! grep -q 'IntersectionObserver.*bug_tales' static/js/init.js; then
  cat << 'JS' >> static/js/init.js

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
JS
  echo " Appended lazy-load IntersectionObserver for bug_tales.js in init.js"
else
  echo " bug_tales lazy-load already present in init.js"
fi

# 5. Append focus-visible styles already included in variables.css above

# 6. Append theme toggle button to header.html if missing
if ! grep -q 'id="themeToggle"' templates/components/header.html; then
  sed -i '/<\/nav>/i <button id="themeToggle" aria-label="Toggle Dark Mode" class="ml-4 p-2 rounded hover-glow"></button>' templates/components/header.html
  echo " Added theme toggle button to header.html"
else
  echo " Theme toggle button already present in header.html"
fi

# 7. Append theme toggle JS to init.js if missing
if ! grep -q "themeToggle" static/js/init.js; then
  cat << 'JS' >> static/js/init.js

document.getElementById('themeToggle')?.addEventListener('click', () => {
  if(document.documentElement.classList.toggle('dark')){
    localStorage.setItem('theme', 'dark');
  } else {
    localStorage.setItem('theme', 'light');
  }
});
JS
  echo " Added theme toggle JS to init.js"
else
  echo " Theme toggle JS already present in init.js"
fi

# 8. Add data-aos="fade-up" and fade-in class to all section tags in templates
find templates -name '*.html' -exec sed -i 's/<section /<section data-aos="fade-up" class="fade-in" /g' {} +
echo " Added data-aos fade-up and fade-in classes to all <section> tags"

# 9. Add data-tooltip="Click Action" to buttons in components
find templates/components -name '*.html' -exec sed -i 's/<button /<button data-tooltip="Click Action" /g' {} +
echo " Added data-tooltip to all buttons in components"

# 10. Add data-testid="vault-status-section" to vault-status div in index.html if missing
if ! grep -q 'data-testid="vault-status-section"' templates/index.html; then
  sed -i 's/<div id="vault-status"/<div id="vault-status" data-testid="vault-status-section"/' templates/index.html
  echo " Added data-testid to vault-status div in index.html"
else
  echo " data-testid already present on vault-status div in index.html"
fi

echo " Starforge Overdrive enhancements applied successfully!"

