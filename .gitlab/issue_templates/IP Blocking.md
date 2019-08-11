## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
back ticks `(`)` -->

This IP address or IP range(CIDR) that have to be blocked as..

- [ ] [rpz-client-ip](source/ip-network-blocking/rpz-client-ip -->
- [ ] [rpz-drop](source/ip-network-blocking/rpz-drop -->
- [ ] [rpz-ip](source/ip-network-blocking/rpz-ip -->

... ***because***:

## Steps to reproduce

<!-- How one can reproduce the issue - this is very important -->


## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


```python
16.0.0.168.192.rpz-client-ip   CNAME . ; reason
16.0.0.168.192.rpz-drop   CNAME . ; reason
16.0.0.168.192.rpz-ip   CNAME . ; reason
```

### All Submissions:
- [ ] Have you followed the guidelines in our Contributing document?
- [ ] Have you checked to ensure there aren't other open
	[Merge Requests (MR)](../merge_requests) or [Issues](../issues) for
	the same update/change?
- [ ] Added ScreenDump for prove of False Positive
- [ ] Have you added an explanation of what your submission do and why
	you'd like us to include them??

### Testing face
- [ ] Checked the internet for verification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo:
- [ ] RPZ Server
- [ ] Added to Source file

/label ~"IP Blocking" 
/assign @dns-firewall 
/estimate 15m
/weight 4
