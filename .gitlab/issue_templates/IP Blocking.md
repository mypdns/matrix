This IP address or IP range (CIDR) that have to be blocked as..

- [ ] rpz-client-ip
- [ ] rpz-drop
- [ ] rpz-ip

(NOTE) You can find a guide for right selection at
[RPZ records](https://mypdns.org/mypdns/support/-/wikis/RPZ-record-types)

```
16.0.1.168.192.rpz-client-ip   CNAME rpz-drop. ; reason
32.73.234.225.35.rpz-ip   CNAME rpz-drop. ; reason
16.0.1.168.192.rpz-ip   CNAME . ; reason
```

## Relevant comments
<!-- Be as clear as possible: nobody can read your mind, and nobody is looking at your issue over your shoulder. -->


## Screenshots


## Relevant External sources
- ``
- ``

### All Submissions:
- [ ] Did you follow the guidelines in the [Contributing](CONTRIBUTING.md)
	  document?
- [ ] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../../issues) for the
      same domain?
- [ ] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [ ] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)

### Testing phase
- [ ] Checked the internet for verification?
- [ ] Successfully tested changes locally?

### Todo
- [X] RPZ Server (Team @Spirillen)
- [X] Added to Source file

/label ~"IP::BlackListing"

/weight 2

/publish

/severity low
