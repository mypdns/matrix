I believe this domain is an Malware domain(s) --> which should be blocked as..

- [X] Wildcarded
- [ ] Single domain blocking

```python
domain   CNAME . ; Malicious
*.domain   CNAME . ; Malicious
```

## Relevant comments
New SysJoker Backdoor Targets Windows, Linux, and macOS

> Malware targeting multiple operating systems has become no exception in the malware threat landscape. Vermilion Strike, which was documented just last September, is among the latest examples until now.
>
> In December 2021, we discovered a new multi-platform backdoor that targets Windows, Mac, and Linux. The Linux and Mac versions are fully undetected in VirusTotal. We named this backdoor SysJoker.
>
> SysJoker was first discovered during an active attack on a Linux-based web server of a leading educational institution. After further investigation, we found that SysJoker also has Mach-O and Windows PE versions. Based on Command and Control (C2) domain registration and samples found in VirusTotal, we estimate that the SysJoker attack was initiated during the second half of 2021.
>
> SysJoker masquerades as a system update and generates its C2 by decoding a string retrieved from a text file hosted on Google Drive. During our analysis the C2 changed three times, indicating the attacker is active and monitoring for infected machines. Based on victimology and malware’s behavior, we assess that SysJoker is after specific targets.
>
> SysJoker was uploaded to VirusTotal with the suffix .ts which is used for TypeScript files. A possible attack vector for this malware is via an infected npm package.
>
> Below we provide a technical analysis of this malware together with IoCs and detection and response mitigations.

Read the full analytic report on `intezer.com`

## Screenshots
![](https://149520725.v2.pressablecdn.com/wp-content/uploads/2022/01/Untitled-22.png)

## Relevant External sources
- https://www.intezer.com/blog/malware-analysis/new-backdoor-sysjoker/
- `https://github.com/blocklistproject/Lists/issues/623`

### All Submissions:
- [X] Have you followed the guidelines in our [Contributing](CONTRIBUTING.md)
	  document?
- [x] Have you checked to ensure there aren't other open
      [Merge Requests (MR)](../merge_requests) or [Issues](../../issues) for the
      same update/change?
- [X] Have you added an explanation of what your submission do and why you'd
	  like us to include them??
- [X] Added [screenshot](https://mypdns.org/MypDNS/support/-/wikis/Screenshot)
	  for prove of [False Negative](https://mypdns.org/MypDNS/support/-/wikis/False-Negative)

### Testing face
- [X] Checked the internet for verification?
- [X] Have you successfully ran tests with your changes locally?

### Todo
- [X] RPZ Server (Team @Spirillen)
- [X] Added to Source file

/label ~Malicious

/weight 6

/publish

/severity high
