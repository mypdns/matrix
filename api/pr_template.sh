#!/usr/bin/env bash

# import config values from api.cfg
# https://stackoverflow.com/questions/5228345/how-to-reference-a-file-for-variables-using-bash/36164878#36164878
#

configfile='$ROOT_DIR/api/api.cfg'
if [ -f ${configfile} ]; then
    echo "Reading user config...." >&2

    # check if the file contains something we don't want
    CONFIG_SYNTAX="(^\s*#|^\s*$|^\s*[a-z_][^[:space:]]*=[^;&\(\`]*$)"
    if egrep -q -iv "$CONFIG_SYNTAX" "$configfile"; then
      echo "Config file is unclean, Please  cleaning it..." >&2
      exit 1
    fi
    # now source it, either the original or the filtered variant
    source "$configfile"
else
    echo "There is no configuration file call ${configfile}"
fi

cat <<'EOF > "pr_submit.md"

I believe this domain is an Adult(-related) domain --> that have to be blocked as..

```python
$domain
www.$domain
```

## Screenshots

<details><Summary>Screenshot required</summary>

![ScreenShot](https://github.com/Import-External-Sources/pornhosts/raw/api_test/screenshots/$domain.png)

</details>

## Additional for hosts files
```
"${additional[@]}"
```

### All Submissions:
- [X] Have you checked to ensure there aren't other open [Merge Requests (MR)](../merge_requests) or [Issues](../issues) for the same update/change?
- [X] Added a Screenshot for prove of Adult contents

### Todo
- [X] Added to [Source file](submit_here/hosts.txt)?
- [X] Added to the RPZ zone [adult.mypdns.cloud](https://www.mypdns.org/w/rpzlist/#adult-mypdns-cloud) (@spirillen)
EOF
