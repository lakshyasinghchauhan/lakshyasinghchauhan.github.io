---
title: Projects
icon: fas fa-code
order: 1
---

## 🚀 Featured Projects


<style>
  /* Light and dark mode support for project cards */
  @media (prefers-color-scheme: dark) {
    .project-card {
      background-color: #23272f !important;
      color: #f1f3f6 !important;
      border-color: #343a40 !important;
    }
    .project-card .card-title,
    .project-card .card-text,
    .project-card .card-link {
      color: #f1f3f6 !important;
    }
    .project-card .card-link {
      text-decoration: underline;
    }
  }
  @media (prefers-color-scheme: light), (prefers-color-scheme: no-preference) {
    .card.project-card, .project-card {
      background-color: #fff !important;
      color: #222 !important;
      border: 1px solid #e0e0e0 !important;
    }
    .card.project-card .card-title,
    .card.project-card .card-text,
    .card.project-card .card-link,
    .project-card .card-title,
    .project-card .card-text,
    .project-card .card-link {
      color: #222 !important;
    }
  }
  .card.project-card, .project-card {
    border-radius: 0.5rem;
    transition: background 0.2s, color 0.2s;
  }
</style>


<div class="container-fluid px-0">
  <div class="row row-cols-1 row-cols-md-2 g-4">
    {% for project in site.data.projects.featured %}
      <div class="col d-flex align-items-stretch">
        <div class="card h-100 shadow-sm project-card w-100">
          <img src="{{ project.image }}" class="card-img-top" style="object-fit: cover; width: 100%; height: 180px; aspect-ratio: 16/9; background: #222; border-radius: 0.5rem 0.5rem 0 0;" alt="{{ project.title }} Screenshot">
          <div class="card-body d-flex flex-column p-3 pb-2">
            <h3 class="card-title mb-1 mt-0" style="font-size: 1.25rem; line-height: 1.2; font-weight: bold;">{{ project.emoji }} {{ project.title }}</h3>
            {% if project.badges %}
            <div class="badges-row mb-1" style="display: flex; flex-wrap: wrap; gap: 0.5rem; align-items: center; margin-bottom: 0.25rem !important;">
              {% for badge in project.badges %}
                <span style="display: inline-flex; align-items: center; margin-right: 0.5rem;">{{ badge.markdown | markdownify }}</span>
              {% endfor %}
            </div>
            {% endif %}
            <p class="card-text mb-2 mt-1" style="font-size: 1rem; line-height: 1.5;">{{ project.description }}</p>
            <div class="mt-auto pt-2">
              <a href="{{ project.live }}" class="card-link">🔗 Live site</a><br>
              <a href="{{ project.repo }}" class="card-link">💻 Source code</a>
            </div>
          </div>
        </div>
      </div>
    {% endfor %}
  </div>
</div>

---

## 🧱 Other Projects



<div class="container-fluid px-0">
  <div class="row row-cols-1 row-cols-md-2 g-4">
    {% for project in site.data.projects.others %}
      <div class="col d-flex align-items-stretch">
        <div class="card h-100 shadow-sm project-card w-100">
          <img src="{{ project.image }}" class="card-img-top" style="object-fit: cover; width: 100%; height: 180px; aspect-ratio: 16/9; background: #222; border-radius: 0.5rem 0.5rem 0 0;" alt="{{ project.title }} Screenshot">
          <div class="card-body d-flex flex-column p-3 pb-2">
            <h3 class="card-title mb-1 mt-0" style="font-size: 1.25rem; line-height: 1.2; font-weight: bold;">{{ project.emoji }} {{ project.title }}</h3>
            {% if project.badges %}
            <div class="badges-row mb-1" style="display: flex; flex-wrap: wrap; gap: 0.5rem; align-items: center; margin-bottom: 0.25rem !important;">
              {% for badge in project.badges %}
                <span style="display: inline-flex; align-items: center; margin-right: 0.5rem;">{{ badge.markdown | markdownify }}</span>
              {% endfor %}
            </div>
            {% endif %}
            <p class="card-text mb-2 mt-1" style="font-size: 1rem; line-height: 1.5;">{{ project.description }}</p>
            <div class="mt-auto pt-2">
              <a href="{{ project.live }}" class="card-link">🔗 Live site</a><br>
              <a href="{{ project.repo }}" class="card-link">💻 Source code</a>
            </div>
          </div>
        </div>
      </div>
    {% endfor %}
  </div>
</div>
