use v6;
use Test;

plan 4;

use gnucash; pass "Import gnucash";

my $session = QofSession.new();

isa-ok $session, QofSession, "Session created";
is $session.qof_session_get_error_message(), '', "Error reporting works";

#$session.begin('t/test.gnucash'); pass "Session begun";
#is $session.qof_session_get_error_message(), '', "Session begun without errors.";

#$session.load( { * } );
#is $session.qof_session_get_error_message(), '', "Test gnucash file loaded without errors";

$session.end(); pass "Session ended";
