/*
 * scheme.h - Scheme system header
 *
 *   Copyright (c) 2008  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Id$
 */

#ifndef __SCHEME_SCHEME_H__
#define __SCHEME_SCHEME_H__

#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif

// #include <iostream>
// #include <stdint.h>
// #include <stdarg.h>
// #include <string.h>
#include <unistd.h>
// #include <assert.h>
#include <errno.h>


// #include "dirent.h"
// #include <setjmp.h>
// #include <sys/time.h>
// #include <stdio.h>
// #include <signal.h>
#include <inttypes.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>
#include <gmp.h>
#include <map>
#include <vector>
#ifdef USE_BOEHM_GC
#define EXTEND_GC : public gc
#include <gc_cpp.h>
#include <gc_allocator.h>
template <class T1, class T2>
class gc_map : public std::map<T1, T2, std::less<T1>, gc_allocator<std::pair<const T1, T2> > >, public gc { };
template <class T1>
class gc_vector : public std::vector<T1, gc_allocator<T1> >, public gc { };
#else
#define EXTEND_GC
template <class T1, class T2>
class gc_map : public std::map<T1, T2> {};

template <class T1>
class gc_vector : public std::vector<T1> {};
#endif

#define LOG1(fmt, a)       fprintf(stderr, "%s", format(UC(fmt), L1(a)).toString()->data().ascii_c_str());fflush(stderr);
#define LOG2(fmt, a, b)    fprintf(stderr, "%s", format(UC(fmt), L2(a, b)).toString()->data().ascii_c_str());fflush(stderr);
#define LOG3(fmt, a, b, c) fprintf(stderr, "%s", format(UC(fmt), L3(a, b, c)).toString()->data().ascii_c_str());fflush(stderr);


#ifdef DEBUG_VERSION
#define MOSH_ASSERT(condition) { if (!(condition)) { fprintf(stderr, "ASSERT failure %s:%d: %s\n", __FILE__, __LINE__, #condition); ::exit(-1);}}
#define MOSH_FATAL(condition) { fprintf(stderr, "FATAL  %s:%d: %s\n", __FILE__, __LINE__, #condition); ::exit(-1);}
#else
#define MOSH_ASSERT(condition) /* */
#define MOSH_FATAL(condition) /* */
#endif

#define INIT_TIME_TRACE() struct timeval tv1, tv2
#define START_TIME_TRACE() gettimeofday(&tv1, NULL)
#define END_TIME_TRACE(label) gettimeofday(&tv2, NULL);printf("%s %ld usec\n", #label, (tv2.tv_sec - tv1.tv_sec) * 1000000 + (tv2.tv_usec - tv1.tv_usec))


enum {
    MOSH_SUCCESS,
    MOSH_FAILURE,
    forbidden_comma
};

#define UC(a) (reinterpret_cast<const ucs4char*>(L##""a))

typedef intptr_t word;
typedef int32_t ucs4char; // use -1 for EOF

#ifdef __GNUC__
#define ALWAYS_INLINE  __attribute__((always_inline))
#define USE_DIRECT_THREADED_CODE
#else
#define ALWAYS_INLINE
#endif


#include "ucs4string.h"

#define PRFILER_TEMP_FILE "/tmp/mosh-profiler.log"

void* my_realloc(void *ptr, size_t oldSize, size_t newSize);
void my_dont_free(void *ptr, size_t size);
void mosh_init();

namespace scheme {


#ifdef USE_BOEHM_GC
class Object;
typedef std::vector<Object, gc_allocator<Object> > ObjectVector;
#else
class Object;
typedef std::vector<Object> ObjectVector;
#endif

//extern int strcmp99(const ucs4char *s1, const ucs4char *s2);
struct ltstr EXTEND_GC
{
  bool operator()(const ucs4char* s1, const ucs4char* s2) const
  {
      while (*s1 == *s2++) {
          if (*s1++=='\0') {
              return false;
          }
      }
    return(*s1 - *--s2) < 0;
  }
};

#ifdef USE_BOEHM_GC
class gc_map2 : public std::map<const ucs4char* const, Object, ltstr, gc_allocator<std::pair<const ucs4char* const, Object> > >, public gc { };
#else
    class gc_map2 : public std::map<const ucs4char* const, Object, ltstr, std::allocator<std::pair<const ucs4char* const, Object> > > {};
#endif
};


// from Gauche
#define SCM_SYSCALL3(result, expr, check)       \
    do {                                        \
        (result) = (expr);                      \
        if ((check) && errno == EINTR) {        \
            /* ScmVM *vm__ = Scm_VM(); */       \
            errno = 0;                          \
            /* SCM_SIGCHECK(vm__); */           \
        } else {                                \
            break;                              \
        }                                       \
    } while (1)
#define SCM_SYSCALL(result, expr) \
    SCM_SYSCALL3(result, expr, (result < 0))

#endif // __SCHEME_SCHEME_H__
