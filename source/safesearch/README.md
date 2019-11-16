# Safe Search
Safe search is a list of set IP addresses that is meant to pre-enable the 
safe search of search portals.

This zone file contains all known IP to spoof safe search enabled search sites

# Spoofing
There are diffrent apporaches o spoof domains depending on the resolver used for 
this.

### Dnsdist
For example in PowerDns Dnsdist you will do it like this:
```lua
addAction('duckduckgo.com.', SpoofCNAMEAction('safe.duckduckgo.com.'))
```

### RPZ
In standard RPZ you will do it like this:
```python
duckduckgo.com IN CNAME safe.duckduckgo.com
```

### Unbound
In unbound you as i know need to assign IP sppofing like this
```python
local-zone: "duckduckgo.com." redirect
local-data: "duckduckgo.com. IN CNAME safe.duckduckgo.com."
```

### Hosts
In hosts file you forced to have a tramendes list of ip host like this
```shell
54.229.105.151  duckduckgo.com
79.125.105.136  duckduckgo.com
79.125.106.1    duckduckgo.com
```
