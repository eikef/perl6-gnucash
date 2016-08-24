use v6;
use Test;
use File::Directory::Tree;
use File::Temp;

plan 14;

# Make a directory for storing test files.
my $testfiledirectory = tempdir();
mktree($testfiledirectory);

use gnucash::NativeLib; pass "Import gnucash::NativeLib";
use gnucash; pass "Import gnucash & initialize engine";

my QofSession $session .= new;
isa-ok $session, QofSession, "Session created";
is $session.qof_session_get_error_message(), '', "Error reporting works";

$session.qof_session_begin('xml://'~$testfiledirectory~'/test.gnucash', 0, 1, 0);
is $session.qof_session_get_error_message(), '', "Session begun without errors, creating test.gnucash.";
$session.qof_session_save(Any);
is $session.qof_session_get_error_message(), '', "New test gnucash saved loaded without errors";
$session.qof_session_end();
is $session.qof_session_get_error_message(), '', "First session ended without errors";

$session.begin('xml://'~$testfiledirectory~'/test.gnucash'); pass "Second session begun";
is $session.qof_session_get_error_message(), '', "Session begun without errors.";

$session.qof_session_load( Any );
is $session.qof_session_get_error_message(), '', "Test gnucash file loaded without errors";

is $session.qof_session_get_file_path(), $testfiledirectory ~ '/test.gnucash', "qof_session_get_file_path returns correct path";

$session.qof_session_save( Any );
is $session.qof_session_get_error_message(), '', "Test gnucash file saved without errors";

is $session.qof_session_save_in_progress, 0, "gnucash engine thinks save completed, too";

$session.qof_session_end(); pass "Session ended";

rmtree($testfiledirectory);
