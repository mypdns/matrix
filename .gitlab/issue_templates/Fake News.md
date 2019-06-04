## Summary

(Summarize the reason encountered concisely, and keep any domains in 
`back ticks`)

`example.net` is an 'Fake News' that have to be blocked as..

- [ ] [Wildcarded](source/fake-news/wildcard.list)
- [ ] [Single domain blocking](source/fake-news/domains.list)


## Steps to reproduce

(How one can reproduce the issue - this is very important)



## Relevant logs and/or screenshots

(Paste any relevant logs - please use code blocks (```) to format 
console output, logs, and code as it's very hard to read otherwise.)


```python
example.org   CNAME . ; reason
*.example.org   CNAME . ; reason
```

- [ ] RPZ Server
- [ ] Added to Source file

/label ~"Fake News" 
/assign @spirillen @AnonymousPoster
/estimate 15m
/weight 4
