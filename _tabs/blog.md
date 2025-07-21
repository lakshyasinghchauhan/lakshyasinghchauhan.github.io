---
layout: default
refactor: true
icon: fas fa-pen
order: 3
---

{% include lang.html %}

{% assign all_pinned = site.posts | where: 'pin', 'true' %}
{% assign all_normal = site.posts | where_exp: 'item', 'item.pin != true and item.hidden != true' %}

{% assign posts = '' | split: '' %}

<!-- Check if we have paginator, if not show all posts -->
{% if paginator %}
  <!-- Get pinned posts on current page -->
  {% assign visible_start = paginator.page | minus: 1 | times: paginator.per_page %}
  {% assign visible_end = visible_start | plus: paginator.per_page %}

  {% if all_pinned.size > visible_start %}
    {% if all_pinned.size > visible_end %}
      {% assign pinned_size = paginator.per_page %}
    {% else %}
      {% assign pinned_size = all_pinned.size | minus: visible_start %}
    {% endif %}

    {% for i in (visible_start..all_pinned.size) limit: pinned_size %}
      {% if i < all_pinned.size %}
        {% assign posts = posts | push: all_pinned[i] %}
      {% endif %}
    {% endfor %}
  {% else %}
    {% assign pinned_size = 0 %}
  {% endif %}

  <!-- Get normal posts on current page -->
  {% assign normal_size = paginator.per_page | minus: pinned_size %}

  {% if normal_size > 0 %}
    {% if pinned_size > 0 %}
      {% assign normal_start = 0 %}
    {% else %}
      {% assign normal_start = visible_start | minus: all_pinned.size %}
      {% if normal_start < 0 %}
        {% assign normal_start = 0 %}
      {% endif %}
    {% endif %}

    {% assign normal_end = normal_start | plus: normal_size | minus: 1 %}
    
    {% for i in (normal_start..normal_end) %}
      {% if i < all_normal.size and i >= 0 %}
        {% assign posts = posts | push: all_normal[i] %}
      {% endif %}
    {% endfor %}
  {% endif %}
{% else %}
  <!-- No paginator, show all posts (pinned first, then normal) -->
  {% assign posts = all_pinned | concat: all_normal %}
{% endif %}

<!-- Fallback: if no posts collected, use all available posts -->
{% if posts.size == 0 %}
  {% assign posts = all_pinned | concat: all_normal %}
{% endif %}

<!-- Collect all unique categories and tags -->
{% assign all_categories = '' | split: '' %}
{% assign all_tags = '' | split: '' %}

{% for post in site.posts %}
  {% unless post.hidden %}
    {% for category in post.categories %}
      {% unless all_categories contains category %}
        {% assign all_categories = all_categories | push: category %}
      {% endunless %}
    {% endfor %}
    {% for tag in post.tags %}
      {% unless all_tags contains tag %}
        {% assign all_tags = all_tags | push: tag %}
      {% endunless %}
    {% endfor %}
  {% endunless %}
{% endfor %}

{% assign all_categories = all_categories | sort %}
{% assign all_tags = all_tags | sort %}

<style>
:root {
  --filter-bg: #f8f9fa;
  --filter-border: #dee2e6;
  --filter-text: #212529;
  --filter-active-bg: #007bff;
  --filter-active-text: white;
  --filter-hover-bg: #e9ecef;
}

[data-mode="dark"] {
  --filter-bg: #2d3136;
  --filter-border: #495057;
  --filter-text: #f8f9fa;
  --filter-active-bg: #0d6efd;
  --filter-active-text: white;
  --filter-hover-bg: #343a40;
}

.filter-dropdown {
  position: relative;
  display: inline-block;
  margin-bottom: 2rem;
}

.filter-dropdown-btn {
  background: var(--filter-bg);
  color: var(--filter-text);
  border: 1px solid var(--filter-border);
  border-radius: 0.5rem;
  padding: 0.5rem 1rem;
  cursor: pointer;
  font-weight: 600;
  font-size: 1rem;
  transition: background 0.2s;
}

