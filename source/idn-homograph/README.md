# IDN Homograph Attacks

An **IDN Homograph Attack** is a form of online deception that exploits the visual similarity between characters in different alphabets to create malicious websites that appear nearly identical to legitimate ones. By using characters from different scripts, attackers can craft deceptive URLs that look like trusted domains, tricking users into providing sensitive information, such as usernames, passwords, or credit card details.

This type of attack is made possible through **Internationalized Domain Names (IDNs)**, which allow non-ASCII characters in URLs. While IDNs help make the internet accessible in various languages and scripts, they also open the door for visually similar (homograph) characters to be misused in phishing.

## How IDN Homograph Attacks Work

Homograph attacks exploit **character similarity across different scripts**. For example, characters in Cyrillic, Greek, or other non-Latin scripts may look nearly identical to Latin characters. Attackers register these lookalike domains to create websites that visually mimic trusted ones. When users visit these fake sites, they might believe they are on a legitimate page, leading them to unwittingly disclose private information.

### Example

A common example of an IDN homograph attack could involve a fake website resembling "paypal.com":

-   The attacker might register "раураɩ.com," where the characters are from the Cyrillic script, making it visually similar to "paypal.com" in a URL bar.

### Commonly Targeted Characters

Homograph attacks frequently use characters such as:

-   Cyrillic `а` (U+0430) for Latin `a` (U+0061)
-   Greek `ο` (U+03BF) for Latin `o` (U+006F)
-   Cyrillic `р` (U+0440) for Latin `p` (U+0070)

## Countermeasures

1. **Browser Protections**: Modern browsers implement rules to detect IDN homograph attacks, often showing the domain in its "punycode" format (starting with "xn--") if it contains mixed scripts.
2. **Domain Registration Policies**: Some domain registrars enforce rules to prevent the registration of domains with mixed scripts or disallow certain character combinations.

## Why IDN Homograph Attacks Are Dangerous

IDN homograph attacks blend technical exploitation with social engineering, relying on both visual similarity and user trust. They are particularly dangerous because:

-   They mimic familiar websites closely, lowering user suspicion.
-   They often bypass automated detection systems, especially if users aren’t vigilant.

Efforts to mitigate IDN homograph attacks include browser security updates, technical measures like script restriction in domain names, and public awareness to increase caution among users when entering personal information online.

> source: https://kb.mypdns.org/articles/IDN-Homograph-Attacks
