## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
back ticks `(`)` -->

'Typo Squatting' domain that have to be blocked as..

- [ ] [Single Domain](source/typosquatting/domains.list)
- [X] [Wild carded](source/typosquatting/wildcard.list)

```python
example.org   CNAME . ; TypoSquatting 
*.example.org   CNAME . ; TypoSquatting 
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

/label ~"TypoSquatting"  
/assign @AnonymousPoster @Spirillen
/estimate 15m
/weight 4
