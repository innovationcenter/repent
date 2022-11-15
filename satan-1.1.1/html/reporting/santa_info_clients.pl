#
# List hosts that use a specific service.
#
($_SERVICE, $_sort_order) = split(/,/, $html_script_args);
($_service = $_SERVICE) =~ tr/?!/ \//;

print CLIENT <<EOF;
<HTML>
<HEAD>
<title> Host Table - $_service Clients</title>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> Host Table - $_service Clients</H1>
<hr>

<h3> 
$client_severities{$_service} Vulnerable/$client_counts{$_service} total.
Vulnerability counts in parentheses.
</h3>

<H4> Sort hosts by:
<a href="santa_info_clients.pl,$_SERVICE,name,">name</a> |
<a href="santa_info_clients.pl,$_SERVICE,domain,">domain</a> |
<a href="santa_info_clients.pl,$_SERVICE,type,">system type</a> |
<a href="santa_info_clients.pl,$_SERVICE,subnet,">subnet</a> |
<a href="santa_info_clients.pl,$_SERVICE,severity,">problem count</a> |
<a href="santa_info_clients.pl,$_SERVICE,severity_type,">problem type</a>
</H4>

</FORM>
EOF

@_hosts = keys %{$clients{$_service}};
do "$html_root/reporting/sort_hosts.pl";
print CLIENT $@ if $@;

print CLIENT <<EOF;
<hr> <a href=$HTML_STARTPAGE> Back to the SANTA start page </a> |
<a href=analysis.pl> Back to SANTA Reporting and Analysis </a>
</BODY>
</HTML>
EOF
