# GLOBAL CFLAGS

GLOBAL_CFLAGS =  @ONIG_CFLAGS@ \
		 -g \
		 -Wall -Wno-deprecated \
		 -I src -I $(includedir) \
		 -D MONA_SCHEME -D USE_BOEHM_GC \
		 -D MOSH_LIB_PATH="\"@MOSH_LIB_PATH@\"" \
		 -D_FILE_OFFSET_BITS=64 -Wall -pipe $(DEBUG_FLAGS) \
		 @MOSH_OPTS@ # temp -Wno-deprecated

LIBS += @ONIG_LIBS@

if DEVELOPER
GIT_BRANCH=$(shell git symbolic-ref HEAD|cut -d'/' -f3)
GIT_IS_DIRTY=$(shell git diff --quiet HEAD || echo "dirty")
GIT_COMMIT_REVISION=$(shell git describe --always)$(GIT_IS_DIRTY)
GIT_COMMIT_UNIXTIME=$(shell git cat-file commit HEAD|grep 'committer'|  awk '{ print $$(NF-1); }')
GIT_COMMIT_DATE=$(shell date -d "1970/01/01 09:00:00 $(GIT_COMMIT_UNIXTIME) seconds" "+%Y/%m/%d %H:%M:%S")
GLOBAL_CFLAGS+=-D GIT_BRANCH="\"$(GIT_BRANCH)\"" -D GIT_COMMIT_REVISION="\"$(GIT_COMMIT_REVISION)\"" -D GIT_COMMIT_DATE="\"$(GIT_COMMIT_DATE)\""
else
GIT_BRANCH=UNKNOWN
GIT_COMMIT_REVISION=UNKNOWN
GIT_COMMIT_DATE=UNKNOWN
endif

if DEVELOPER
DEBUG_FLAGS=-DDEBUG_VERSION
endif

AM_CFLAGS   = $(GLOBAL_CFLAGS)
AM_CXXFLAGS = $(GLOBAL_CFLAGS)

# Boehm GC
BOEHM_GC_DIR = gc-7.1
GC_LIB       = $(BOEHM_GC_DIR)/.libs/libgc.a

## Regexp library oniguruma
#ONIG_DIR   = onig-5.7.0
#REGEXP_LIB = $(ONIG_DIR)/.libs/libonig.a

# for GTEST
GTEST_DIR     = $(top_srcdir)/gtest
USER_DIR      = .
TESTS         = # used later

#SUBDIRS = $(BOEHM_GC_DIR) $(ONIG_DIR) .
SUBDIRS = $(BOEHM_GC_DIR) .

man_MANS = doc/mosh.1 doc/mosh_config.1

if DEVELOPER
bin_PROGRAMS = mosh nmosh test_port test_fasl test_ffi test_object test_vm test_compat test_getopt test_thread
else
bin_PROGRAMS = mosh nmosh
endif

bin_SCRIPTS = src/mosh_config

# mosh core sources

