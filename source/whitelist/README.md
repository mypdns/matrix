# White Lists
Whitelisting a domain means that it would be anti-blocked by any later
submission to any [BlackLists][BlackLists] and
ensuring that the DNS Firewall won't block this and proceed the DNS query
and answer process as usual.

## About Whitelisting domains
This list have it's very own life, as this is a very very tricky one to
maintain.

The reason why it's hard to maintain such a list is, it have to balance
between what is going on with a domain, that for several reasons might be
[blacklisted][BlackLists] on some lists, but not
on others. It can also be that a domain in general do 99,9% rights, but
because of it's nature of user based submissions, could do a lot of evil.

## Why white listing
If we take the example of `Gitlab.com`

`Gitlab.com` is 10% user submitted contents, but for the very same reason
also a widely used target from bad guys, to host there evil code. For that
rightfully reason `Gitlab.com` often pop ups on list for hosting
[MalWare][MalWare] code. Since this would have
huge influence on [My Privacy DNS][My Privacy DNS] and brakes the
workflow, it's of curse have to be whitelisted within the
[DNS firewall][DNS firewall] projects.


[BlackLists]: https://kb.mypdns.org/articles/MTX/BlackLists
[DNS firewall]: https://kb.mypdns.org/articles/MTX/DnsFirewall
[MalWare]: https://kb.mypdns.org/articles/MTX/MalWare
[My Privacy DNS]: https://mypdns.org/ "DNS Firewall through RPZ (Response Policy Zones"
