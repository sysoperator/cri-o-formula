{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import crio with context -%}
{%- from tplroot ~ "/vars.jinja" import
    crio_aptrepo_url
with context -%}
{%- from "common/vars.jinja" import
    os_family,
    aptkey_deprecated
-%}

include:
  - debian/packages/apt-transport-https
  - debian/packages/dirmngr
  - debian/packages/gnupg2

cri-o-repository:
  pkgrepo.managed:
    - name: "deb{% if aptkey_deprecated %} [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg]{% endif %} {{ crio_aptrepo_url }} /"
    - file: /etc/apt/sources.list.d/cri-o.list
    - key_url: {{ crio_aptrepo_url }}/Release.key
{%- if aptkey_deprecated %}
    - aptkey: False
{%- endif %}
    - require:
      - pkg: apt-transport-https