MOSH_CORE_SRCS = \
src/Code.h  src/SharedReference.h                                      \
src/NonGenerativeRTDs.h                                                \
src/HeapObject.h                                                       \
src/Object-inl.h                                                       \
src/Object-accessors.h                                                 \
src/Pair-inl.h                                                         \
src/VM-inl.h                                                           \
src/match.h                                                            \
src/baselib.h                                                          \
src/CProcedure.h                                                       \
src/Instruction.h                                                      \
src/Callable.h                                                         \
src/GenericMap.h                                                       \
src/BinaryInputPort.h                                                  \
src/BinaryOutputPort.h                                                 \
src/scheme.h                                                           \
src/ByteVector.h                                                       \
src/HashTable.h                                                        \
src/Pair.h                                                             \
src/ExecutableMemory.h                                                 \
src/LineBufferedFileBinaryOutputPort.h                                 \
src/Stack.h                                                            \
src/Gloc.h                         src/BinaryInputOutputPort.h         \
src/Box.h                          src/Port.h                          \
src/BinaryPort.h                   src/OutputPort.h                    \
src/Codec.h                                                            \
src/Transcoder.h                   src/Transcoder.cpp                  \
src/ProcedureMacro.h                                                   \
src/EqvHashTable.h                 src/EqvHashTable.cpp                \
src/Compnum.h                      src/Compnum.cpp                     \
src/Fixnum.h                       src/Fixnum.cpp                      \
src/Closure.h                      src/Closure.cpp                     \
src/UtilityProcedures.h            src/UtilityProcedures.cpp           \
src/ProcessProcedures.h            src/ProcessProcedures.cpp           \
src/Reader.h                       src/Reader.cpp                      \
src/NumberReader.h                 src/NumberReader.cpp                \
src/scheme.h                       src/scheme.cpp                      \
src/Regexp.h                       src/Regexp.cpp                      \
src/Symbol.h                       src/Symbol.cpp                      \
src/VM.h                           src/VM.cpp                          \
src/VM-Profiler.cpp                src/VM-Run.cpp                      \
src/VM-Run.h                       src/Continuation.h                  \
src/Scanner.h                      src/Scanner.cpp                     \
src/NumberScanner.h                src/NumberScanner.cpp               \
src/ByteArrayBinaryInputPort.h     src/ByteArrayBinaryInputPort.cpp    \
src/ByteArrayBinaryOutputPort.h    src/ByteArrayBinaryOutputPort.cpp   \
src/ScannerHelper.h                src/ScannerHelper.cpp               \
src/Reader.tab.hpp                 src/Reader.tab.cpp                  \
src/NumberReader.tab.hpp           src/NumberReader.tab.cpp            \
src/FileBinaryInputPort.h          src/FileBinaryInputPort.cpp         \
src/BufferedFileBinaryInputPort.h  src/BufferedFileBinaryInputPort.cpp \
src/FileBinaryOutputPort.h         src/FileBinaryOutputPort.cpp        \
src/BufferedFileBinaryOutputPort.h src/BufferedFileBinaryOutputPort.cpp\
src/CustomBinaryInputPort.h        src/CustomBinaryInputPort.cpp       \
src/CustomTextualInputPort.h       src/CustomTextualInputPort.cpp      \
src/CustomTextualOutputPort.h      src/CustomTextualOutputPort.cpp     \
src/CustomTextualInputOutputPort.h src/CustomTextualInputOutputPort.cpp\
src/CustomBinaryInputOutputPort.h  src/CustomBinaryInputOutputPort.cpp \
src/TextualOutputPort.h            src/TextualOutputPort.cpp           \
src/TextualInputPort.cpp           src/TextualInputPort.h              \
src/TranscodedTextualInputPort.cpp src/TranscodedTextualInputPort.h    \
src/TranscodedTextualOutputPort.cpp src/TranscodedTextualOutputPort.h  \
src/StringTextualOutputPort.h      src/StringTextualOutputPort.cpp     \
src/StringTextualInputPort.h       src/StringTextualInputPort.cpp      \
src/Codec.cpp                      src/Codec.h                         \
src/UTF8Codec.cpp                  src/UTF8Codec.h                     \
src/UTF16Codec.cpp                 src/UTF16Codec.h                    \
src/UTF32Codec.cpp                 src/UTF32Codec.h                    \
src/EqHashTable.h                  src/EqHashTable.cpp                 \
src/SString.h                      src/SString.cpp                     \
src/GenericHashTable.h             src/GenericHashTable.cpp            \
src/Object.h                       src/Object.cpp                      \
src/CompilerProcedures.cpp         src/CompilerProcedures.h            \
src/HashTableProcedures.cpp        src/HashTableProcedures.h           \
src/RegexpProcedures.cpp           src/RegexpProcedures.h              \
src/StringProcedures.cpp           src/StringProcedures.h              \
src/PortProcedures.cpp             src/PortProcedures.h                \
src/ListProcedures.cpp             src/ListProcedures.h                \
src/ErrorProcedures.cpp            src/ErrorProcedures.h               \
src/ArithmeticProcedures.cpp       src/ArithmeticProcedures.h          \
src/FlonumProcedures.cpp           src/FlonumProcedures.h              \
src/BitwiseProcedures.cpp          src/BitwiseProcedures.h             \
src/ByteVectorProcedures.cpp       src/ByteVectorProcedures.h          \
src/SocketProcedures.cpp           src/SocketProcedures.h              \
src/Equivalent.h                   src/Equivalent.cpp                  \
src/ucs4string.h                   src/ucs4string.cpp                  \
src/Vector.h                       src/Vector.cpp                      \
src/Fasl.h \
src/FaslReader.h                   src/FaslReader.cpp                  \
src/FaslWriter.h                   src/FaslWriter.cpp                  \
src/Arithmetic.h                   src/Arithmetic.cpp                  \
src/Ratnum.h                       src/Ratnum.cpp                      \
src/Bignum.h                       src/Bignum.cpp                      \
src/Flonum.h                       src/Flonum.cpp                      \
src/CodeBuilder.h                  src/CodeBuilder.cpp                 \
src/FixnumProcedures.h             src/FixnumProcedures.cpp            \
src/Latin1Codec.h                  src/Latin1Codec.cpp                 \
src/FFI.h                          src/FFI.cpp                         \
src/FFIProcedures.h                src/FFIProcedures.cpp               \
src/CustomBinaryOutputPort.h       src/CustomBinaryOutputPort.cpp      \
src/FileBinaryInputOutputPort.h    src/FileBinaryInputOutputPort.cpp   \
src/SocketBinaryInputOutputPort.h  src/SocketBinaryInputOutputPort.cpp \
src/TranscodedTextualInputOutputPort.h  src/TranscodedTextualInputOutputPort.cpp   \
src/BufferedFileBinaryInputOutputPort.h  src/BufferedFileBinaryInputOutputPort.cpp \
src/TestingFileBinaryOutputPort.h src/TestingFileBinaryInputPort.h                 \
src/TestingVM.h src/OSConstants.h \
src/getoptU.h src/getoptU.cpp  \
src/StandardOutputPort.h \
src/StandardErrorPort.h \
src/StandardInputPort.h \
src/BlockBufferedFileBinaryOutputPort.h \
src/BlockBufferedFileBinaryInputOutputPort.h \
src/LineBufferedFileBinaryInputOutputPort.h \
src/MultiVMProcedures.h src/MultiVMProcedures.cpp \
src/OSCompatSocket.h src/OSCompatSocket.cpp \
src/OSCompatThread.h src/OSCompatThread.cpp \
src/VMFactory.cpp src/VMFactory.h \
src/SimpleStruct.h \
src/OSCompat.h src/OSCompat.cpp

