#!/usr/bin/env perl

use Term::ANSIColor;

my %env;

my $file1 = shift(@ARGV);
my $file2 = shift(@ARGV);

open(MYIN,$file1);
while (my $line = <MYIN>) {
    chomp($line);
    my @arr = split(/=/,$line);
    $env{$arr[0]}{"1"} = $arr[1];
}
close(MYIN);

open(MYIN,$file2);
while (my $line = <MYIN>) {
    chomp($line);
    my @arr = split(/=/,$line);
    $env{$arr[0]}{"2"} = $arr[1];
}
close(MYIN);

for (keys %env) {
    if ($env{$_}{"1"} ne $env{$_}{"2"}) {
	print("$file1\t");
	print colored (['magenta'],"($_) : \t$env{$_}{'1'}\n");
	print("$file2\t");
	print colored (['green'],"($_) : \t$env{$_}{'2'}\n");
    }
}

# split up path and lib to compare term-by-term

my %path;
my %lib;

my @arr = split(/:/,$env{"PATH"}{"1"});
for (@arr) {
    $path{$_}{"1"} = 1;
}
@arr = split(/:/,$env{"PATH"}{"2"});
for (@arr) {
    $path{$_}{"2"} = 1;
}

my @arr = split(/:/,$env{"LD_LIBRARY_PATH"}{"1"});
for (@arr) {
    $lib{$_}{"1"} = 1;
}
@arr = split(/:/,$env{"LD_LIBRARY_PATH"}{"2"});
for (@arr) {
    $lib{$_}{"2"} = 1;
}

print("$file1\t");
print colored (['magenta'],"PATH unique:\t");
my $found = 0;
for (keys %path) {
    if ($path{$_}{"1"} == 1 && !exists $path{$_}{"2"}) {
	print colored (['magenta'],"$_ ");
	$found = 1;
    }
}
if (!$found) { print colored (['magenta'],"None"); }
print("\n");
print("$file2\t");
print colored (['green'],"PATH unique:\t");
$found = 0;
for (keys %path) {
    if ($path{$_}{"2"} == 1 && !exists $path{$_}{"1"}) {
	print colored (['green'],"$_ ");
	$found = 1;
    }
}
if (!$found) { print colored (['green'],"None"); }
print("\n");

print("$file1\t");
print colored (['magenta'],"LD_LIBRARY_PATH unique:\t");
$found = 0;
for (keys %lib) {
    if ($lib{$_}{"1"} == 1 && !exists $lib{$_}{"2"}) {
	print colored (['magenta'],"$_ ");
	$found = 1;
    }
}
if (!$found) { print colored (['magenta'],"None"); }
print("\n");
print("$file2\t");
print colored (['green'],"LD_LIBRARY_PATH unique:\t");
$found = 0;
for (keys %lib) {
    if ($lib{$_}{"2"} == 1 && !exists $lib{$_}{"1"}) {
	print colored (['green'],"$_ ");
	$found = 1;
    }
}
if (!$found) { print colored (['green'],"None"); }
print("\n");
