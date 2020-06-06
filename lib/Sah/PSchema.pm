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
    my ($name, $args, $clause_set) = @_;

    my $mod = "Sah::PSchema::$name";
    (my $modpm = "$mod.pm") =~ s!::!/!g;
    require $modpm;

    $mod->get_schema($args, $clause_set);
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


=head1 FUNCTIONS

=head2 get_schema

Usage:

 my $sch = get_schema($psch, \%args [ , \%clause_set ]);

Example:

 my $sch = get_schema("perl::modname", {ns_prefix=>"WordList"}, {req=>1});
 # => ["perl::modname", {req=>1, 'x.completion'=>[perl_modname => {ns_prefix=>"WordList"}]}]

The function simply loads C<Sah::PSchema::$psch> module then calls its
C<get_schema> method with the arguments \%args and \%clause_set. In the above
example, the module L<Sah::PSchema::perl::modname> module is loaded. This
parameterized schema basically just return the regular C<perl::modname> (from
L<Sah::Schema::perl::modname>) but with the C<ns_prefix> argument put into
argument for C<x.completion>.


=head1 SEE ALSO

L<Sah::Schemas> and C<Sah::Schema::*>

L<Sah::PSchemas> and C<Sah::PSchema::*>

L<Sah> and L<Data::Sah>
