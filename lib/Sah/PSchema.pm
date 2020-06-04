package Sah::PSchema;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

use Exporter 'import';
our @EXPORT_OK = qw(get_schema);

sub get_schema {
    my ($name, $args, $merge) = @_;

    my $mod = "Sah::PSchema::$name";
    (my $modpm = "$mod.pm") =~ s!::!/!g;
    require $modpm;

    $mod->get_schema($args, $merge);
}

1;
# ABSTRACT: Retrieve and resolve parameterized Sah schema

=head1 SYNOPSIS

In L<YourModule.pm>:

 package YourModule;
 use Sah::PSchema 'get_schema';

 our %SPEC;
 $SPEC{pick_word_from_wordlist} = {
     v => 1.1,
     args => {
         wordlist => {
             schema => get_schema('perl::modname', {ns_prefix=>'WordList'}, {req=>1}),
             req => 1,
             pos => 0,
         },
     }
 };
 sub pick_word_from_wordlist {
     ...
 }

 1;


=head1 DESCRIPTION

B<EXPERIMENTAL.>

This module implements parameterized L<Sah> schema in a simple way.
