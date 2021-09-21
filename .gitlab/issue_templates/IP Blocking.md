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

## Relevant logs and/or screenshots


## Screenshots
<details><summary>Click to unfold</summary>



</details>

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md)
	  document?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the
      same update/change?
- [ ] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??

### Testing face
- [X] Checked the internet for verification?
- [X] Have you successfully ran tests with your changes locally?

### Todo
- [X] RPZ Server (Team @Spirillen)
- [X] Added to Source file

/label ~"IP::BlackListing"

/assign @Spirillen

/weight 2

/publish