.filter-dropdown-btn:hover, .filter-dropdown-btn:focus {
  background: var(--filter-hover-bg);
}

.filter-dropdown-content {
  display: none;
  position: absolute;
  left: 0;
  z-index: 100;
  min-width: 320px;
  background: var(--filter-bg);
  border: 1px solid var(--filter-border);
  border-radius: 0.5rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
  padding: 1rem;
  margin-top: 0.25rem;
}

.filter-dropdown.show .filter-dropdown-content {
  display: block;
}

.filter-section {
  margin-bottom: 1rem;
}

.filter-section:last-child {
  margin-bottom: 0;
}

.filter-label {
  font-weight: 600;
  color: var(--filter-text);
  margin-bottom: 0.5rem;
  display: block;
}

.filter-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.filter-tag {
  background: var(--filter-bg);
  border: 1px solid var(--filter-border);
  color: var(--filter-text);
  padding: 0.25rem 0.75rem;
  border-radius: 1rem;
  cursor: pointer;
  transition: all 0.2s ease;
  font-size: 0.875rem;
  text-decoration: none;
  display: inline-block;
}

.filter-tag:hover {
  background: var(--filter-hover-bg);
  color: var(--filter-text);
  text-decoration: none;
}

.filter-tag.active {
  background: var(--filter-active-bg);
  color: var(--filter-active-text);
  border-color: var(--filter-active-bg);
}

.clear-filters {
  background: transparent;
  border: 1px solid var(--filter-border);
  color: var(--filter-text);
  padding: 0.25rem 0.75rem;
  border-radius: 1rem;
  cursor: pointer;
  transition: all 0.2s ease;
  font-size: 0.875rem;
}

.clear-filters:hover {
  background: var(--filter-hover-bg);
}

.post-hidden {
  display: none !important;
}

@media (max-width: 768px) {
  .filter-dropdown-content {
    min-width: 220px;
    padding: 0.75rem;
  }
  
  .filter-tags {
    gap: 0.25rem;
  }
  
  .filter-tag {
    font-size: 0.8125rem;
    padding: 0.2rem 0.6rem;
  }
}

/* Consistent post image styles */
.post-item .post-preview img {
  width: 100%;
  height: 180px;
  object-fit: cover;
  aspect-ratio: 16/9;
  border-radius: 0.5rem;
  background: #222;
  display: block;
}
</style>

<!-- Filter Controls as Dropdown -->
<div class="filter-dropdown" id="filterDropdown">
  <button class="filter-dropdown-btn" onclick="toggleFilterDropdown(event)">
    <i class="fas fa-filter me-1"></i>Filter Posts
  </button>
  <div class="filter-dropdown-content">
    <div class="d-flex justify-content-between align-items-center mb-2">
      <span style="color: var(--filter-text); font-weight: 600;">Options</span>
      <button class="clear-filters" onclick="clearAllFilters();event.stopPropagation();">
        <i class="fas fa-times me-1"></i>Clear All
      </button>
    </div>
    {% if all_categories.size > 0 %}
    <div class="filter-section">
      <span class="filter-label">
        <i class="fas fa-folder me-1"></i>Categories
      </span>
      <div class="filter-tags">
        {% for category in all_categories %}
          <span class="filter-tag category-filter" data-category="{{ category | slugify }}" onclick="toggleFilter(this, 'category');event.stopPropagation();">
            {{ category }}
          </span>
        {% endfor %}
      </div>
    </div>
    {% endif %}
    {% if all_tags.size > 0 %}
    <div class="filter-section">
      <span class="filter-label">
        <i class="fas fa-tag me-1"></i>Tags
      </span>
      <div class="filter-tags">
        {% for tag in all_tags %}
          <span class="filter-tag tag-filter" data-tag="{{ tag | slugify }}" onclick="toggleFilter(this, 'tag');event.stopPropagation();">
            {{ tag }}
          </span>
        {% endfor %}
      </div>
    </div>
    {% endif %}
  </div>
