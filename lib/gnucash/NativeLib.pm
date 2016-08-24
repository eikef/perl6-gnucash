use v6;

unit module gnucash::NativeLib:auth<github:eikef>;

use NativeCall;

# This could be used for some more magic finding the correct library to load --
# right now it just returns a library name and works on *ix
sub gncmod-engine {
    $*VM.platform-library-name('gncmod-engine'.IO).Str;
}
sub gnc-qof {
    $*VM.platform-library-name('gnc-qof'.IO).Str;
}
sub gnc-module {
    $*VM.platform-library-name('gnc-module'.IO).Str;
}


sub qof_log_init() is native(&gnc-qof) is export { * }

sub qof_init() is native(&gnc-qof) is export { * }

sub gnc_module_system_init() is native(&gnc-module) is export { * }

sub gnc_engine_init(int64 $argc, CArray[Str] $argv -->OpaquePointer) is native(&gncmod-engine) is export { * }

# See https://github.com/Gnucash/gnucash/blob/master/src/libqof/qof/qofsession.h
# for detailed descriptions of what the methods do
class QofSession is repr('CPointer') is export {
    # Convenience methods

    method new(-->QofSession) { self.qof_session_new() }
    method begin(Str $book_id, int64 $ignore_lock = 0, int64 $create = 0, int64 $force = 0) { self.qof_session_begin($book_id, $ignore_lock, $create, $force) }

    # Native methods
    method qof_session_new(::?CLASS:D: -->QofSession) is native(&gnc-qof) { * }

    method qof_session_begin(Str $book_id, int64 $ignore_lock, int64 $create, int64 $force) is native(&gnc-qof) { * }

    method qof_session_swap_data(QofSession $session2) is native(&gnc-qof) { * }

    method qof_session_load(&percentage_func (Str $message, num64 $percent)) is native(&gnc-qof) { * }

    # TODO: replace Opaquepointer with QofBackendError
    method qof_session_get_error(-->OpaquePointer) is native(&gnc-qof) { * }
    method qof_session_get_error_message(-->Str) is native(&gnc-qof) { * }
    method qof_session_pop_error(-->OpaquePointer) is native(&gnc-qof) { * }

    # TODO: replace OpaquePointer with QofBook
    method qof_session_get_book(-->OpaquePointer) is native(&gnc-qof) { * }

    method qof_session_get_file_path(-->Str) is native(&gnc-qof) { * }
    method qof_session_get_url(-->Str) is native(&gnc-qof) { * }

    method qof_session_save_in_progress(-->int64) is native(&gnc-qof) { * }

    method qof_session_save(&percentage_func (Str $message, num64 $percent)) is native(&gnc-qof) { * }
    method qof_session_safe_save(&percentage_func (Str $message, num64 $percent)) is native(&gnc-qof) { * }

    method qof_session_events_pending(-->int64) is native(&gnc-qof) { * }
    method qof_session_process_events(-->int64) is native(&gnc-qof) { * }

    method qof_session_export(QofSession $real_session, &percentage_func (Str $message, num64 $percent)) is native(&gnc-qof) { * }

    method qof_session_ensure_all_data_loaded() is native(&gnc-qof) { * }

    method qof_session_end() is native(&gnc-qof) { * }

    method qof_session_destroy() is native(&gnc-qof) { * }

    method DESTROY { self.qof_session_destroy() }
}
