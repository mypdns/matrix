![Build Status](https://gitlab.com/pages/plain-html/badges/master/build.svg)

---

Block a DNS server bby RPZ in [Bind](http://www.zytrax.com/books/dns/ch7/rpz.html#policy-zone) like:
```python
*.dns.examplse.net.rpz-nsdname CNAME .
```

And for [Powerdns](https://www.powerdns.com/) do

```lua
pdnsutil add-record rpz.mypdns.cloud '*.dns.examplse.net.rpz-nsdname' CNAME 345600 .
```

---

Example plain HTML site using GitLab Pages.

Learn more about GitLab Pages at https://pages.gitlab.io and the official
documentation https://docs.gitlab.com/ce/user/project/pages/.

---

