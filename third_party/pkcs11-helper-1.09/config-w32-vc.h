/* config.h.  Generated from config.h.in by configure.  */
/* config.h.in.  Generated from configure.ac by autoheader.  */

/* Enable certificate interface */
#define ENABLE_PKCS11H_CERTIFICATE 1

/* Enable data interface */
#define ENABLE_PKCS11H_DATA 1

/* Enable debug support */
#define ENABLE_PKCS11H_DEBUG 1

/* Use GNUTLS cryto engine */
/* #undef ENABLE_PKCS11H_ENGINE_GNUTLS */

/* Use OpenSSL crypto engine */
/* #undef ENABLE_PKCS11H_ENGINE_OPENSSL */

/* Use win32 crypto engine */
#define ENABLE_PKCS11H_ENGINE_WIN32 1

/* Enable openssl interface */
/* #undef ENABLE_PKCS11H_OPENSSL */

/* Enable slotevent interface */
#define ENABLE_PKCS11H_SLOTEVENT 1

/* Enable threading */
#define ENABLE_PKCS11H_THREADING 1

/* Enable token interface */
#define ENABLE_PKCS11H_TOKEN 1

/* Define to 1 if you have the `alarm' function. */
/* #undef HAVE_ALARM */

/* Define to 1 if you have the <dlfcn.h> header file. */
/* #undef HAVE_DLFCN_H */

/* Define to 1 if you don't have `vprintf' but do have `_doprnt.' */
/* #undef HAVE_DOPRNT */

/* Define to 1 if you have the `gettimeofday' function. */
/* #undef HAVE_GETTIMEOFDAY */

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the `dl' library (-ldl). */
/* #undef HAVE_LIBDL */

/* Define to 1 if you have the `pthread' library (-lpthread). */
/* #undef HAVE_LIBPTHREAD */

/* Define to 1 if you have the `memmove' function. */
#define HAVE_MEMMOVE 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `memset' function. */
#define HAVE_MEMSET 1

/* Define to 1 if you have the <pthread.h> header file. */
/* #undef HAVE_PTHREAD_H */

/* Define to 1 if you have the <signal.h> header file. */
/* #undef HAVE_SIGNAL_H */

/* Define to 1 if you have the `snprintf' function. */
#define HAVE_SNPRINTF 1

/* Define to 1 if you have the `socket' function. */
/* #undef HAVE_SOCKET */

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `strchr' function. */
#define HAVE_STRCHR 1

/* Define to 1 if you have the `strdup' function. */
#define HAVE_STRDUP 1

/* Define to 1 if you have the `strerror' function. */
#define HAVE_STRERROR 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the `strrchr' function. */
#define HAVE_STRRCHR 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/time.h> header file. */
#define HAVE_SYS_TIME_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the `vprintf' function. */
#define HAVE_VPRINTF 1

/* Define to 1 if you have the <[], [stdio.h], [stdlib.h], [stdargs.h],
   [malloc.h], [ctype.h], [string.h], [errno.h], [assert.h], [time.h], []>
   header file. */
/* #undef HAVE______STDIO_H____STDLIB_H____STDARGS_H____MALLOC_H____CTYPE_H____STRING_H____ERRNO_H____ASSERT_H____TIME_H_____ */

/* Name of package */
#define PACKAGE "pkcs11-helper"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME "pkcs11-helper"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "pkcs11-helper 1.09"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "pkcs11-helper"

/* Define to the version of this package. */
#define PACKAGE_VERSION "1.09"

/* Define if you are on Cygwin */
/* #undef PKCS11H_USE_CYGWIN */

/* Define printf format for size_t */
#define PRINTF_Z_FORMAT "%x"

/* Define as the return type of signal handlers (`int' or `void'). */
#define RETSIGTYPE void

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Test log level */
#define TEST_LOG_LEVEL 3

/* Test provider */
#define TEST_PROVIDER "@TEST_PROVIDER@"

/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
#define TIME_WITH_SYS_TIME 1

/* Define to 1 if your <sys/time.h> declares `struct tm'. */
/* #undef TM_IN_SYS_TIME */

/* Use valgrind memory debugging library */
/* #undef USE_VALGRIND */

/* Version number of package */
#define VERSION "1.09"

/* Define to empty if `const' does not conform to ANSI C. */
/* #undef const */

/* Define to `long int' if <sys/types.h> does not define. */
/* #undef off_t */

/* Define to `int' if <sys/types.h> does not define. */
/* #undef pid_t */

/* Define to `unsigned int' if <sys/types.h> does not define. */
/* #undef size_t */

/* Define to empty if the keyword `volatile' does not work. Warning: valid
   code using `volatile' can become incorrect without. Disable with care. */
/* #undef volatile */

/* Visual Studio 2005 supports vararg macros */
#if _MSC_VER >= 1400
#define HAVE_CPP_VARARG_MACRO_ISO 1
#endif
