#
# Open a data base and keep the user informed.
#
($_directory) = split(/,/, $html_script_args);

#
# Make sure they specified a directory at all.
#
$_directory = $_santa_dir if $_directory eq "";

if ($_directory eq "") {
	print CLIENT <<EOF;
<HTML>
<HEAD>
<TITLE>Error - Missing input </TITLE>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> Error - Missing input </H1>
<hr>
No data base name was specified.
</BODY>
</HTML>
EOF
	die "\n";
}

#
# Create data base when it does not exist
#
$santa_data = $_directory;
&init_santa_data();

#
# Read the data base, after resetting the in-core data structures.
#
print CLIENT <<EOF;
<HTML>
<HEAD>
<TITLE>SANTA Data Management</TITLE>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> SANTA Data Management</H1>
<HR>
EOF

if (-s "$facts_file") {
	print CLIENT <<EOF;
<strong>Loading data from <i> $_directory. </i> This may take some time. <p>
EOF
}

&read_santa_data();

print CLIENT <<EOF;
<strong>Data base selection completed successfully.</strong>
<hr> <a href=$HTML_STARTPAGE> Back to the SANTA start page </a>
| <a href=../reporting/analysis.pl>Continue with report and analysis</a>
</BODY>
</HTML>
EOF
