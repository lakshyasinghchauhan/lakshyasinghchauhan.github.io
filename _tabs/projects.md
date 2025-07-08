---
title: Projects
icon: fas fa-code
order: 2
---

# 🚀 Featured Projects

<div class="d-flex flex-wrap justify-start" style="gap: 1.5rem;">

{% for project in site.data.projects.featured %}
  <div class="card" style="width: 300px; padding-bottom: 1rem;">
    <img src="{{ project.image }}"
         alt="{{ project.title }} screenshot"
         loading="lazy"
         style="width: 100%; height: 180px; object-fit: cover; border-radius: 0.5rem 0.5rem 0 0; border-bottom: 1px solid #eee;" />

    <div class="card-body">
      <h3>{{ project.emoji }} {{ project.title }}</h3>

      {% if project.badges %}
        <p style="display: flex; flex-wrap: wrap; gap: 6px; margin: 8px 0;">
          {% for badge in project.badges %}
            {{ badge.markdown | markdownify | remove: '<p>' | remove: '</p>' }}
          {% endfor %}
        </p>
      {% endif %}

      <p>{{ project.description }}</p>
      <a href="{{ project.live }}" target="_blank">🔗 Live site</a><br>
      <a href="{{ project.repo }}" target="_blank">💻 Source code</a>
    </div>
  </div>
{% endfor %}

</div>

---

# 🧰 Other Projects

<div class="d-flex flex-wrap justify-start" style="gap: 1.5rem;">

{% for project in site.data.projects.others %}
  <div class="card" style="width: 300px; padding-bottom: 1rem;">
    <img src="{{ project.image }}"
         alt="{{ project.title }} screenshot"
         loading="lazy"
         style="width: 100%; height: 180px; object-fit: cover; border-radius: 0.5rem 0.5rem 0 0; border-bottom: 1px solid #eee;" />

    <div class="card-body">
      <h3>{{ project.emoji }} {{ project.title }}</h3>

      {% if project.badges %}
        <p style="display: flex; flex-wrap: wrap; gap: 6px; margin: 8px 0;">
          {% for badge in project.badges %}
            {{ badge.markdown | markdownify | remove: '<p>' | remove: '</p>' }}
          {% endfor %}
        </p>
      {% endif %}

      <p>{{ project.description }}</p>
      <a href="{{ project.live }}" target="_blank">🔗 Live site</a><br>
      <a href="{{ project.repo }}" target="_blank">💻 Source code</a>
    </div>
  </div>
{% endfor %}

</div>
