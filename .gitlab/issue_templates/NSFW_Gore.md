I report this ~NSFW::Gore [related][catinfo] domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

## Reported URL

```css
(input your URL here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; Gore
*.domain_name_here   CNAME . ; Gore
```

### Additional requirements for

#### [hosts] and [Pi-hole]

```css
null
```

```css
+ www
- www
www.
```

#### Adblocker
<details><summary>Click to expand</summary>

```css
N/A
```

</details>

## Screenshots
<!-- add screenshot below -->

## Comments
<!-- some comment about this domain -->


## External sources
<!-- add source URL here if you take it from somewhere else -->


## My Privacy DNS issues
| Domain | FQDN | Issue |
| -- | -- | -- |
| - | - | - |

### Todo
- [X] Added to Source file
- [X] Added to RPZ zone


[catinfo]: https://github.com/mypdns/matrix/-/tree/master/source/porn_filters/explicit_content
[mpdrf]: https://github.com/mypdns/matrix/
[hosts]: https://kb.mypdns.org/articles/MTX/dns/DnsHosts
[Pi-hole]: https://github.com/mypdns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole

[//]: # ( write SHA-1 value of base domain here )

/label ~"NSFW::Gore"
