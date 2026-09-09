const navToggle = document.getElementById('navToggle');
const siteNav = document.getElementById('siteNav');

if (navToggle && siteNav) {
  navToggle.addEventListener('click', () => {
    const isOpen = siteNav.classList.toggle('open');
    navToggle.setAttribute('aria-expanded', String(isOpen));
    navToggle.textContent = isOpen ? 'Close' : 'Menu';
  });

  siteNav.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => {
      siteNav.classList.remove('open');
      navToggle.setAttribute('aria-expanded', 'false');
      navToggle.textContent = 'Menu';
    });
  });
}

const yearEl = document.getElementById('year');
if (yearEl) {
  yearEl.textContent = new Date().getFullYear();
}
