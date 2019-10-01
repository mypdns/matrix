## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
back ticks `(`)` -->

It's a plain 'Redirector' that have to be blocked as..

- [ ] [Single Domain](source/redirector/domains.list)
- [X] [Wild carded](source/redirector/wildcard.list)

```python
example.org   CNAME . ; ReDirector 
*.example.org   CNAME . ; ReDirector 
```

... ***because***:


## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


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

/label ~Redirector  
/assign @AnonymousPoster @Spirillen
/estimate 15m
/weight 4
