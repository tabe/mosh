/*
 * FlonumProcedures.cpp - 
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
 *  $Id: FlonumProcedures.cpp 183 2008-07-04 06:19:28Z higepon $
 */

#include "Object.h"
#include "Object-inl.h"
#include "SString.h"
#include "FlonumProcedures.h"
#include "ProcedureMacro.h"
#include "ErrorProcedures.h"
#include "Arithmetic.h"
#include "Ratnum.h"
#include "Fixnum.h"
#include "Flonum.h"
#include "Bignum.h"

using namespace scheme;

Object scheme::flAddEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl+");
    if (0 == argc) {
        return Object::makeFlonum(0.0);
    } else if (1 == argc) {
        argumentCheckFlonum(0, number);
        return number;
    }

    Object ret = Object::makeFlonum(0.0);
    for (int i = 0; i < argc; i++) {
        argumentAsFlonum(i, flonum);
        ret = Flonum::add(ret.toFlonum(), flonum);
    }
    return ret;
}

Object scheme::flMulEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl*");
    if (0 == argc) {
        return Object::makeFlonum(1.0);
    } else if (1 == argc) {
        argumentCheckFlonum(0, number);
        return number;
    }

    Object ret = Object::makeFlonum(1.0);
    for (int i = 0; i < argc; i++) {
        argumentAsFlonum(i, flonum);
        ret = Flonum::mul(ret.toFlonum(), flonum);
    }
    return ret;
}

Object scheme::flSubEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl-");
    checkArgumentLengthAtLeast(1);

    if (1 == argc) {
        argumentAsFlonum(0, number);
        return Object::makeFlonum(-1 * number->value());
    }

    argumentCheckFlonum(0, dummy);
    Object ret = argv[0];
    for (int i = 1; i < argc; i++) {
        argumentAsFlonum(i, flonum);
        ret = Flonum::sub(ret.toFlonum(), flonum);
    }
    return ret;
}

Object scheme::flDivEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl/");
    checkArgumentLengthAtLeast(1);

    if (1 == argc) {
        argumentCheckFlonum(0, number);
        return Arithmetic::div(Object::makeFlonum(1.0), number);
    }

    argumentCheckFlonum(0, dummy);
    Object ret = argv[0];
    for (int i = 1; i < argc; i++) {
        argumentAsFlonum(i, flonum);
        ret = Flonum::div(ret.toFlonum(), flonum);
    }
    return ret;
}

Object scheme::flmaxEx(int argc, const Object* argv)
{
    DeclareProcedureName("flmax");
    checkArgumentLengthAtLeast(1);
    Object maxFlonum = Flonum::NEGATIVE_INF;
    for (int i = 0; i < argc; i++) {
        argumentAsFlonum(i, flonum);
        if (flonum->isNan()) {
            return Flonum::NOT_A_NUMBER;
        }
        if (Flonum::gt(flonum, maxFlonum.toFlonum())) {
            maxFlonum = argv[i];
        }
    }
    return maxFlonum;
}

Object scheme::flminEx(int argc, const Object* argv)
{
    DeclareProcedureName("flmin");
    checkArgumentLengthAtLeast(1);
    Object minFlonum = Flonum::POSITIVE_INF;
    for (int i = 0; i < argc; i++) {
        argumentAsFlonum(i, flonum);
        if (flonum->isNan()) {
            return Flonum::NOT_A_NUMBER;
        }
        if (Flonum::lt(flonum, minFlonum.toFlonum())) {
            minFlonum = argv[i];
        }
    }
    return minFlonum;
}

Object scheme::flnanPEx(int argc, const Object* argv)
{
    DeclareProcedureName("flnan?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(flonum->isNan());
}

Object scheme::flinfinitePEx(int argc, const Object* argv)
{
    DeclareProcedureName("flinfinite?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(flonum->isInfinite());
}

Object scheme::flfinitePEx(int argc, const Object* argv)
{
    DeclareProcedureName("flfinite?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(!flonum->isInfinite());
}

Object scheme::flevenPEx(int argc, const Object* argv)
{
    DeclareProcedureName("fleven?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    if (flonum->isInteger()) {
        return Object::makeBool(flonum->isEven());
    } else {
        callWrongTypeOfArgumentViolationAfter(procedureName, "integer flonum", argv[0]);
        return Object::Undef;
    }
}

Object scheme::floddPEx(int argc, const Object* argv)
{
    DeclareProcedureName("flodd?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    if (flonum->isInteger()) {
        return Object::makeBool(flonum->isOdd());
    } else {
        callWrongTypeOfArgumentViolationAfter(procedureName, "integer flonum", argv[0]);
        return Object::Undef;
    }
}

Object scheme::flnegativePEx(int argc, const Object* argv)
{
    DeclareProcedureName("flpositive?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(Flonum::lt(flonum, 0));
}

Object scheme::flpositivePEx(int argc, const Object* argv)
{
    DeclareProcedureName("flpositive?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(Flonum::gt(flonum, 0));
}

Object scheme::flzeroPEx(int argc, const Object* argv)
{
    DeclareProcedureName("flzero?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(Flonum::eq(flonum, 0));
}

Object scheme::flintegerPEx(int argc, const Object* argv)
{
    DeclareProcedureName("flinteger?");
    checkArgumentLength(1);
    argumentAsFlonum(0, flonum);
    return Object::makeBool(flonum->isInteger());
}

Object scheme::flLePEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl<=?");
    checkArgumentLengthAtLeast(2);
    for (int i = 0; i < argc - 1; i++) {
        argumentAsFlonum(i, n1);
        argumentAsFlonum(i + 1, n2);
        if (Flonum::le(n1, n2)) {
            continue;
        } else {
            return Object::False;
        }
    }
    return Object::True;
}

Object scheme::flGePEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl>=?");
    checkArgumentLengthAtLeast(2);
    for (int i = 0; i < argc - 1; i++) {
        argumentAsFlonum(i, n1);
        argumentAsFlonum(i + 1, n2);
        if (Flonum::ge(n1, n2)) {
            continue;
        } else {
            return Object::False;
        }
    }
    return Object::True;
}

Object scheme::flGtPEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl>?");
    checkArgumentLengthAtLeast(2);
    for (int i = 0; i < argc - 1; i++) {
        argumentAsFlonum(i, n1);
        argumentAsFlonum(i + 1, n2);
        if (Flonum::gt(n1, n2)) {
            continue;
        } else {
            return Object::False;
        }
    }
    return Object::True;
}

Object scheme::flLtPEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl<?");
    checkArgumentLengthAtLeast(2);
    for (int i = 0; i < argc - 1; i++) {
        argumentAsFlonum(i, n1);
        argumentAsFlonum(i + 1, n2);
        if (Flonum::lt(n1, n2)) {
            continue;
        } else {
            return Object::False;
        }
    }
    return Object::True;
}

Object scheme::flEqPEx(int argc, const Object* argv)
{
    DeclareProcedureName("fl=?");
    checkArgumentLengthAtLeast(2);
    for (int i = 0; i < argc - 1; i++) {
        argumentAsFlonum(i, n1);
        argumentAsFlonum(i + 1, n2);
        if (Flonum::eq(n1, n2)) {
            continue;
        } else {
            return Object::False;
        }
    }
    return Object::True;
}

Object scheme::realToflonumEx(int argc, const Object* argv)
{
    DeclareProcedureName("real->flonum");
    checkArgumentLength(1);
    argumentCheckReal(0, real);
    return Arithmetic::toFlonum(real);
}
