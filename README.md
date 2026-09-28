# Personal Portfolio Website

A personal web portfolio built as part of the ISDS 3100 AI Lab: Vibe Coding Exercise. The site uses a hybrid structure consisting of a main hub page and dedicated subpages showcasing experience, skills, and projects.

## Project Structure & Features
- `index.html`: Hub page with profile, skills, experience highlights, journey timeline, and contact information.
- `project.html`: Project showcase with the Project Gardenia board (image modal) and personal website case study.
- `resume.html`: Full interactive resume with Expand All / Collapse All controls.
- `styles.css`: Shared responsive styles for mobile and desktop with no horizontal overflow.
- `script.js`: Shared mobile hamburger menu toggle (open/close, Escape key, tap outside to close).
- `favicon.svg`: Site icon shown in the browser tab.
- Images: `headshot.jpg`, `gardenia-board.jpg` (visual assets for the profile photo and project modal board).

## Deployment
- **Repository:** https://github.com/zainabdare/zainab-website.git
- **Live Site:** (https://zainabdare.github.io/zainab-website/)

## Directing the AI Agent: Technical Reflection

Directing the AI agent was a smooth back-and-forth process, especially because the live local link allowed me to see updates instantly. A key technical learning came from managing file paths and asset imports: I learned that to display my headshot and project images, I had to place the actual .jpeg files directly into the project directory before prompting the agent to reference them, style them with a matching green border, and scale them cleanly.
I also focused on user accessibility and interactive controls. When testing modals and project boards, I noticed visitors could open an item but had no way to exit, so I directed the agent to add a dedicated close button.
Similarly, for my resume section, I guided the agent to build "Expand All" and "Collapse All" toggle controls so users could easily manage what information they view. This experience taught me that directing an AI requires checking real user interactions and breaking down practical UI fixes step-by-step. As a newer learning, I directed the agent to build a mobile hamburger menu and to use mobile-only CSS media queries to stack the age badges and project labels, so the desktop layout stayed unchanged.
