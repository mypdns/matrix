## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
`back ticks` -->

I believe this DNS Server needs to be blocked as..

- [ ] [Wildcarded]<!-- source/dns-servers/wildcard.list -->
- [ ] [Single DNS Server]<!-- source/dns-servers/domains.list -->

.. ***Because***:

## Steps to reproduce

<!-- How one can reproduce the issue - this is very important -->


## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


```python
*.example.org.rpz-nsdname   CNAME . ; reason
*.example.org.rpz-nsip   CNAME . ; reason
```

**Note**:
	# blocking an NS IPv4 address of 192.168.2.3
	# rewritten as 192.168.2.3/32
	# IPv4 NSIP Trigger transform
	32.3.2.168.192.rpz-nsip

	# blocking an NS IPv6 address of 2001:db8:0:1::57
	# rewritten as 2001:db8:0:1::57/128
	# IPv6 NSIP transform
	128.57.zz.1.0.db8.2001.rpz-nsip

### All Submissions:
- [ ] Have you followed the guidelines in our Contributing document?
- [ ] Have you checked to ensure there aren't other open [Merge Requests (MR)](../../merge_requests) for the same update/change?
- [ ] Added ScreenDump for prove of False Positive
- [ ] Have you added an explanation of what your submission do and why you'd like us to include them?

### Testing face
- [ ] Checked the internet for varification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo:
- [ ] RPZ Server
- [ ] Added to Source file

/label ~"DNS server blocking" 
/assign @spirillen @AnonymousPoster
/estimate 15m
/weight 4
