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
      - file: cri-o-apt-pinning
{%- endif %}

{%- if os_family == 'debian' %}
cri-o-apt-pinning:
  file.managed:
    - name: /etc/apt/preferences.d/cri-o
    - contents: |
        Package: cri-o
        Pin: version {{ crio_pkg_version }}
        Pin-Priority: 1001
{%- endif %}