</div>

<!-- Debug info (remove this after fixing) -->
{% comment %}
<div style="background: #f0f0f0; padding: 10px; margin: 10px 0; font-family: monospace; font-size: 12px;">
  Debug Info:<br>
  Total site posts: {{ site.posts.size }}<br>
  All pinned: {{ all_pinned.size }}<br>
  All normal: {{ all_normal.size }}<br>
  Posts to display: {{ posts.size }}<br>
  {% if paginator %}
  Paginator exists: Yes<br>
  Current page: {{ paginator.page }}<br>
  Per page: {{ paginator.per_page }}<br>
  {% else %}
  Paginator exists: No<br>
  {% endif %}
</div>
{% endcomment %}

<div id="post-list" class="flex-grow-1 px-xl-1">
  {% for post in posts %}
    <article class="card-wrapper card post-item" 
             data-categories="{% for cat in post.categories %}{{ cat | slugify }}{% unless forloop.last %} {% endunless %}{% endfor %}"
             data-tags="{% for tag in post.tags %}{{ tag | slugify }}{% unless forloop.last %} {% endunless %}{% endfor %}">
      <a href="{{ post.url | relative_url }}" class="post-preview row g-0 flex-md-row-reverse">
        {% assign card_body_col = '12' %}

        {% if post.image %}
          {% assign src = post.image.path | default: post.image %}
          {% capture src %}{% include media-url.html src=src subpath=post.media_subpath %}{% endcapture %}

          {% assign alt = post.image.alt | xml_escape | default: 'Preview Image' %}

          {% assign lqip = null %}

          {% if post.image.lqip %}
            {% capture lqip_url %}{% include media-url.html src=post.image.lqip subpath=post.media_subpath %}{% endcapture %}
            {% assign lqip = 'lqip="' | append: lqip_url | append: '"' %}
          {% endif %}

          <div class="col-md-5">
            <img src="{{ src }}" alt="{{ alt }}" {{ lqip }}>
          </div>

          {% assign card_body_col = '7' %}
        {% endif %}

        <div class="col-md-{{ card_body_col }}">
          <div class="card-body d-flex flex-column">
            <h1 class="card-title my-2 mt-md-0">{{ post.title }}</h1>

            <div class="card-text content mt-0 mb-3">
              <p>{% include post-description.html %}</p>
            </div>

            <div class="post-meta flex-grow-1 d-flex align-items-end">
              <div class="me-auto">
                <!-- posted date -->
                <i class="far fa-calendar fa-fw me-1"></i>
                {% include datetime.html date=post.date lang=lang %}

                <!-- categories -->
                {% if post.categories.size > 0 %}
                  <i class="far fa-folder-open fa-fw me-1"></i>
                  <span class="categories">
                    {% for category in post.categories %}
                      {{ category }}
                      {%- unless forloop.last -%},{%- endunless -%}
                    {% endfor %}
                  </span>
                {% endif %}

                <!-- tags -->
                {% if post.tags.size > 0 %}
                  <br>
                  <i class="fas fa-tag fa-fw me-1"></i>
                  <span class="tags">
                    {% for tag in post.tags %}
                      <small class="text-muted">{{ tag }}</small>
                      {%- unless forloop.last -%}, {%- endunless -%}
                    {% endfor %}
                  </span>
                {% endif %}
              </div>

              {% if post.pin %}
                <div class="pin ms-1">
                  <i class="fas fa-thumbtack fa-fw"></i>
                  <span>{{ site.data.locales[lang].post.pin_prompt }}</span>
                </div>
              {% endif %}
            </div>
            <!-- .post-meta -->
          </div>
          <!-- .card-body -->
        </div>
      </a>
    </article>
  {% endfor %}