if FFI_I386
MOSH_CORE_SRCS += src/ffi_stub_i386.S
endif

if FFI_X86_64
MOSH_CORE_SRCS += src/ffi_stub_x86_64.S
endif

noinst_LIBRARIES = libmosh_main.a libnmosh_main.a libmosh_core_for_test.a

# mosh
# -O3 causes miss compile of NumberReader.tab.cpp. (newest gcc?)
# see http://d.hatena.ne.jp/higepon/20081114/1226645373
libmosh_main_a_SOURCES  = src/main.cpp src/psyntax_mosh_image.cpp
mosh_SOURCES = $(MOSH_CORE_SRCS)
mosh_LDADD = libmosh_main.a $(GC_LIB) $(REGEXP_LIB) @MOSH_LDADD_ARCH@
mosh_DEPENDENCIES = @LOCAL_ONIG@ libmosh_main.a

libnmosh_main_a_SOURCES = src/main.cpp src/nmosh_image.cpp
libnmosh_main_a_CXXFLAGS = $(GLOBAL_CFLAGS) -D WITH_NMOSH_DEFAULTS
nmosh_SOURCES = $(MOSH_CORE_SRCS)
nmosh_LDADD = libnmosh_main.a $(GC_LIB) $(REGEXP_LIB) @MOSH_LDADD_ARCH@
nmosh_DEPENDENCIES = @LOCAL_ONIG@ libnmosh_main.a

