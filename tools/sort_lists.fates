import os
import subprocess

def sort_and_commit_file(file):
    subprocess.run(["sort", "-u", "--parallel=" + str(os.cpu_count() - 1), file, "-o", file])
    subprocess.run(["sed", "-i", "/^$/d", file])
    subprocess.run(["git", "add", file])
    print(f"Sorted and staged: {file}")

def sort_hierarchically_and_commit_file(file):
    result = subprocess.run(["sort", "-u", "--parallel=" + str(os.cpu_count() - 1), file], capture_output=True, text=True)
    with open(file + ".tmp", "w") as tmp_file:
        subprocess.run(["python3", os.path.join(GIT_DIR, "tools", "domain-sort.py")], input=result.stdout, text=True, stdout=tmp_file)
    subprocess.run(["sed", "/^$/d", file + ".tmp"], stdout=open(file, "w"))
    subprocess.run(["git", "add", file])
    os.remove(file + ".tmp")
    print(f"Sorted hierarchically and staged: {file}")

def main():
    GIT_DIR = subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True).stdout.strip()

    if os.path.isdir(GIT_DIR):
        os.chdir(os.path.join(GIT_DIR, "source"))

        ALPHABETICALLY = [
            "adware/tld.csv", "adware/wildcard.csv", "adware/wildcard.rpz-nsdname.csv", "alphabet/wildcard.csv",
            "alphabet/wildcard.rpz-nsdname.csv", "bait_sites/wildcard.csv", "coinblocker/wildcard.csv",
            "dns-servers/domains.rpz-nsdname.csv", "dns-servers/wildcard.rpz-nsdname.csv", "drugs/tld.csv",
            "drugs/wildcard.csv", "drugs/wildcard.rpz-nsdname.csv", "fake-news/wildcard.csv", "gambling/wildcard.csv",
            "gambling/wildcard.rpz-nsdname.csv", "malicious/wildcard.csv", "malicious/wildcard.rpz-nsdname.csv",
            "movies/tld.csv", "movies/wildcard.csv", "movies/wildcard.rpz-nsdname.csv", "news/tld.csv",
            "news/wildcard.csv", "news/wildcard.rpz-nsdname.csv", "phishing/wildcard.csv", "phishing/wildcard.rpz-nsdname.csv",
            "pirated/domains.rpz-nsdname.csv", "pirated/wildcard.csv", "pirated/wildcard.rpz-nsdname.csv", "politics/tld.csv",
            "politics/wildcard.csv", "politics/wildcard.rpz-nsdname.csv", "porn_filters/explicit_content/tld.csv",
            "porn_filters/explicit_content/wildcard.csv", "porn_filters/explicit_content/wildcard.rpz-nsdname.csv",
            "porn_filters/strict_filters/wildcard.csv", "porn_filters/strict_filters/wildcard.rpz-nsdname.csv",
            "redirector/wildcard.csv", "religion/tld.csv", "religion/wildcard.csv", "religion/wildcard.rpz-nsdname.csv",
            "scamming/wildcard.csv", "spam/tld.csv", "spam/wildcard.csv", "spam/wildcard.rpz-nsdname.csv",
            "spyware/tld.csv", "spyware/wildcard.csv", "spyware/wildcard.rpz-nsdname.csv", "suspected/tld.csv",
            "suspected/wildcard.csv", "suspected/wildcard.rpz-nsdname.csv", "torrent/tld.csv", "torrent/wildcard.csv",
            "torrent/wildcard.rpz-nsdname.csv", "tracking/tld.csv", "tracking/wildcard.csv", "tracking/wildcard.rpz-nsdname.csv",
            "typosquatting/wildcard.csv", "typosquatting/wildcard.rpz-nsdname.csv", "weapons/tld.csv", "weapons/wildcard.csv",
            "weapons/wildcard.rpz-nsdname.csv", "whitelist/wildcard.csv"
        ]

        HIERARCHICALLY = [
            "adware/domains.csv", "adware/onions.csv", "adware/rpz-ip.csv", "bait_sites/domains.csv",
            "bait_sites/rpz-ip.csv", "coinblocker/domains.csv", "coinblocker/onions.csv", "coinblocker/rpz-ip.csv",
            "dns-servers/rpz-ip.csv", "drugs/domains.csv", "drugs/onions.csv", "drugs/rpz-ip.csv",
            "fake-news/domains.csv", "fake-news/rpz-ip.csv", "gambling/domains.csv", "gambling/onions.csv",
            "gambling/rpz-ip.csv", "ip-network-blocking/ip4.csv", "ip-network-blocking/ip6.csv",
            "ip-network-blocking/rpz-client-ip.csv", "ip-network-blocking/rpz-drop.csv", "ip-network-blocking/rpz-ip.csv",
            "malicious/domains.csv", "malicious/onions.csv", "malicious/rpz-ip.csv", "movies/domains.csv",
            "movies/onions.csv", "movies/rpz-ip.csv", "news/domains.csv", "news/onions.csv", "news/rpz-ip.csv",
            "phishing/domains.csv", "phishing/onions.csv", "phishing/rpz-ip.csv", "pirated/domains.csv",
            "pirated/rpz-ip.csv", "politics/domains.csv", "politics/onions.csv", "politics/rpz-ip.csv",
            "porn_filters/explicit_content/domains.csv", "porn_filters/explicit_content/hosts.csv",
            "porn_filters/explicit_content/mobile.csv", "porn_filters/explicit_content/onions.csv",
            "porn_filters/explicit_content/rpz-ip.csv", "porn_filters/explicit_content/snuff.csv",
            "porn_filters/strict_filters/domains.csv", "porn_filters/strict_filters/hosts.csv",
            "porn_filters/strict_filters/onions.csv", "porn_filters/strict_filters/rpz-ip.csv", "redirector/domains.csv",
            "redirector/onions.csv", "redirector/rpz-ip.csv", "religion/domains.csv", "religion/onions.csv",
            "religion/rpz-ip.csv", "scamming/domains.csv", "scamming/onions.csv", "scamming/rpz-ip.csv",
            "spam/domains.csv", "spam/onions.csv", "spam/rpz-ip.csv", "spyware/domains.csv", "spyware/onions.csv",
            "spyware/rpz-ip.csv", "suspected/domains.csv", "suspected/onions.csv", "suspected/rpz-ip.csv",
            "torrent/domains.csv", "torrent/onions.csv", "torrent/rpz-ip.csv", "tracking/domains.csv",
            "tracking/onions.csv", "tracking/rpz-ip.csv", "typosquatting/domains.csv", "typosquatting/onions.csv",
            "typosquatting/rpz-ip.csv", "weapons/domains.csv", "weapons/onions.csv", "weapons/rpz-ip.csv",
            "whitelist/domains.csv", "whitelist/onions.csv", "whitelist/rpz-ip.csv"
        ]

        last_commit_files = subprocess.run(["git", "diff-tree", "--no-commit-id", "--name-only", "-r", "HEAD"], capture_output=True, text=True).stdout.splitlines()

        for file in last_commit_files:
            if file in ALPHABETICALLY:
                sort_and_commit_file(file)
            elif file in HIERARCHICALLY:
                sort_hierarchically_and_commit_file(file)

        subprocess.run(["git", "commit", "-m", "Sorted files in ALPHABETICALLY and HIERARCHICALLY arrays"])

if __name__ == "__main__":
    main()