</div>
<!-- #post-list -->

{% if paginator.total_pages > 1 %}
  {% include post-paginator.html %}
{% endif %}

<script>
let activeFilters = {
  categories: new Set(),
  tags: new Set()
};

function toggleFilterDropdown(event) {
  event.stopPropagation();
  const dropdown = document.getElementById('filterDropdown');
  dropdown.classList.toggle('show');
  // Close dropdown when clicking outside
  if (dropdown.classList.contains('show')) {
    document.addEventListener('click', closeDropdownOnClickOutside);
  }
}

function closeDropdownOnClickOutside(e) {
  const dropdown = document.getElementById('filterDropdown');
  if (!dropdown.contains(e.target)) {
    dropdown.classList.remove('show');
    document.removeEventListener('click', closeDropdownOnClickOutside);
  }
}

function toggleFilter(element, type) {
  const value = element.dataset[type];
  
  if (element.classList.contains('active')) {
    // Remove filter
    element.classList.remove('active');
    activeFilters[type + 's'].delete(value);
  } else {
    // Add filter
    element.classList.add('active');
    activeFilters[type + 's'].add(value);
  }
  
  filterPosts();
}

function clearAllFilters() {
  // Clear active states
  document.querySelectorAll('.filter-tag.active').forEach(tag => {
    tag.classList.remove('active');
  });
  
  // Clear filter sets
  activeFilters.categories.clear();
  activeFilters.tags.clear();
  
  // Show all posts
  filterPosts();
}

function filterPosts() {
  const posts = document.querySelectorAll('.post-item');
  
  posts.forEach(post => {
    let showPost = true;
    
    // Check categories
    if (activeFilters.categories.size > 0) {
      const postCategories = post.dataset.categories ? post.dataset.categories.split(' ') : [];
      const hasMatchingCategory = [...activeFilters.categories].some(cat => postCategories.includes(cat));
      if (!hasMatchingCategory) showPost = false;
    }
    
    // Check tags
    if (activeFilters.tags.size > 0) {
      const postTags = post.dataset.tags ? post.dataset.tags.split(' ') : [];
      const hasMatchingTag = [...activeFilters.tags].some(tag => postTags.includes(tag));
      if (!hasMatchingTag) showPost = false;
    }
    
    // Show/hide post
    if (showPost) {
      post.classList.remove('post-hidden');
    } else {
      post.classList.add('post-hidden');
    }
  });
  
  // Update URL without page reload (optional)
  updateURL();
}

function updateURL() {
  const url = new URL(window.location);
  
  if (activeFilters.categories.size > 0) {
    url.searchParams.set('categories', [...activeFilters.categories].join(','));
  } else {
    url.searchParams.delete('categories');
  }
  
  if (activeFilters.tags.size > 0) {
    url.searchParams.set('tags', [...activeFilters.tags].join(','));
  } else {
    url.searchParams.delete('tags');
  }
  
  window.history.replaceState({}, '', url);
}

// Initialize filters from URL on page load
document.addEventListener('DOMContentLoaded', function() {
  const url = new URL(window.location);
  
  // Load categories from URL
  const urlCategories = url.searchParams.get('categories');
  if (urlCategories) {
    urlCategories.split(',').forEach(cat => {
      const element = document.querySelector(`[data-category="${cat}"]`);
      if (element) {
        element.classList.add('active');
        activeFilters.categories.add(cat);
      }
    });
  }
  
  // Load tags from URL
  const urlTags = url.searchParams.get('tags');
  if (urlTags) {
    urlTags.split(',').forEach(tag => {
      const element = document.querySelector(`[data-tag="${tag}"]`);
      if (element) {
        element.classList.add('active');
        activeFilters.tags.add(tag);
      }
    });
  }
  
  // Apply initial filters
  if (activeFilters.categories.size > 0 || activeFilters.tags.size > 0) {
    filterPosts();
  }
});
</script>
