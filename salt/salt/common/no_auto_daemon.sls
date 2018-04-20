
# XXX: can this filter by daemon? if so, that would be nice..
# todo:
#  - first log args & env
#  - if args/env, then use to build 'smarter' script.

/usr/sbin/policy-rc.d:
  file.managed:
    - source: salt://common/policy-rc.d.sh
    - user: root
    - group: root
    - mode: 755


