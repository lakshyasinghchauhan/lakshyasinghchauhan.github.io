---
title: Projects
icon: fas fa-code
order: 2
---

<div class="d-flex flex-wrap gap-4 justify-start">

  {% for project in site.data.projects %}
    <div class="card" style="width: 300px;">
      <img src="{{ project.image }}" alt="{{ project.title }} screenshot" style="width: 100%; height: auto;" />
      <div class="card-body">
        <h3>{{ project.emoji }} {{ project.title }}</h3>

        {% if project.badges %}
          <div style="display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 10px;">
            {% for badge in project.badges %}
              <span style="display: inline-block;">{{ badge.markdown | markdownify }}</span>
            {% endfor %}
          </div>
        {% endif %}

        <p>{{ project.description }}</p>
        <a href="{{ project.live }}" target="_blank">🔗 Live site</a><br>
        <a href="{{ project.repo }}" target="_blank">💻 Source code</a>
      </div>
    </div>
  {% endfor %}

</div>
