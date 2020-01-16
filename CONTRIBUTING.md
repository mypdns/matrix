# 2 contribute

If you feel like contributing there are a couple of ways to do this

1. You can add new super high speed bash code, optimizing existing, rewrite for 
    broader support of bash environments across OS's
1. You can add domains to either the wildcard.list or domain.list in there 
    respective folders
1. You can through **Damned** good arguments try to get a domain into the 
    whitelisted

# Workflow

The workflow is a bit clumsy, but the most reliable and simple.
1. You add an [issue](issues/new), and describing your submission.
1. You then open a [MR](/merge_requests/new) (Merge Request) where you'll add you contribution
1. Add PR_ID and Issue_ID and the domain_name in the commit message
   ```shell
   git commit -S -am "!PrID #IssueID `exsample.com`"
   ```

## Why first issue then MR?
The simplest idea is often the most safe, and this is the very reason for this 
workflow. It is also giving the project a searchable database for added domains
and the comment, by which we can't add in other ways, as all the lists needs to 
be raw data; from which other scripts easily can work with, without first have 
to run several cleanup processes.

# GPG signed
We require all submissions to be signed with a valid GPG key.

Only exception for this rule is the CI/CD bot

## How do I sign with GPG
If you know nothing about GPG keys I, really suggest you search on 
[duckduckgo.com](https://duckduckgo.com) for the best way, to do it for the OS you 
are using.

However if you do have a GPG key, add it to you submission profile and add a `-S`
to `git commit -S -m "Some very cool enhancements"` and that's is. You can also 
set this globally or pr git. Do a search on [duckduckgo.com](https://duckduckgo.com)
to figure out the current way.

# Writing files/lines
- All files most end with a newline `\n` (LF) UTF-8.
- All files have to be in universal UTF-8 style without BOM
- Files containing `_windows_` in it's filename most be encoded in `ISO-8859-1`
  Latin1 and newlines shall end in (CRLF).
- Line length should not be more than 80 chars for terminals support.
