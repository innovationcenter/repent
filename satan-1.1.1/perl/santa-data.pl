#
# SANTA data management routines.
#
require 'perl/targets.pl';
require 'perl/todo.pl';
require 'perl/facts.pl';

#
# Reset and point path names to new or existing data directory.
#
sub init_santa_data {
	local($directory);

	&clear_santa_data();
	&find_santa_data();
}

#
# Point path names to new or existing data directory.
#
sub find_santa_data {
	if ($santa_data =~ /\// ) {
		$directory = $santa_data;
	} else {
		(-d "results") || mkdir("results",0700) 
			|| die "results: invalid directory: $!\n";
		$directory = "results/$santa_data";
	}
	(-d "$directory") || mkdir("$directory",0700) 
		|| die "$santa_data: invalid directory: $!\n";

	$todo_file = "$directory/todo";
	$facts_file = "$directory/facts";
	$all_hosts_file = "$directory/all-hosts";
}

#
# Erase all in-core santa data structures.
#
sub clear_santa_data {
	&clear_all_hosts();
	&clear_facts();
	&clear_todos();
}

#
# Forget non-inference stuff we know about these hosts. We must save/reload
# the tables later, or memory will be polluted with stale inferences.
#
sub drop_santa_data {
	local($hosts) = @_;
	local($host);

	for $host (split(/\s+/, $hosts)) {
		&drop_all_hosts($host);
		&drop_old_todos($host);
		&drop_old_facts($host);
	}
}

#
# Read santa data from file. Existing in-core data is lost.
#
sub read_santa_data {

	&clear_santa_data();

	print "Reading $santa_data files...\n" if (-s $facts_file && $debug);

	&read_all_hosts($all_hosts_file) if -f $all_hosts_file;
	&read_facts($facts_file) if -f $facts_file;
	&read_todos($todo_file) if -f $todo_file;

	print "Done reading $santa_data files\n" if (-s $facts_file && $debug);
}

#
# Save santa data to file. Order may matter, in case we crash.
#
sub save_santa_data {
	&save_facts("$facts_file.new");
	rename("$facts_file.new", $facts_file)
		|| die "rename $facts_file.new -> $facts_file: $!\n";

	&save_todos("$todo_file.new");
	rename("$todo_file.new", $todo_file)
		|| die "rename $todo_file.new -> $todo_file: $!\n";

	&save_all_hosts("$all_hosts_file.new");
	rename("$all_hosts_file.new", $all_hosts_file)
		|| die "rename $all_hosts_file.new -> $all_hosts_file: $!\n";
}

#
# Merge data with in-core tables.
#
sub merge_santa_data {
	&merge_all_hosts($all_hosts_file) if -f $all_hosts_file;
	&merge_facts($facts_file) if -f $facts_file;
	&merge_todos($todo_file) if -f $todo_file;
}
