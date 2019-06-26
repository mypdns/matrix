## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
`back ticks` -->

I believe this domain is an AdWare domain<!-- s --> that have to be blocked as..

- [ ] [Wildcarded]<!-- source/adware/wildcard.list -->
- [ ] [Single domain blocking]<!-- source/adware/domains.list -->


## Steps to reproduce

<!-- How one can reproduce the issue - this is very important -->



## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


```python
example.org   CNAME . ; AdWare 
*.example.org   CNAME . ; AdWare 
```

### All Submissions:
- [ ] Have you followed the guidelines in our Contributing document?
- [ ] Have you checked to ensure there aren't other open [Merge Requests (MR)](../../merge_requests) for the same update/change?
- [ ] Added ScreenDump for prove of False Positive
- [ ] Have you added an explanation of what your submission do and why you'd like us to include them?

### Testing face
- [ ] Checked the internet for varification?
- [ ] Have you successfully ran tests with your changes locally?

### Todo
- [ ] RPZ Server
- [ ] Added to Source file

/label ~AdWare 
/cc @AnonymousPoster
/assign @spirillen @AnonymousPoster
/estimate 15m
/weight 4
