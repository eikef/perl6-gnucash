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
    # qof_init needs to be called in order to set up glib and such
    qof_init()
}

# See https://github.com/Gnucash/gnucash/blob/master/src/libqof/qof/qofsession.h
# for detailed descriptions of what the methods do
class QofSession is repr('CPointer') is export {
    method new(-->QofSession) is native(&gncmod-engine) is symbol('qof_session_new') { * }

    method qof_session_begin(Str $book_id, int64 $ignore_lock, int64 $create, int64 $force) is native(&gncmod-engine) { * }
    method begin(Str $book_id, int64 $ignore_lock = 0, int64 $create = 0, int64 $force = 0) {
        self.qof_session_begin($book_id, $ignore_lock, $create, $force)
    }

    #| Swaps Data of current session with another session. This is for stuff like "save as"
    method swap_data(QofSession $session2) is native(&gncmod-engine) is symbol('qof_session_swap_data') { * }

    #| Loads/makes ready book from datastore
    method load(&percentage_func (Str $message, num64 $percent)) is native(&gncmod-engine) is symbol('qof_session_load') { * }

    # TODO: replace Opaquepointer with QofBackendError
    method qof_session_get_error(-->OpaquePointer) is native(&gncmod-engine) { * }
    method qof_session_get_error_message(-->Str) is native(&gncmod-engine) { * }
    method qof_session_pop_error(-->OpaquePointer) is native(&gncmod-engine) { * }

    # TODO: replace OpaquePointer with QofBook
    method qof_session_get_book(-->OpaquePointer) is native(&gncmod-engine) { * }

    method qof_session_get_file_path(-->Str) is native(&gncmod-engine) { * }
    method qof_session_get_url(-->Str) is native(&gncmod-engine) { * }

    method qof_session_save_in_progress(-->int64) is native(&gncmod-engine) { * }

    method qof_session_get_backend() is native(&gncmod-engine) { * }
    method qof_session_save(&percentage_func (Str $message, num64 $percent)) is native(&gncmod-engine) { * }
    method qof_session_safe_save(&percentage_func (Str $message, num64 $percent)) is native(&gncmod-engine) { * }

    method qof_session_events_pending(-->int64) is native(&gncmod-engine) { * }
    method qof_session_process_events(-->int64) is native(&gncmod-engine) { * }

    method qof_session_export(QofSession $real_session, &percentage_func (Str $message, num64 $percent)) is native(&gncmod-engine) { * }

    #| Ends a Gnucash QOF session and releases locks if applicable
    method end() is native(&gncmod-engine) is symbol('qof_session_end') { * }

    method qof_session_destroy() is native(&gncmod-engine) { * }
    method DESTROY { self.qof_session_destroy() }
}