libmosh_core_for_test_a_SOURCES = $(MOSH_CORE_SRCS)
libmosh_core_for_test_a_DEPENDENCIES = @LOCAL_ONIG@


if MINGW32
nmosh_LDADD += mosh-icon.o
nmosh_DEPENDENCIES += mosh-icon.o
mosh-icon.o : win/mosh.rc misc/logo/mosh.ico
	-mkdir -p $(top_builddir)/misc/logo
	-cp -p $(top_srcdir)/misc/logo/mosh.ico $(top_builddir)/misc/logo
	$(WINDRES) $< -o mosh-icon.o
endif 

if BUILD_LOCAL_ONIG
$(top_builddir)/onig/Makefile:
	mkdir -p onig
	(cd onig && $(top_srcdir)/onig/configure @LOCAL_CONFIGURE_ARGS@ --disable-shared)

local_oniguruma_tree: $(top_builddir)/onig/Makefile

@LOCAL_ONIG@: local_oniguruma_tree
	$(MAKE) -C onig
endif

BUILT_SOURCES = src/Object-accessors.h src/Instruction.h src/Reader.tab.hpp src/NumberReader.tab.hpp src/Reader.tab.cpp src/NumberReader.tab.cpp src/Scanner.cpp src/NumberScanner.cpp src/cprocedures.cpp src/labels.cpp src/OSConstants.h

