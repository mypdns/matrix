## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
back ticks `(`)` -->

This fucked up 'Spyware' domain have to be blocked as..

- [ ] [Single Domain](source/spyware/domains.list)
- [X] [Wild carded](source/spyware/wildcard.list)

... ***because***:


## Steps to reproduce

<!-- How one can reproduce the issue - this is very important -->



## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


```python
example.org   CNAME . ; SpyWare 
*.example.org   CNAME . ; SpyWare 
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
- [ ] Checked the internet for varification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo:
- [ ] RPZ Server
- [ ] Added to Source file

/label ~Spyware  
/assign @spirillen @AnonymousPoster
/estimate 15m
/weight 9
