[![My Privacy DNS](https://img.shields.io/badge/View-Mirror-e24329.svg?logo=gitlab&style=plastic)](https://mypdns.org/my-privacy-dns/matrix)
[![Github Mirror](https://img.shields.io/badge/View-Mirror-e24329.svg?logo=github&style=plastic)](https://github.com/mypdns/matrix)

# The Matrix

This repository is [MyPDNS'](https://mypdns.org/explore) self maintained list of domains that
need to be blocked for various reasons.

# Source list
The `source` folder contains several sub-folders, each named as groups,
for which a submission should be put. This however doesn't necessary
mean that one domain can't be put into several 'groups'.

Ex. `google.*` which belongs to several groups as they represent all
online evil, when we talk about privacy and anti-brainwashing/manipulation;
Facebook is also well represented in several categories.

# Categorising
Each sub-folder of `sources` should contain it's own README which in
short describes what the list is all about and the criteria to add a domain
into it's `domain.list` or `wildcard.list`.

# Whitelist
This list has its own life, as it's a very, very tricky one to
maintain.

The reason for that is, it has to balance between what is going on with
a domain that, for several reasons, might be blacklisted on some lists
but not on others. It can also be that a domain in general is 99,9%
right, but because of it's nature of user based submissions, could do a
lot of evil.

##### Ex. Gitlab.com

Gitlab is hosting 100% user submitted content, but for the same reason, is also a 
target for cyber criminals to host their evil
[Malware](https://en.wikipedia.org/wiki/Malware). For that reason, Gitlab often
pops up on lists for malicious code. But as that
would have a huge influence on our workflow, it would, of course, have to be
whitelisted on our list.

# FAQ
**Q**: Your lists have broken my website, by blocking a third party
domain!

**A**: We have absolutely not broken your website by blocking any
third-party domain.
It's you and only you who has submitted bad code and mis-written your
website to behave badly. Be happy we haven't blocked your website
already for leaking privacy to third party.

**Q**: Why don't you whitelist example.com?

**A**:

1) It's up to individual users (i.e you) to create and maintain their own whitelist.

2) By whitelisting bad domain X because website Y uses bad domain X, we're deceiving our users who believe they're protected against bad domain X.

3) Through this repository's issue board, we're trying our best to give people the right information for them to decide whether or not they should allow access to some domains, despite them being marked as bad."
# Keywords
A few keywords for this project is Enhanced Privacy, DNS Firewall,
Privacy First
