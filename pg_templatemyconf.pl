#! /usr/bin/env perl
use strict;
use warnings;
use 5.010;
use Getopt::Declare;


my $specification = q(
        -i <CONFIG_FILE>	open config file to read [required]
        -t <TEMPLATE_FILE>	jinja2 template file will be written [required]
        -d <DEFAULTS_FILE>	YAML defaults file  will be written [required]
);

my $args = Getopt::Declare->new($specification);
my $config_file = $args->{'-i'};
my $template_file = $args->{'-t'};
my $defaults_file = $args->{'-d'};

if ( ! open CONFIG, '<', $config_file ) {
	die "Cannot open config file: $!";
}
if ( ! open TEMPLATE, '>', $template_file ) {
	die "Cannot create template file: $!";
}
if ( ! open DEFAULTS, '>', $defaults_file ) {
	die "Cannot create defaults file: $!";
}

print TEMPLATE "{{ ansible_managed | comment }}\n";
print DEFAULTS "---\n\n";
while (<CONFIG>) {
	if (/^(\w+) = (-?\d+\.?\d*)(\s*)\#(.*)$/) {
		print TEMPLATE "$1 = {{ pg_$1 | default($2) }}$3\#$4\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^(\w+) = (\w+)(\s*)\#(.*)$/) {
		print TEMPLATE "$1 = {{ pg_$1 | default('$2') }}$3\#$4\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^(\w+) = (\'\S*\')(\s*)\#(.*)$/) {
		print TEMPLATE "$1 = '{{ pg_$1 | default($2) }}'$3\#$4\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^(\w+) = (-?\d+\.?\d*)$/) {
		print TEMPLATE "$1 = {{ pg_$1 | default($2) }}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^(\w+) = (\w+)$/) {
		print TEMPLATE "$1 = {{ pg_$1 | default('$2') }}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^(\w+) = (\'\S*\')$/) {
		print TEMPLATE "$1 = '{{ pg_$1 | default($2) }}'\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^\#(\w+) = (-?\d+\.?\d*)(\s+)(.*)$/) {
		print TEMPLATE;
		print TEMPLATE "{% if ( pg_$1 is defined ) %}\n$1 = {{ pg_$1 | default($2) }}\n{% endif %}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^\#(\w+) = (\w+)(\s+)(.*)$/) {
		print TEMPLATE;
		print TEMPLATE "{% if ( pg_$1 is defined ) %}\n$1 = {{ pg_$1 | default('$2') }}\n{% endif %}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^\#(\w+) = (\'\S*\')(\s+)(.*)$/) {
		print TEMPLATE;
		print TEMPLATE "{% if ( pg_$1 is defined ) %}\n$1 = '{{ pg_$1 | default($2) }}'\n{% endif %}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^\#(\w+) = (-?\d+\.?\d*)$/) {
		print TEMPLATE;
		print TEMPLATE "{% if ( pg_$1 is defined ) %}\n$1 = {{ pg_$1 | default($2) }}\n{% endif %}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} elsif (/^\#(\w+) = (\w+)$/) {
		print TEMPLATE;
		print TEMPLATE "{% if ( pg_$1 is defined ) %}\n$1 = {{ pg_$1 | default('$2') }}\n{% endif %}\n";
		print DEFAULTS "\# pg_$1: $2\n";
    	} elsif (/^\#(\w+) = (\'\S*\')$/) {
		print TEMPLATE;
		print TEMPLATE "{% if ( pg_$1 is defined ) %}\n$1 = '{{ pg_$1 | default($2) }}'\n{% endif %}\n";
		print DEFAULTS "\# pg_$1: $2\n";
	} else {
		print TEMPLATE;
	}
}
