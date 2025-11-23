---
layout: default
title: Archive
permalink: /archive/
---

## Post Archive

{% for post in site.posts %}
  {% assign current_year = post.date | date: "%Y" %}
  {% if current_year != last_year %}

<h2 id="y{{current_year}}">{{ current_year }}</h2>

    {% assign last_year = current_year %}
  {% endif %}
  <p>
    <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %-d" }}</time>
    &raquo; <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    <br>
    {{ post.excerpt | strip_html | truncatewords: 30 }}
  </p>
{% endfor %}