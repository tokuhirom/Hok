package Hok::Util;
use strict;
use warnings;
use utf8;
use Cwd;
use Data::Dumper;
use File::Spec ();

# ref. https://github.com/cho45/Test-Name-FromLine/pull/2
our $BASE_DIR = getcwd();

{
    my %file_cache;
    sub test_line {
        my $level = 1;
        LOOP:
        while (my @caller = caller($level++)) {
            my ($pkg, $fname, $lnum) = @caller;
            if ($pkg !~ /^(Hok$|Hok::|Test::)/) {
                my $lines = $file_cache{$fname} ||= do {
                    my $absfname = File::Spec->rel2abs($fname, $BASE_DIR);
                    open my $fh, '<', $absfname
                        or next LOOP;
                    [<$fh>];
                };
                my $line = $lines->[$lnum-1];
                $line =~ s{^\s+|\s+$}{}g;
                return "L$lnum: $line";
            }
        }
        return undef;
    }
}

sub p($) {
    local $Data::Dumper::Terse = 1;
    Dumper($_[0]);
}

1;

