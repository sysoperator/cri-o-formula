{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import crio with context -%}
{%- from tplroot ~ "/vars.jinja" import
    crio_pkg_version
with context -%}
{%- from "common/vars.jinja" import
    os_family
-%}

include:
  - .repository

cri-o:
  pkg.installed:
    - version: {{ crio_pkg_version }}
{%- if os_family == 'debian' %}
    - require:
      - pkgrepo: cri-o-repository
{%- endif %}