mosh_core_libraries = \
lib/match.ss \
lib/nmosh.nmosh.ss \
lib/uri.ss \
lib/irregex.ss \
lib/rbtree.ss \
lib/packrat.ss \
lib/json.ss \
lib/memcached.ss \
lib/lambda/wiki.ss    \
lib/shorten/helper.ss \
lib/shorten.ss \
lib/mosh/queue.ss    \
lib/mosh/ffi.ss    \
lib/mosh/dbi.ss    \
lib/mosh/mysql.ss    \
lib/mosh/socket.ss    \
lib/mosh/process.ss \
lib/mosh/shell.ss \
lib/mosh/shell/repl.ss \
lib/mosh/dbd/mysql.ss  \
lib/mosh/test.ss   \
lib/mosh/pp.ss     \
lib/mosh/file.ss     \
lib/mosh/control.ss     \
lib/mosh/concurrent.ss     \
lib/mosh/config.ss \
lib/mosh/cgi.ss  \
lib/clos/core.ss  lib/clos/helpers.ss  lib/clos/introspection.ss  lib/clos/slot-access.ss  lib/clos/user.ss \
lib/clos/bootstrap/generic-functions.ss  lib/clos/bootstrap/standard-classes.ss \
lib/clos/private/allocation.ikarus.ss         lib/clos/private/method-cache.ikarus.ss \
lib/clos/private/allocation.ss                lib/clos/private/method-cache.ss \
lib/clos/private/compat.ss                    \
lib/clos/private/core-class-layout.ss         lib/clos/private/slow-method-cache.ss \
lib/clos/private/top-sort.ss \
lib/clos/private/fast-method-cache.ikarus.ss \
lib/clos/std-protocols/add-method.ss            lib/clos/std-protocols/initialize.ss \
lib/clos/std-protocols/allocate-instance.ss     lib/clos/std-protocols/make.ss \
lib/clos/std-protocols/class-initialization.ss  lib/clos/std-protocols/print-object.ss \
lib/clos/std-protocols/generic-invocation.ss \
lib/srfi/private/include.sls \
lib/srfi/private/include/compat.mosh.sls \
lib/srfi/private/include/compat.nmosh.sls \
lib/srfi/private/registry.sls \
lib/srfi/private/let-opt.sls \
lib/srfi/private/platform-features.mosh.sls \
lib/srfi/private/OS-id-features.sls \
lib/srfi/%3a0.sls \
lib/srfi/%3a0/cond-expand.sls \
lib/srfi/%3a1.sls \
lib/srfi/%3a1/lists.sls \
lib/srfi/%3a2.sls \
lib/srfi/%3a2/and-let%2a.sls \
lib/srfi/%3a6.sls \
lib/srfi/%3a6/basic-string-ports.sls \
lib/srfi/%3a6/basic-string-ports/compat.mosh.sls \
lib/srfi/%3a8.sls \
lib/srfi/%3a8/receive.sls \
lib/srfi/%3a9.sls \
lib/srfi/%3a9/records.sls \
lib/srfi/%3a11.sls \
lib/srfi/%3a11/let-values.sls \
lib/srfi/%3a13.sls \
lib/srfi/13/srfi-13.scm \
lib/srfi/%3a13/strings.sls \
lib/srfi/%3a14.sls \
lib/srfi/%3a14/char-sets.sls \
lib/srfi/14/srfi-14.scm \
lib/srfi/%3a16.sls \
lib/srfi/%3a16/case-lambda.sls \
lib/srfi/%3a19.sls \
lib/srfi/%3a19/time.sls \
lib/srfi/%3a19/time/compat.mosh.sls \
lib/srfi/19/srfi-19.scm \
lib/srfi/%3a23.sls \
lib/srfi/%3a23/error.sls \
lib/srfi/%3a26.sls \
lib/srfi/%3a26/cut.sls \
lib/srfi/26/cut.scm \
lib/srfi/%3a27.sls \
lib/srfi/%3a27/random-bits.sls \
lib/srfi/27/random.ss \
lib/srfi/%3a31.sls \
lib/srfi/%3a31/rec.sls \
lib/srfi/%3a37.sls \
lib/srfi/%3a37/args-fold.sls \
lib/srfi/37/srfi-37-reference.scm \
lib/srfi/%3a38.sls \
lib/srfi/%3a38/with-shared-structure.mosh.sls \
lib/srfi/%3a39.sls \
lib/srfi/%3a39/parameters.mosh.sls \
lib/srfi/%3a41.sls \
lib/srfi/%3a41/streams.sls \
lib/srfi/%3a41/streams/primitive.sls \
lib/srfi/%3a41/streams/derived.sls \
lib/srfi/%3a42.sls \
lib/srfi/%3a42/eager-comprehensions.sls \
lib/srfi/42/ec.scm \
lib/srfi/%3a43.sls \
lib/srfi/%3a43/vectors.sls \
lib/srfi/43/vector-lib.scm \
lib/srfi/%3a48.sls \
lib/srfi/%3a48/intermediate-format-strings.sls \
lib/srfi/%3a48/intermediate-format-strings/compat.mosh.sls \
lib/srfi/%3a61.sls \
lib/srfi/%3a61/cond.sls \
lib/srfi/%3a64.sls \
lib/srfi/%3a64/testing.sls \
lib/srfi/64/testing.scm \
lib/srfi/%3a67.sls \
lib/srfi/%3a67/compare-procedures.sls \
lib/srfi/67/compare.ss \
lib/srfi/%3a78.sls \
lib/srfi/%3a78/lightweight-testing.sls \
lib/srfi/%3a78/lightweight-testing/compat.mosh.sls \
lib/srfi/78/check.scm \
lib/srfi/%3a98.ss \
lib/srfi/%3a98/os-environment-variables.sls\
lib/srfi/%3a99.sls \
lib/srfi/%3a99/records.sls \
lib/srfi/%3a99/records/helper.sls \
lib/srfi/%3a99/records/inspection.sls \
lib/srfi/%3a99/records/procedural.sls \
lib/srfi/%3a99/records/syntactic.sls

#mosh_core_fasl_libraries = $(mosh_core_libraries:.ss=.ss.fasl)

datadir = @MOSH_LIB_PATH@
data_DATA = src/all-tests.scm
nobase_data_DATA = ${mosh_core_libraries} #${mosh_core_fasl_libraries}

