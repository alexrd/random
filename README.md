# Random

A set of random useful tools.

## compenv.pl

A Perl script to compare two environments.

Usage example: 

  env > a.log  # in env 1
  env > b.log  # in env 2
  compenv.pl a.log b.log

## parseseletext.pl

A way to parse selection output from CHARMM to use in VMD.

Usage example:

  (in CHARMM):  define neartest select ( segid TEST .around. 8 .and. segid PROA ) show end
  (copy this and paste to the file "neartest.dat")
  parseseletext.pl < neartest.dat
  (copy this and paste to VMD window)
