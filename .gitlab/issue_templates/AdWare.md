## Summary

<!-- Summarize the reason encountered concisely, and keep any domains in 
`back ticks` -->

I believe this domain is an AdWare domain(s) that have to be blocked as..

- [ ] [Wildcarded](source/adware/wildcard.list)
- [ ] [Single domain blocking](source/adware/domains.list)


## Steps to reproduce

<!-- How one can reproduce the issue - this is very important -->



## Relevant logs and/or screenshots

<!-- Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise. -->


```python
example.org   CNAME . ; AdWare 
*.example.org   CNAME . ; AdWare 
```

- [ ] RPZ Server
- [ ] Added to Source file

/label ~AdWare 
/cc @AnonymousPoster
/assign @spirillen @AnonymousPoster
/estimate 15m
/weight 4
