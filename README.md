![Build Status](https://gitlab.com/pages/plain-html/badges/master/build.svg)

---



```
image: alpine:latest

pages:
  stage: deploy
  script:
  - echo 'Nothing to do...'
  artifacts:
    paths:
    - public
  only:
  - master
```

[ci]: https://about.gitlab.com/gitlab-ci/
