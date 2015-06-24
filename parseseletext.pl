#!/usr/bin/env perl

# this script parses a selection text from CHARMM, produced using "sele <selection> show end"
#  this is a sample of the required input:
#
# PROA     1        ILE N HN CA HA HG21 CD HD1 HD2 C       
# PROA     2        VAL N HN CA HA CB HB CG1 HG12 HG13 CG2 HG21 HG22 HG23 C O       
# PROA     23       HSD HE1 NE2     
# PROA     40       HSD CE1 NE2 CD2 HD2     
# PROA     122      GLY HA1     
# PROA     123      ASN HN HB2 ND2 HD22 O       
# PROA     125      SER CA HA C O       
# PROA     126      GLY N HN CA HA1 HA2 C O       
# PROA     127      SER N HN HG1     
#
# it outputs a selection command that can be copied and pasted into VMD:
#
# segid PROA .and. ((resid 1 .and. type N HN CA HA HG21 CD HD1 HD2 C) .or. (resid 2 .and. .... ) etc.
#

my %sel;
while (my $line = <STDIN>) {
    chomp($line);
    my @arr = split(/\s+/,$line);
    shift(@arr);  # throw away the first space
    my $segid = shift(@arr);
    my $resid = shift(@arr);
    shift(@arr);   # throw away resname
    $sel{$segid}{$resid} = \@arr;
}

my $firstseg = 1;
my $cmd = "";
for my $segid (keys %sel) {
    if ($firstseg) {
	$firstseg = 0;
    } else {
	$cmd .= "or ";
    }
    $cmd .= "segid $segid and (";
    my $firstres = 1;
    for my $resid (keys %{$sel{$segid}}) {
	my @types = @{$sel{$segid}{$resid}};
	if ($firstres) {
	    $firstres = 0;
	} else {
	    $cmd .= "or ";
	}
	$cmd .= "(resid $resid and type @types) ";
    }
    $cmd .= ")";
}
print("$cmd\n");
