---
title: Projects
icon: fas fa-code
order: 2
---

## 🚀 Featured Projects

<style>
  html[data-theme="light"] .project-card {
    background-color: #ffffff !important;
    color: #222 !important;
    border: 1px solid #e0e0e0 !important;
  }

  html[data-theme="light"] .project-card .card-title,
  html[data-theme="light"] .project-card .card-text,
  html[data-theme="light"] .project-card .card-link {
    color: #222 !important;
  }

  html[data-theme="dark"] .project-card {
    background-color: #23272f !important;
    color: #f1f3f6 !important;
    border: 1px solid #343a40 !important;
  }

  html[data-theme="dark"] .project-card .card-title,
  html[data-theme="dark"] .project-card .card-text,
  html[data-theme="dark"] .project-card .card-link {
    color: #f1f3f6 !important;
  }

  .project-card {
    border-radius: 0.5rem;
    transition: background 0.2s, color 0.2s;
  }

  .badges-row a,
  .badges-row img {
    display: inline-block !important;
    margin-right: 0.4rem !important;
    vertical-align: middle !important;
  }
</style>

<div class="row">
{% for project in site.data.projects.featured %}
  <div class="col-md-6 mb-4">
    <div class="card h-100 shadow-sm project-card">
      <img src="{{ project.image }}" class="card-img-top" style="object-fit: cover; max-height: 200px; background: #222;" alt="{{ project.title }} Screenshot">
      <div class="card-body">
        <h3 class="card-title"><b>{{ project.emoji }} {{ project.title }}</b></h3>
        <p class="card-text">{{ project.description }}</p>

        {% if project.badges %}
        <div class="badges-row mb-2">
          {% for badge in project.badges %}
            {{ badge.markdown | markdownify | strip_newlines | remove: '<p>' | remove: '</p>' }}
          {% endfor %}
        </div>
        {% endif %}

        <a href="{{ project.live }}" class="card-link">🔗 Live site</a><br>
        <a href="{{ project.repo }}" class="card-link">💻 Source code</a>
      </div>
    </div>
  </div>
{% endfor %}
</div>

---

## 🧱 Other Projects

<div class="row">
{% for project in site.data.projects.others %}
  <div class="col-md-6 mb-4">
    <div class="card h-100 shadow-sm project-card">
      <img src="{{ project.image }}" class="card-img-top" style="object-fit: cover; max-height: 200px; background: #222;" alt="{{ project.title }} Screenshot">
      <div class="card-body">
        <h5 class="card-title">{{ project.emoji }} {{ project.title }}</h5>
        <p class="card-text">{{ project.description }}</p>

        {% if project.badges %}
        <div class="badges-row mb-2">
          {% for badge in project.badges %}
            {{ badge.markdown | markdownify | strip_newlines | remove: '<p>' | remove: '</p>' }}
          {% endfor %}
        </div>
        {% endif %}

        <a href="{{ project.live }}" class="card-link">🔗 Live site</a><br>
        <a href="{{ project.repo }}" class="card-link">💻 Source code</a>
      </div>
    </div>
  </div>
{% endfor %}
</div>
