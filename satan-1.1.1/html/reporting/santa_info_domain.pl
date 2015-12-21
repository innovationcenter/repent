#
# Report all internet domains.
#
print CLIENT <<EOF;
<HTML>
<HEAD>
<title> Host Tables - by Internet Domain </title>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> Host Tables - by Internet Domain </H1>
<hr>
<h3>Number of hosts per internet domain (vulnerable/total).</h3>
<strong>Domains with a red dot next to them have a vulnerable host contained within.</strong>
<ul>
EOF

&make_domain_info() ;

for (sort keys %all_domains) {
	next if (!$_);
	$_dot = $domain_severities{$_} ? "reddot" : "blackdot";
	$_alt = $domain_severities{$_} ? "*" : "-";
	print CLIENT <<EOF;
	<dt><IMG SRC=$HTML_ROOT/dots/$_dot.gif ALT="$_alt"> 
	<a href="santa_results_domain.pl,$_,"> $_</a>
	($domain_severities{$_}/$domain_count{$_})
EOF
}

print CLIENT <<EOF;
</ul>
EOF

if (sizeof(*all_domains) == 0) {
	print CLIENT <<EOF;
	No domain information available.
EOF
}

print CLIENT <<EOF;
</ul>
<hr> <a href=$HTML_STARTPAGE> Back to the SANTA start page </a> |
<a href=analysis.pl> Back to SANTA Reporting and Analysis </a>
</BODY>
</HTML>
EOF
