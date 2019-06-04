## Summary

(Summarize the reason encountered concisely, and keep any domains in 
`back ticks`)

`example.net` is an 'Malicious' domain that have to be blocked as..

- [ ] [Single Domain](source/malicious/domains.list)
- [ ] [Wild carded](source/malicious/wildcard.list)


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

/label ~Malicious  
/assign @spirillen @AnonymousPoster
/estimate 15m
/weight 4
