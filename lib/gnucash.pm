use v6;

unit module gnucash:auth<github:eikef>;

use NativeCall;

# This could be used for some more magic finding the correct library to load --
# right now it just returns a library name and works on *ix
sub gncmod-engine {
    $*VM.platform-library-name('gncmod-engine'.IO).Str;
}

sub qof_init() is native(&gncmod-engine) { * }

INIT {
    qof_init()
}

class QofSession is repr('CPointer') is export {
    sub qof_session_new() is native(&gncmod-engine) returns QofSession { * }
    sub qof_session_begin(QofSession $session, Str $book_id, int64 $ignore_lock, int64 $create, int64 $force) is native(&gncmod-engine) { * }

    method new() { qof_session_new() }
    method begin(Str $book_id, int64 $ignore_lock, int64 $create, int64 $force) { qof_session_begin(self, $book_id, $ignore_lock, $create, $force) }
}

