# 2 contribute

If you feel like contributing there are a couple of ways to do this

1. You can add new super high speed bash code, optimizing existing, rewrite for
    broader support of bash environments across OS's
1. You can add domains to either the wildcard.list or domain.list in there
    respective folders
1. You can through **Damned** good arguments try to get a domain into the
    whitelisted

**NOTE**: When you first starts to commit issues, the [akismet][akismet]
unfortunately very fast to mark you as a spammer, but don't this
includes everyone even admin accounts.

When this happens, please add this 'Ping @spirillen, i've got mark as spam`
to this [issue](https://mypdns.org/mypdns/support/-/issues/268) and we will
get your account back on track.

### Adding a new domain
The workflow is a bit clumsy, but the most reliable and fail-safe.
   1. You add an issue with you question, feature request or contribution
      via [this form](https://mypdns.org/my-privacy-dns/porn-records/-/issues/new?issue[issue_type]=issue&issuable_template=Adult%20contents)
      (This is the history of _why_ to blacklist a record)

      ALL fields MOST be filled out, the questions is there for a
      good reason...

   2. Add your new domain record(s) to suitable file(s) in the `submit_here/`
      folder.
      A issue is required to be able to historically trace why you
      have committed the records and for other to verify your commit
      without having to visit a pornographic site, for which they actualle
      try to avoid by using this list.

   3. If you added any content to any of the files in `submit_here/`l
      You open a PR (Merge Request) where you'll add your contribution
      (This is the _when_ we did the blacklisting)

   4. You add the new domain record entry in the top or bottom of the list,
      then it is easier to find.
      The CI/CD code will make it appear in alphanumeric order

   5. Follow the [New commit](#new-commit) guide


The workflow is a bit clumsy, but the most reliable and simple.
1. You add an [issue](issues/new), and describing your submission.
1. You then open a [MR](/merge_requests/new) (Merge Request) where you'll add you contribution
1. Add PR_ID and Issue_ID and the domain_name in the commit message
   ```shell
   git commit -S -am "!PrID #IssueID `example.com`"
   ```

## Why first issue then MR?
The simplest idea is often the most safe, and this is the very reason for this
workflow. It is also giving the project a searchable database for added domains
and the comment, by which we can't add in other ways, as all the lists needs to
be raw data; from which other scripts easily can work with, without first have
to run several cleanup processes.

Please also read our [Writing Guide](https://mypdns.org/mypdns/support/-/wikis/contributing/Writing-Guide) before continuing with your issue contribution

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
