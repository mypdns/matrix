---
name: DNS Server
about: Submit a DNS server to be blocked by our RPZ zones
title: ''
labels: DNS server blocking
assignees: AnonymousPoster, spirillen

---

## Summary

<!-- Keep any domains in back ticks `(`)`

Screenshot is required within the <details> pane. Leave a blank line before
and after the image link -->

I believe this DNS Server needs to be blocked as..

- [x] [Wildcarded](source/dns-servers/wildcard.list)
- [ ] [Single DNS Server](source/dns-servers/domains.list)

```python
*.example.org.rpz-nsdname   CNAME . ; DNSServer
*.example.org.rpz-nsip   CNAME . ; DNSServer
```

.. ***Because***:

## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format
console output, logs, and code as it's very hard to read otherwise. -->

## Screenshots

<details><Summary>Screenshot required</summary>



</details>

### All Submissions:
- [ ] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) document?
- [ ] Have you checked to ensure there aren't other open [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the same update/change?
- [ ] Added ScreenDump for prove of False Positive
- [ ] Have you added an explanation of what your submission do and why you'd like us to include them??

### Testing face
- [ ] Checked the internet for verification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo:
- [ ] RPZ Server (Team @Spirillen)
- [ ] Added to Source file

#### Note:
```python
	# blocking an NS IPv4 address of 192.168.2.3
	# rewritten as 192.168.2.3/32
	# IPv4 NSIP Trigger transform
	32.3.2.168.192.rpz-nsip

	# blocking an NS IPv6 address of 2001:db8:0:1::57
	# rewritten as 2001:db8:0:1::57/128
	# IPv6 NSIP transform
	128.57.zz.1.0.db8.2001.rpz-nsip
```
