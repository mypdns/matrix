## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
back ticks `(`)` -->

This outdated domain have been Sharked and should be blocked to avoid 
scam in this format..

- [ ] [Single domain blocking](source/sharked-domains/domains.list)
- [X] [Wildcarded](source/sharked-domains/wildcard.list)

```python
example.org   CNAME . ; DomainSharks 
*.example.org   CNAME . ; DomainSharks 
```

## Relevant logs and/or screenshots
<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->
<!-- required -->

### All Submissions:
- [ ] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md) document?
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

/label ~"Domain Sharked" 
/assign @AnonymousPoster @Spirillen
/estimate 15m
/weight 4
