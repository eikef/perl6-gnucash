use v6;
use Test;

plan 3;

use gnucash; pass "Import gnucash";

# Sessions
my $session = gnucash::QofSession.new();

isa-ok $session, gnucash::QofSession, "Session created";

$session.begin('', 0, 0, 0); pass "Session begun";

