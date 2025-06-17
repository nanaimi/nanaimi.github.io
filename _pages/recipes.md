---
layout: page
title: recipes
permalink: /recipes/
description: life is to short to eat bad food.
nav: true
nav_order: 4
---


{% assign recipes = site.recipes | sort: 'date' | reverse %}

<div class="recipes">
{% for recipe in recipes %}
  <div class="recipe-card">
    <h2><a href="{{ recipe.url | relative_url }}">{{ recipe.title }}</a></h2>
    {% if recipe.description %}
    <p class="description">{{ recipe.description }}</p>
    {% endif %}
    <div class="recipe-meta">
      <span class="prep-time">⏱️ Prep: {{ recipe.prep_time }}</span>
      <span class="cook-time">🍳 Cook: {{ recipe.cook_time }}</span>
      <span class="servings">👥 Serves: {{ recipe.servings }}</span>
    </div>
    {% if recipe.tags %}
    <div class="tags">
      {% for tag in recipe.tags %}
        <span class="tag">{{ tag }}</span>
      {% endfor %}
    </div>
    {% endif %}
  </div>
{% endfor %}
</div>

<style>
.recipes {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 2rem;
  margin-top: 2rem;
}

.recipe-card {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 1.5rem;
  transition: transform 0.2s ease-in-out;
}

.recipe-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.recipe-card h2 {
  margin: 0 0 1rem 0;
  font-size: 1.5rem;
}

.recipe-card .description {
  color: #666;
  margin-bottom: 1rem;
}

.recipe-meta {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  margin-bottom: 1rem;
  font-size: 0.9rem;
}

.tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.tag {
  background: #f0f0f0;
  padding: 0.2rem 0.8rem;
  border-radius: 15px;
  font-size: 0.8rem;
}
</style> 