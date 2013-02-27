package Stream;

use strict;
use warnings;

use base 'Exporter';

our @EXPORT_OK = qw(node value tail drop promise show upto upfrom filter transform);

our %EXPORT_TAGS = ('all' => \@EXPORT_OK);

sub node {
   my ($value, $tail) = @_;
   return [$value, $tail];
}

sub value {    # head
   my $stream = shift;
   return $stream->[0];
}

sub tail {
   my $stream = shift;
   if (is_promise($stream->[1])) {
      $stream->[1] = $stream->[1]->();
   }
   return $stream->[1];
}

sub drop {
   my $val = value($_[0]);
   $_[0] = tail($_[0]);
   return $val;
}

sub is_promise {
   UNIVERSAL::isa($_[0], 'CODE');
}

sub promise (&) { $_[0] }

sub show {
   my ($stream, $n) = @_;

   while ($stream && (! defined $n || $n-- > 0)) {
      print drop($stream), $";
   }

   print $/;
}

sub upto {
   my ($m, $n) = @_;

   return if $m > $n;

   node($m, promise { upto($m + 1, $n) });
}

sub upfrom {
   my $m = shift;
   node($m, promise { upfrom($m + 1) });
}

sub transform(&$) {
   my $fun    = shift;
   my $stream = shift;

   return unless $stream;

   return node($fun->(value($stream)), promise { transform($fun, tail($stream)) });
}

sub filter(&$) {
   my $fun    = shift;
   my $stream = shift;

   until (! $stream || $fun->(value($stream))) {
      drop($stream);
   }

   return unless $stream;

   node(value($stream), promise { filter($fun, tail($stream)) });
}


1;
