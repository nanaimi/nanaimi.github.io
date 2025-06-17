---
layout: page
title: projects
permalink: /projects/
description: A collection of things I've built, researched, and experimented with
nav: true
nav_order: 2
horizontal: false
---

<!-- pages/projects.md -->
<div class="projects-container">
  
  <!-- Hero Section -->
  <!-- <div class="projects-hero"> -->
    <!-- <p class="projects-subtitle">A collection of things I've built, researched, and experimented with</p> -->
  <!-- </div> -->

  <!-- Projects Grid -->
  {%- if site.enable_project_categories and page.display_categories %}
    {%- for category in page.display_categories %}
      <div class="category-section">
        <h2 class="category-title">{{ category }}</h2>
        {%- assign categorized_projects = site.projects | where: "category", category -%}
        {%- assign sorted_projects = categorized_projects | sort: "importance" %}
        
        <div class="projects-grid">
          {%- for project in sorted_projects -%}
            {% include projects_minimal.html %}
          {%- endfor %}
        </div>
      </div>
    {% endfor %}
  {%- else -%}
    <!-- Display projects without categories -->
    {%- assign sorted_projects = site.projects | sort: "importance" -%}
    <div class="projects-grid">
      {%- for project in sorted_projects -%}
        {% include projects_minimal.html %}
      {%- endfor %}
    </div>
  {%- endif -%}
  
  <!-- Footer Note -->
  <div class="projects-footer">
    <p>More projects and experiments on <a href="https://github.com/{{ site.github_username }}" target="_blank">GitHub</a></p>
  </div>
  
</div>

<style>
.projects-container {
  max-width: 900px;
  margin: 0 auto;
  padding: 2rem 1rem;
}

.projects-hero {
  text-align: center;
  margin-bottom: 4rem;
  padding: 2rem 0;
}

.projects-title {
  font-size: 3rem;
  font-weight: 300;
  letter-spacing: -0.02em;
  margin-bottom: 1rem;
  color: var(--global-theme-color);
  /* background: linear-gradient(135deg, var(--global-theme-color), #667eea);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent; */
  background-clip: text;
}

.projects-subtitle {
  font-size: 1.1rem;
  color: var(--global-text-color-light);
  font-weight: 300;
  line-height: 1.6;
}

.category-section {
  margin-bottom: 4rem;
}

.category-title {
  font-size: 1.5rem;
  font-weight: 400;
  margin-bottom: 2rem;
  color: var(--global-text-color);
  text-transform: lowercase;
  letter-spacing: 0.05em;
  position: relative;
  padding-left: 1.5rem;
}

.category-title::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 4px;
  height: 1.2em;
  background: var(--global-theme-color);
  border-radius: 2px;
}

.projects-grid {
  display: grid;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.projects-footer {
  text-align: center;
  margin-top: 4rem;
  padding-top: 2rem;
  border-top: 1px solid var(--global-divider-color);
}

.projects-footer p {
  color: var(--global-text-color-light);
  font-size: 0.9rem;
}

.projects-footer a {
  color: var(--global-theme-color);
  text-decoration: none;
  font-weight: 500;
  transition: opacity 0.2s ease;
}

.projects-footer a:hover {
  opacity: 0.7;
}

@media (max-width: 768px) {
  .projects-title {
    font-size: 2.5rem;
  }
  
  .projects-hero {
    margin-bottom: 3rem;
  }
  
  .category-section {
    margin-bottom: 3rem;
  }
}
</style>


