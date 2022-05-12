---
layout: page
title: News
permalink: /blog/
subtitle: The latest developments and announcements
hero_height: is-fullwidth
---

<table class="post-list">
  {% for post in site.posts %}
    <tr>
    <td>
      <span class="post-meta">{{ post.date | date: '%B %d, %Y' }}</span>
    </td>
    <td>
        <a class="post-link" href="{{ site.url }}/{{ post.url }}">
        {{ post.title }}</a>
    </td>
    </tr>
  {% endfor %}
</table>
