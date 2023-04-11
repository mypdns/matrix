I report this ~NSFW::Strict [related][catinfo] domain to be added into the [MyPDNS RPZ Firewall][mpdrf]

## Reported URL

```css
(input your URL here)
```

- [X] Wildcarded
- [ ] Individual domain blocking

## RPZ (Response Policy Zone) Rules

```css
domain_name_here   CNAME . ; NSFW::Strict
*.domain_name_here   CNAME . ; NSFW::Strict
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


[catinfo]: https://0xacab.org/my-privacy-dns/matrix/-/tree/master/source/porn_filters/strict_filters
[mpdrf]: https://0xacab.org/my-privacy-dns/matrix/
[hosts]: https://0xacab.org/my-privacy-dns/support/-/wikis/dns/DnsHosts
[Pi-hole]: https://0xacab.org/my-privacy-dns/matrix/-/blob/master/source/porn_filters/README.md#pi-hole

[//]: # ( write SHA-1 value of base domain here )

/label ~"NSFW::Strict"
