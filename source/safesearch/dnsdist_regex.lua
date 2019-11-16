--[[
This is the regex based rewrites from moderate or unsafe searches into safe 
search for known domains. Listed from most privacy enhanged to least privacy

You can activate this file in your dnsdist.conf by:
dofile(conf/dnsdist_regex.lua)

And don't forget order matters
--]

-- duckduckgo.com static
addAction('duckduckgo.com.', SpoofCNAMEAction('safe.duckduckgo.com.'))

-- Yandex
-- See https://gitlab.com/my-privacy-dns/matrix/matrix/issues/582

-- Yahoo
-- See https://gitlab.com/my-privacy-dns/matrix/matrix/issues/582

-- Bing
addAction('RegexRule("(^|\\.)bing[.][a-z]{2,5}([.][a-z]{2})?$"), SpoofCNAMEAction('strict.bing.com.'))

-- Google
addAction(RegexRule("(^|\\.)google[.][a-z]{2,5}([.][a-z]{2})?$"), SpoofCNAMEAction('forcesafesearch.google.com.'))

-- Youtube
-- Strict
addAction('www.youtube.com.', SpoofCNAMEAction('restrict.youtube.com.'))
addAction('m.youtube.com.', SpoofCNAMEAction('restrict.youtube.com.'))
addAction('youtubei.googleapis.com.', SpoofCNAMEAction('restrict.youtube.com.'))
addAction('youtube.googleapis.com.', SpoofCNAMEAction('restrict.youtube.com.'))
addAction('www.youtube-nocookie.com.', SpoofCNAMEAction('restrict.youtube.com.'))

-- Strict moderate
--[[
addAction('www.youtube.com.', SpoofCNAMEAction('restrictmoderate.youtube.com.'))
addAction('m.youtube.com.', SpoofCNAMEAction('restrictmoderate.youtube.com.'))
addAction('youtubei.googleapis.com.', SpoofCNAMEAction('restrictmoderate.youtube.com.'))
addAction('youtube.googleapis.com.', SpoofCNAMEAction('restrictmoderate.youtube.com.'))
addAction('www.youtube-nocookie.com.', SpoofCNAMEAction('restrictmoderate.youtube.com.'))
--]]
