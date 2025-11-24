---
permalink: /wp-content/
redirect_to: /assets/images/
---

{% comment %}
    This file generates permanent redirect pages for common WordPress paths.
    It covers the standard WP upload path structure: /wp-content/uploads/YYYY/MM/filename.ext
{% endcomment %}

{% for i in (2008..2025) %}
    {% for j in (01..12) %}
        {% assign month = j | prepend: "0" | slice: -2, 2 %}
        ---
        permalink: /wp-content/uploads/{{ i }}/{{ month }}/
        redirect_to: /assets/images/{{ i }}/{{ month }}/
        sitemap: false
        ---
    {% endfor %}
{% endfor %}