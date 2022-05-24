base:
  '*':
    - default

  'G@env:dev and G@roles:dbserver':
    - match: compound
    - dev.mysql