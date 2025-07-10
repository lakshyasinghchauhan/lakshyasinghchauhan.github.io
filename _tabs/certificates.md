---
title: Certificates
icon: fas fa-scroll
order: 2
---

Below are some of the certificates I’ve earned through competitions, courses, and achievements.

<div class="mb-3" style="font-size: 1rem; color: #888;">
  <em>Click the certificate preview to open</em>
</div>

<style>
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
    .project-card .card-img-top {
      background: #23272f !important;
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
    .project-card .card-img-top {
      background: #fff !important;
    }
  }
  .card.project-card, .project-card {
    border-radius: 0.5rem;
    transition: background 0.2s, color 0.2s;
  }
</style>

{% assign categories = site.data.certificates %}

{% for category in categories %}
### {{ category[0] | capitalize }}

<div class="container-fluid px-0 mb-4">
  <div class="row row-cols-1 row-cols-md-2 g-4">
    {% for cert in category[1] %}
      <div class="col d-flex align-items-stretch">
        <div class="card h-100 shadow-sm project-card w-100">
          <a href="{{ cert.link }}" target="_blank" style="display:block;">
            <img src="{{ cert.image }}" class="card-img-top" style="object-fit: contain; width: 100%; height: 180px; aspect-ratio: 16/9; border-radius: 0.5rem 0.5rem 0 0;" alt="{{ cert.title }}">
          </a>
          <div class="card-body d-flex flex-column p-3 pb-2">
            <h3 class="card-title mb-1 mt-0" style="font-size: 1.15rem; line-height: 1.2; font-weight: bold;">{{ cert.title }}</h3>
            <p class="card-text mb-2 mt-1" style="font-size: 1rem; line-height: 1.5;">{{ cert.description }}</p>
            {% if cert.link %}
            <div class="mt-auto pt-2">
              <a href="{{ cert.link }}" target="_blank" class="card-link">🔗 View Issuer</a>
            </div>
            {% endif %}
          </div>
        </div>
      </div>
    {% endfor %}
  </div>
</div>
{% endfor %}