INCLUDES       = -I $(top_srcdir)/$(BOEHM_GC_DIR)/include -I$(top_srcdir)/src
EXTRA_DIST     = \
boot/vm.scm boot/baselib boot/compiler.scm \
boot/free-vars.scm misc/scripts boot/baselib/match.scm doc \
boot/free-vars-decl.scm \
boot/runtimes/psyntax-mosh/psyntax.scm \
boot/runtimes/psyntax-mosh/psyntax \
boot/runtimes/psyntax-mosh/Makefile \
boot/runtimes/psyntax-mosh/print-prefix.ss \
boot/runtimes/psyntax-mosh/psyntax-prefix.txt \
doc/mosh.1 doc/mosh_config.1 \
doc/RELNOTE lib src \
test src/call.inc.cpp ${GTEST_DIR} \
win doc README.md misc \
boot/runtimes/srfi-mosh/Makefile \
boot/runtimes/srfi-mosh/README \
boot/runtimes/srfi-mosh/bootstrap.common \
boot/runtimes/srfi-mosh/bootstrap.vanilla-mosh \
boot/runtimes/srfi-mosh/bootstrap.psyntax-mosh \
boot/runtimes/srfi-mosh/build-run.ss \
boot/runtimes/srfi-mosh/compat-mosh-run.scm \
boot/runtimes/srfi-mosh/expander.scm \
boot/runtimes/srfi-mosh/init.ss \
boot/runtimes/srfi-mosh/init5.scm \
boot/runtimes/srfi-mosh/layout.scm \
boot/runtimes/srfi-mosh/lib \
boot/runtimes/srfi-mosh/lib.boot \
boot/runtimes/srfi-mosh/lib.rnrs \
boot/runtimes/srfi-mosh/mosh-exceptions.scm \
boot/runtimes/srfi-mosh/mosh-utils5.scm \
boot/runtimes/srfi-mosh/runtime.scm \
gen-git-build.sh \
CMakeLists.txt cmake

GENERATED = \
src/all-tests.scm src/Scanner.cpp src/NumberScanner.cpp  \
src/DebugInstruction.h src/cprocedures.cpp  src/OSConstants.h src/Object-accessors.h \
src/labels.cpp  src/Instruction.h \
src/match.h \
src/NumberReader.tab.cpp src/NumberReader.tab.hpp \
src/Reader.tab.cpp src/Reader.tab.hpp \
src/nmosh_image.cpp

CLEANFILES = gtest.a gtest_main.a lib/libffitest.so.1.0 src/ffitest.o
MAINTAINERCLEANFILES = $(GENERATED)

#  N.B. We don't use backend's (gensym) for following reasons.
#   (a) When we read serialize libraries, we need all symbols are interned.
#       Because symbols who have same string should be eq?, even when they are loaded from separate files.

#   (b) When we precompile system libraries, we want to control the start index of gensym.
#       Since we should avoid index overlapping between pre-compile libraries and pre-compiled psyntax.
#       So using environment variable MOSH_GENSYM_PREFIX, we control the prefix.

# all fasl should be newer than *.ss and psyntax.h binary
# lib/mosh/queue.ss.mosh-fasl: $(mosh_core_libraries) psyntax.h
# 	(find . -name "*.ss.mosh-fasl" | xargs rm) ; true
# 	(find . -name "*.sls.mosh-fasl" | xargs rm) ; true
# 	MOSH_GENSYM_PREFIX=L ./mosh scripts/pre-compile-r6rs.scm scripts/pre-compile-target.scm

# update: lib/mosh/queue.ss.mosh-fasl

doc:
	mosh misc/scripts/gen-doc-from-r6rs.scm
	perl ~/NaturalDocs-1.4/NaturalDocs -i . -o HTML doc/html -p doc/config -s pink -xi tools

.PHONY: doc test ntest testB testR testL ntestB ntestR ntestL install

bench:
#	@GOSH@ ./misc/scripts/bench.scm > /dev/null
	LANG=C gosh ./misc/scripts/bench2.scm

include Generate.mk

#### test
check: test ntest

#FIXME: use macro
MOSHBIN ="MOSH_LOADPATH=$(abs_top_srcdir)/lib $(abs_builddir)/mosh $(MOSH_TESTARGS)"
NMOSHBIN ="NMOSH_CACHEDIR=$(abs_builddir)/nmosh-cache MOSH_LOADPATH=$(abs_top_srcdir)/lib $(abs_builddir)/nmosh $(MOSH_TESTARGS)"

