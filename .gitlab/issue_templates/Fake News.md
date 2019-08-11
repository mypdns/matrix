## Summary

<!-- Summarize the FakeNews  encountered concisely, and keep any 
domains in back ticks `(`)` -->

This domain hosts 'Fake News' that have to be blocked as..

- [ ] [Wildcarded](source/fake-news/wildcard.list)
- [ ] [Single domain blocking](source/fake-news/domains.list)

... ***because***:

## Steps to reproduce

<!-- How one can reproduce the issue - this is very important -->


## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


```python
example.org   CNAME . ; FakeNews 
*.example.org   CNAME . ; FakeNews 
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

/label ~"Fake News" 
/assign @dns-firewall 
/estimate 15m
/weight 4
