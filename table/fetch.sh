#!/bin/sh
fetch="fetch"
#fetch="wget"


## The Unicode Consortium
##   http://unicode.org/
${fetch} http://www.unicode.org/Public/MAPPINGS/OBSOLETE/EASTASIA/JIS/JIS0201.TXT
${fetch} http://www.unicode.org/Public/MAPPINGS/OBSOLETE/EASTASIA/JIS/JIS0208.TXT
${fetch} http://www.unicode.org/Public/MAPPINGS/OBSOLETE/EASTASIA/JIS/JIS0212.TXT
${fetch} http://www.unicode.org/Public/UNIDATA/EastAsianWidth.txt


## Project X0213
##   http://x0213.org/codetable/
${fetch} http://x0213.org/codetable/iso-2022-jp-2004-std.txt

