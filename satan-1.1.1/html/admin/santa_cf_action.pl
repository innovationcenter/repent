#
# Collect data and keep the user informed.
#

require "perl/config.pl";

#
# Make sure they specified a data file
if ($santa_data eq "") {
	print CLIENT <<EOF;
<HTML>
<HEAD>
<TITLE>Error - Missing input (no SANTA data file found)</TITLE>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> Error - Missing input </H1>
<hr>
No data directory was specified.
</BODY>
</HTML>
EOF
	die "\n";
	}

#
# Write the data...
&write_config_file($html_post_attributes);

print CLIENT <<EOF;
<HTML>
<HEAD>
<TITLE>SANTA Configuration Management</TITLE>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> SANTA Configuration Management </H1>
<hr>
<B>Configuration file changed</B>
<hr> <a href=$HTML_STARTPAGE> Back to the SANTA start page </a>
</BODY>
</HTML>
EOF