test: testB testR testL
ntest: ntestB ntestR ntestL

testB: lib/libffitest.so.1.0 ./mosh src/all-tests.scm
	(MOSH_TARGET=$(MOSHBIN) $(MAKE) -C $(top_srcdir) -f test/Makefile runtest)
	(MOSH_TARGET=$(MOSHBIN) MOSH_BUILDDIR=$(abs_top_builddir) MOSH_SRCDIR=$(abs_top_srcdir) $(MAKE) -C $(top_srcdir) -f test/Makefile runtest-ffi)
	(MOSH_TARGET=$(MOSHBIN) $(MAKE) -C $(top_srcdir) -f test/Makefile runtest-mosh)

testL:
	(MOSH_TARGET=$(MOSHBIN) $(MAKE) -C $(top_srcdir)/test/irregex)

testR:
	(MOSH_TARGET=$(MOSHBIN) $(MAKE) -C $(top_srcdir)/test/r6rs-test-suite)

#check-am is Automake's internal target..
testU: check-am

ntestB: lib/libffitest.so.1.0 ./nmosh src/all-tests.scm
	(MOSH_TARGET=$(NMOSHBIN) $(MAKE) -C $(top_srcdir) -f test/Makefile runtest)
	(MOSH_TARGET=$(NMOSHBIN) MOSH_BUILDDIR=$(abs_top_builddir) MOSH_SRCDIR=$(abs_top_srcdir) $(MAKE) -C $(top_srcdir) -f test/Makefile runtest-ffi)
	(MOSH_TARGET=$(NMOSHBIN) $(MAKE) -C $(top_srcdir) -f test/Makefile runtest-nmosh)

ntestL:
	(MOSH_TARGET=$(NMOSHBIN) $(MAKE) -C $(top_srcdir)/test/irregex)

ntestR:
	(MOSH_TARGET=$(NMOSHBIN) $(MAKE) -C $(top_srcdir)/test/r6rs-test-suite)

# Builds gtest.a and gtest_main.a.

GTEST_CPPFLAGS_ = -I$(GTEST_DIR)

# For simplicity and to avoid depending on Google Test's
# implementation details, the dependencies specified below are
# conservative and not optimized.  This is fine as Google Test
# compiles fast and for ordinary users its source rarely changes.
gtest-all.o : $(GTEST_DIR)/gtest/gtest-all.cc
	$(CXX) $(GTEST_CPPFLAGS_) $(CXXFLAGS) -o $@ -c $<

gtest_main.o : $(GTEST_DIR)/gtest/gtest_main.cc
	$(CXX) $(GTEST_CPPFLAGS_) $(CXXFLAGS) -o $@ -c $<

gtest.a : gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^
	$(RANLIB) $@

check_PROGRAMS=
TEST_CXXFLAGS_     = $(GLOBAL_CFLAGS) -I$(GTEST_DIR) -I$(GTEST_DIR)/gtest -DGTEST_HAS_CLONE=0 
TEST_LDADD_        = libmosh_core_for_test.a gtest_main.a $(GC_LIB) $(REGEXP_LIB)  @MOSH_LDADD_ARCH@
TEST_DEPENDENCIES_ = libmosh_core_for_test.a gtest_main.a

TESTS += test_object
check_PROGRAMS += test_object
test_object_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_object_CXXFLAGS = $(TEST_CXXFLAGS_)
test_object_SOURCES = src/ObjectTest.cpp src/TestingSignalHandler.cpp src/psyntax_mosh_image.cpp
test_object_LDADD = $(TEST_LDADD_)

TESTS += test_vm
check_PROGRAMS += test_vm
test_vm_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_vm_CXXFLAGS = $(TEST_CXXFLAGS_)
test_vm_SOURCES = src/VMTest.cpp src/TestingVM.cpp src/TestingSignalHandler.cpp src/psyntax_mosh_image.cpp
test_vm_LDADD = $(TEST_LDADD_)

