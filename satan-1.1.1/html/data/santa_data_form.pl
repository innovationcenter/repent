#
# Select SANTA data base
#
$_santa_dir = "";
@_results = `ls results`;
for (@_results) { chop; }

print CLIENT <<EOF;
<HTML>
<HEAD>
<title> SANTA Data Management </title>
<LINK REV="made" HREF="mailto:santa\@fish.com">
</HEAD>
<BODY>
<H1><IMG SRC=$HTML_ROOT/images/santa.gif> SANTA Data Management </H1>
<hr>

<ul>
<p><li><a href="#open">Open or create SANTA database</a>
<p><li><a href="#merge">Merge existing SANTA database</a>
</ul>
<hr>

<FORM METHOD=POST ACTION="santa_open_action.pl">

<a name="open-or-create"><h3>Open existing or create new SANTA data base</h3>

<h3>
<INPUT TYPE="reset" VALUE=" Reset ">
<INPUT SIZE="28" NAME="_santa_dir" Value="$santa_data">
<INPUT TYPE="submit" VALUE=" Open or create ">
</h3>

</FORM>

EOF

if (@_results) {
	print CLIENT <<EOF;
	<h3>Existing data bases...</h3>
EOF
}

print CLIENT <<EOF;
<ul>
EOF
for (@_results) {
	if (-d "results/$_") {
		print CLIENT <<EOF;
		<li> <a href="santa_open_action.pl,$_,">$_</a>
EOF
	}
}

print CLIENT <<EOF;
</ul>

<hr>

<FORM METHOD=POST ACTION="santa_merge_action.pl">

<a name="merge"><h3>Merge with existing SANTA data base</h3>

<h3>
<INPUT TYPE="reset" VALUE=" Reset ">
<INPUT SIZE="28" NAME="_santa_dir" Value="">
<INPUT TYPE="submit" VALUE=" Merge ">
</h3>

</FORM>

EOF

if (@_results) {
	print CLIENT <<EOF;
	<h3>Existing data bases...</h3>
EOF
}

print CLIENT <<EOF;
<ul>
EOF

for (@_results) {
	if (-d "results/$_") {
		print CLIENT <<EOF;
		<li> <a href="santa_merge_action.pl,$_,">$_</a>
EOF
	}
}

print CLIENT <<EOF;
</ul>
<hr> <a href=$HTML_STARTPAGE> Back to the SANTA start page </a>
</BODY>
</HTML>
EOF
