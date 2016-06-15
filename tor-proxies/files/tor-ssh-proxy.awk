# This script parses '/sbin/route -n show' output and
# prints "TCP:host:port" if 'host' is in a local network
# or "SOCKS4A:127.0.0.1:host:port,socksport=9050".
#
# The arguments 'host' and 'port' are passed with
# awk -v host=$1 -v port=$2 ...
#
# The script isn't robust but "it works for me".

$1=="default" {
	split($2, a, ".")
	match1 = a[1] "." a[2] "." a[3]
	pattern1 = match1 ".0/24"
	pattern10 = match1 "/24"
	match2 = a[1] "." a[2]
	pattern2 = match2 "/16"
	pattern20 = match2 ".0.0/16"

	if (substr(host, 1, 4) == "127.")
		matched = 1
}

pattern1 != "" && ($1 == pattern1 || $1 == pattern10) && index(host, match1) == 1 {
	matched = 1
}

pattern2 != "" && ($1 == pattern2 || $1 == pattern20) && index(host, match2) == 1 {
	matched = 1
}

END {
	if (verbose != "") {
		print "host: " host "."
		print "port: " port "."
		print "match1: "  match1 "."
		print "pattern1: "  pattern1 "."
		print "pattern10: " pattern10 "."
		print "match2: "  match2 "."
		print "pattern2: "  pattern2 "."
		print "pattern10: " pattern20 "."
	}
	if (matched != "")
		print "TCP:" host ":" port
	else
		print "SOCKS4A:127.0.0.1:" host ":" port ",socksport=9050"
}
