#!/usr/bin/env perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/local/lib/perl5";

use LWP;
use LWP::UserAgent;
use Time::Piece;

my $url = $ARGV[0];

my $ua = LWP::UserAgent->new;
my $request = new HTTP::Request(HEAD => $url);
my $header = $ua->request($request);

my $last_modified = $header->header('Last-Modified');
if (!$last_modified) {
    print "ZBX_NOTSUPPORTED\n";
    exit 1;
}

my $elapse = time - Time::Piece->strptime($last_modified, '%a, %d %b %Y %H:%M:%S %Z')->epoch;
print $elapse, "\n";
