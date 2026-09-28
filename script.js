/**
 * Mobile Navigation Toggle & Accessibility Controls
 * Shared across index.html, project.html, and resume.html
 */
document.addEventListener('DOMContentLoaded', () => {
  const menuToggle = document.getElementById('menu-toggle');
  const primaryNav = document.getElementById('primary-nav');

  if (!menuToggle || !primaryNav) return;

  function openMenu() {
    menuToggle.setAttribute('aria-expanded', 'true');
    menuToggle.setAttribute('aria-label', 'Close menu');
    menuToggle.classList.add('is-active');
    primaryNav.classList.add('is-open');
  }

  function closeMenu() {
    menuToggle.setAttribute('aria-expanded', 'false');
    menuToggle.setAttribute('aria-label', 'Open menu');
    menuToggle.classList.remove('is-active');
    primaryNav.classList.remove('is-open');
  }

  function toggleMenu() {
    const isExpanded = menuToggle.getAttribute('aria-expanded') === 'true';
    if (isExpanded) {
      closeMenu();
    } else {
      openMenu();
    }
  }

  // Toggle button click
  menuToggle.addEventListener('click', (e) => {
    e.stopPropagation();
    toggleMenu();
  });

  // Close menu when any navigation link is tapped
  const navLinks = primaryNav.querySelectorAll('a');
  navLinks.forEach((link) => {
    link.addEventListener('click', () => {
      closeMenu();
    });
  });

  // Close when tapping outside the menu and toggle button
  document.addEventListener('click', (e) => {
    if (
      primaryNav.classList.contains('is-open') &&
      !primaryNav.contains(e.target) &&
      !menuToggle.contains(e.target)
    ) {
      closeMenu();
    }
  });

  // Close when Escape key is pressed
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && primaryNav.classList.contains('is-open')) {
      closeMenu();
      menuToggle.focus();
    }
  });

  // Close menu if window is resized above 768px
  window.addEventListener('resize', () => {
    if (window.innerWidth > 768 && primaryNav.classList.contains('is-open')) {
      closeMenu();
    }
  });
});
