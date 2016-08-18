use v6;
use Test;

plan 11;

use gnucash::NativeLib; pass "Import gnucash::NativeLib";
use gnucash; pass "Import gnucash & initialize engine";

my QofSession $session .= new;

isa-ok $session, QofSession, "Session created";
is $session.qof_session_get_error_message(), '', "Error reporting works";

$session.begin('t/test.gnucash'); pass "Session begun";
is $session.qof_session_get_error_message(), '', "Session begun without errors.";

$session.qof_session_load( Any );
is $session.qof_session_get_error_message(), '', "Test gnucash file loaded without errors";

is $session.qof_session_get_file_path(), 't/test.gnucash', "qof_session_get_file_path returns correct path";

$session.qof_session_save( Any );
is $session.qof_session_get_error_message(), '', "Test gnucash file saved without errors";

is $session.qof_session_save_in_progress, 0, "gnucash engine thinks save completed, too"; 

$session.qof_session_end(); pass "Session ended";
