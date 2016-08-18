use v6;

unit module gnucash:auth<github:eikef>;

use NativeCall;
use gnucash::NativeLib;

# Initialization of gnucash
INIT {
    qof_log_init();
    qof_init();
    gnc_module_system_init();
    gnc_engine_init(0, CArray[Str].new);
}
