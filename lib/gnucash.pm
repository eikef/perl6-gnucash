use v6;

unit module gnucash:auth<github:eikef>;

use NativeCall;

# For now this only works without change if you are on *ix and the gnucash libraries are found in /usr/lib64/gnucash. Unfortunately relative paths do not work.
sub gncmod-engine {
    $*VM.platform-library-name('/usr/lib64/gnucash/gncmod-engine'.IO).Str
}

class QofSession is repr('CPointer') {
    sub qof_session_new() is native(&gncmod-engine) returns QofSession { * }
    sub qof_session_begin(QofSession $session, Str $book_id, int64 $ignore_lock, int64 $create, int64 $force) is native(&gncmod-engine) { * }

    method new() { qof_session_new() }
    method begin(Str $book_id, int64 $ignore_lock, int64 $create, int64 $force) { qof_session_begin(self, $book_id, $ignore_lock, $create, $force) }
}