TESTS += test_port
check_PROGRAMS += test_port
test_port_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_port_CXXFLAGS = $(TEST_CXXFLAGS_)
test_port_SOURCES = src/PortTest.cpp src/TestingSignalHandler.cpp src/psyntax_mosh_image.cpp
test_port_LDADD = $(TEST_LDADD_)

TESTS += test_fasl
check_PROGRAMS += test_fasl
test_fasl_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_fasl_CXXFLAGS = $(TEST_CXXFLAGS_)
test_fasl_SOURCES = src/FaslTest.cpp src/TestingSignalHandler.cpp src/TestingVM.cpp src/psyntax_mosh_image.cpp
test_fasl_LDADD = $(TEST_LDADD_)

TESTS += test_ffi
check_PROGRAMS += test_ffi
test_ffi_DEPENDENCIES = $(TEST_DEPENDENCIES_) lib/libffitest.so.1.0
test_ffi_CXXFLAGS = $(TEST_CXXFLAGS_)
test_ffi_SOURCES = src/FFITest.cpp src/TestingSignalHandler.cpp src/TestingVM.cpp src/psyntax_mosh_image.cpp
test_ffi_LDADD = $(TEST_LDADD_)

TESTS += test_compat
check_PROGRAMS += test_compat
test_compat_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_compat_CXXFLAGS = $(TEST_CXXFLAGS_)
test_compat_SOURCES = src/OSCompatTest.cpp src/TestingSignalHandler.cpp src/psyntax_mosh_image.cpp
test_compat_LDADD = $(TEST_LDADD_)

TESTS += test_getopt
check_PROGRAMS += test_getopt
test_getopt_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_getopt_CXXFLAGS = $(TEST_CXXFLAGS_)
test_getopt_SOURCES = src/getoptUTest.cpp src/TestingSignalHandler.cpp src/psyntax_mosh_image.cpp
test_getopt_LDADD = $(TEST_LDADD_)

TESTS += test_thread
check_PROGRAMS += test_thread
test_thread_DEPENDENCIES = $(TEST_DEPENDENCIES_)
test_thread_CXXFLAGS = $(TEST_CXXFLAGS_)
test_thread_SOURCES = src/OSCompatThreadTest.cpp src/TestingSignalHandler.cpp src/psyntax_mosh_image.cpp
test_thread_LDADD = $(TEST_LDADD_)

if PSYNTAX_MOSH_POSTINSTALL
install-data-hook :
	./mosh --clean-acc --disable-acc $(top_srcdir)/misc/empty.scm
	$(INSTALL) -m 666 $(top_srcdir)/misc/dotmosh/prefix.txt `./mosh --clean-acc --disable-acc ./src/mosh_config mosh-cache-dir`
	MOSH_LOADPATH=${DESTDIR}${datadir}/lib ./mosh $(top_srcdir)/misc/scripts/pre-compile-target.scm
#	MOSH_GENSYM_PREFIX=I MOSH_LOADPATH=${DESTDIR}${datadir}/lib ./mosh ./misc/scripts/pre-compile-r6rs.scm ./misc/scripts/pre-compile-target.scm
#	MOSH_GENSYM_PREFIX=I MOSH_LOADPATH=${DESTDIR}${datadir}/lib $(DESTDIR)/@bindir@/mosh ./misc/scripts/pre-compile-r6rs.scm ./misc/scripts/pre-compile-target.scm
endif

dist-hook:
	-rm -f $(top_distdir)/lib/libffitest.so.1.0
	-rm -f $(top_distdir)/src/config.h

# for FFI test
lib/libffitest.so.1.0: src/ffitest.c
	$(CC) -g -std=c99 -Wall -fPIC -c $< -o src/ffitest.o
	$(CC) -g -Wl @SHLIB_SO_LDFLAGS@ -o $@ src/ffitest.o

# for flymake
check-syntax:
	$(CXX) -o nul $(GLOBAL_CFLAGS) $(INCLUDES) $(DEFAULT_INCLUDES) -DHAVE_CONFIG_H -S ${CHK_SOURCES}
