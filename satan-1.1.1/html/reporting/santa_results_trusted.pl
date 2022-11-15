#
# List hosts that this host trusts
#
($_TRUSTEE, $_sort_order) = split(/,/, $html_script_args);
($_trustee = $_TRUSTEE) =~ tr/?!/ \//;

print CLIENT <<EOF;
<HTML>
<HEAD>
<title> Trust - $_trustee</title>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> Trust - $_trustee</h1>
<hr>

<h3>Hosts trusted by $_trustee (vulnerability counts). </h3>

<H4> Sort hosts by:
<a href="santa_results_trusted.pl,$_TRUSTEE,name,">name</a> |
<a href="santa_results_trusted.pl,$_TRUSTEE,domain,">domain</a> |
<a href="santa_results_trusted.pl,$_TRUSTEE,type,">system type</a> |
<a href="santa_results_trusted.pl,$_TRUSTEE,subnet,">subnet</a> |
<a href="santa_results_trusted.pl,$_TRUSTEE,severity,">problem count</a> |
<a href="santa_results_trusted.pl,$_TRUSTEE,severity_type,">problem type</a> |
<a href="santa_results_trusted.pl,$_TRUSTEE,trusted_type,">trust type</a>
</H4>
EOF

@_hosts = split(/\s+/, $total_trusted_names{$_trustee});
do "$html_root/reporting/sort_hosts.pl";
print CLIENT $@ if $@;

print CLIENT <<EOF;
<hr> <a href=$HTML_STARTPAGE> Back to the SANTA start page </a> |
<a href=analysis.pl> Back to SANTA Reporting and Analysis </a>
</BODY>
</HTML>
EOF
