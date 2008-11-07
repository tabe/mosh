; library.scm - main library
;
;   Copyright (c) 2008  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
;
;   Redistribution and use in source and binary forms, with or without
;   modification, are permitted provided that the following conditions
;   are met:
;
;   1. Redistributions of source code must retain the above copyright
;      notice, this list of conditions and the following disclaimer.
;
;   2. Redistributions in binary form must reproduce the above copyright
;      notice, this list of conditions and the following disclaimer in the
;      documentation and/or other materials provided with the distribution.
;
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;
;  $Id$

; document is written at manual.scm
(define-macro (acond . clauses)
  (if (null? clauses)
      '()
      (let ((cl1 (car clauses))
            (sym (gensym)))
        `(let ((,sym ,(car cl1)))
           (if ,sym
               (let ((it ,sym)) ,@(cdr cl1))
               (acond ,@(cdr clauses)))))))

(define-macro (define-doc . more)
  '())

; ==============================================================================================================================================================
;;; Base library.
;;; R6RS chapter 11.

;; <p>The eqv? procedure defines a useful equivalence relation on objects.
;; <p>Briefly, it returns #t if obj1 and obj2 should normally be regarded as the same object and #f otherwise.</p>
;; <p>The eqv? procedure returns #t if one of the following holds:</p>
;; <p>Obj1 and obj2 are both booleans and are the same according to the boolean=? procedure.</p>
;; <p>Obj1 and obj2 are both symbols and are the same according to the symbol=? procedure.</p>
;; <p>Obj1 and obj2 are both exactnumber objects and are numerically equal.</p>
;; <p>Obj1 and obj2 are both inexactnumber objects, are numerically equal, and yield the same results (in the sense of eqv?) when passed as arguments to any other procedure that can be defined as a finite composition of Scheme's standard arithmetic procedures.</p>
;; <p>Obj1 and obj2 are both characters and are the same character according to the char=? procedure .</p>
;; <p>Both obj1 and obj2 are the empty list.</p>
;; <p>Obj1 and obj2 are objects such as pairs, vectors, bytevectors , strings, hashtables, records, ports, or hashtables  that refer to the same locations in the store.</p>
;; <p>Obj1 and obj2 are record-type descriptors that are specified to be eqv? in library.</p>
;; <p>The eqv? procedure returns #f if one of the following holds:</p>
;; <p>Obj1 and obj2 are of different types.</p>
;; <p>Obj1 and obj2 are booleans for which the boolean=? procedure returns #f.</p>
;; <p>Obj1 and obj2 are symbols for which the symbol=? procedure returns #f.</p>
;; <p>One of obj1 and obj2 is an exact number object but the other is an inexact number object.</p>
;; <p>Obj1 and obj2 are rational number objects for which the = procedure returns #f.</p>
;; <p>Obj1 and obj2 yield different results (in the sense of eqv?) when passed as arguments to any other procedure that can be defined as a finite composition of Scheme's standard arithmetic procedures.</p>
;; <p>Obj1 and obj2 are characters for which the char=? procedure returns #f.</p>
;; <p>One of obj1 and obj2 is the empty list, but the other is not.</p>
;; <p>Obj1 and obj2 are objects such as pairs, vectors, bytevectors (library chapter on "Bytevectors"), strings, records (library chapter on "Records"), ports, or hashtables that refer to distinct locations.</p>
;; <p>Obj1 and obj2 are pairs, vectors, strings, or records, or hashtables, where the applying the same accessor (i.e. car, cdr, vector-ref, string-ref, or record accessors) to both yields results for which eqv? returns #f.</p>
;; <p>Obj1 and obj2 are procedures that would behave differently (return different values or have different side effects) for some arguments.</p>
;; .form (eqv? obj1 obj2)
;; .returns #t if equal
;; .example (eqv? 'a 'a)                             =>  #t
;; .example (eqv? 'a 'b)                             =>  #f
;; .example (eqv? 2 2)                               =>  #t
;; .example (eqv? '() '())                           =>  #t
;; .example (eqv? 100000000 100000000)               =>  #t
;; .example (eqv? (cons 1 2) (cons 1 2))             =>  #f
;; .example (eqv? (lambda () 1)
;;                (lambda () 2))                    =>  #f
;; .example (eqv? #f 'nil)                          =>  #f
(define-doc (eqv?) ...)

;; Returns#t if obj is integer, otherwise #f.
;; .returns #t if obj is integer, otherwise #f.
;; .form (integer? obj)
(define integer? number?)

;; Impose a total ordering on the set of characters according to their Unicode scalar values.
;; .form (char>=? char1 char2 char3 ...)
(define-doc (char>=?) ...)

;; Impose a total ordering on the set of characters according to their Unicode scalar values.
;; .form (char>? char1 char2 char3 ...)
(define-doc (char>?) ...)

;; Impose a total ordering on the set of characters according to their Unicode scalar values.
;; .form (char<=? char1 char2 char3 ...)
(define-doc (char<=?) ...)

;; Impose a total ordering on the set of characters according to their Unicode scalar values.
;; .form (char<? char1 char2 char3 ...)
(define-doc (char<?) ...)


;; Returns #t if obj is a procedure, otherwise returns #f.
;; .form (procedure? obj)
;; .returns #t if obj is a procedure, otherwise returns #f.
;; .example (procedure? car)                    =>  #t
;; .example (procedure? 'car)                   =>  #f
;; .example (procedure? (lambda (x) (* x x)))   =>  #t
;; .example (procedure? '(lambda (x) (* x x)))  =>  #f
(define-doc (procedure?) ...)

;; A lambda expression evaluates to a procedure.
;; <p>The environment in effect when the lambda expression is evaluated is remembered as part of the procedure.</p>
;; <p>When the procedure is later called with some arguments, the environment in which the lambda expression was evaluated is extended by binding the variables in the parameter list to fresh locations, and the resulting argument values are stored in those locations.</p>
;; <p>Then, the expressions in the body of the lambda expression are evaluated sequentially in the extended environment. The results of the last expression in the body are returned as the results of the procedure call.</p>
;; .form (lambda [formals] [body])
;; .returns A procedure
(define-doc (lambda) ...)

;; Quasiquote
;; .form (quasiquote [qq template])
;; .reference "Quasiquote" "quasiquote" "http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-14.html#node_idx_768"
(define-doc (quasiquote) ...)

;; Evaluates to the datum value represented by [datum].
;; .form (quote [datum])
;; .returns quoted object
(define-doc (quote) ...)

;; <p>An if expression is evaluated as follows: first, [test] is evaluated.</p>
;; <p>If it yields a true value, then [consequent] is evaluated and its values are returned.Otherwise <alternate> is evaluated and its values are returned.</p>
;; <p>If <test> yields #f and no [alternate] is specified, then the result of the expression is unspecified.</p>
;; .form (if [test] [consequent] [alternate]) (if [test] [consequent])
(define-doc (if) ...)

;; Returns character k of string using zero-origin indexing.
;; .returns character k of string using zero-origin indexing.
;; .form (string-ref string k)
;; .pre-condition k of string using zero-origin indexing.
(define-doc (string-ref) ...)

;; Returns #t if obj is a list, #f otherwise. By definition, all lists are chains of pairs that have finite length and are terminated by the empty list.
;; .form (list? obj)
;; .returns #t if obj is a list, #f otherwise.
;; .example (list? '(a b c)) => #t
;; .example (list? '()) => #t
;; .example (list? '(a . b)) => #f
(define-doc (list?) ...)

;; <p>(let [bindings] [body])</p>
;; <p>Syntax: [Bindings] must have the form</p>
;; <p>  (([variable1] [init1]) ...),</p>
;; <p>where each [init] is an expression.</p>
;; <p>Any variable must not appear more than once in the [variable]s.</p>
;; .form (let [bindings] [body])
;; .example (let ((x 2) (y 3))\
;;            (* x y)) =>  6
;; .example (let ((x 2) (y 3))\
;;            (let ((x 7)\
;;              (z (+ x y)))\
;;                (* z x)))  => 35
(define-doc (let) ...)

;; <p>(let* [bindings] [body])</p>
;; <p>Syntax: [Bindings] must have the form</p>
;; <p>(([variable1] [init1]) ...),</p>
;; <p>Semantics: The let* form is similar to let, but the [init]s are evaluated and bindings created sequentially from left to right, with the regionof each binding including the bindings to its right as well as [body].</p>
;; <p>Thus the second [init] is evaluated in an environment in which the first binding is visible and initialized, and so on.</p>
;; .form (let* [bindings] [body])
;; .example (let ((x 2) (y 3))\
;;            (let* ((x 7)\
;;                  (z (+ x y)))\
;;                    (* z x))) =>70
(define-doc (let*) ...)

;; <p>(letrec [bindings] [body])</p>
;; <p>Syntax: [Bindings] must have the form</p>
;; <p>(([variable1] [init1]) ...),</p>
;; <p>Any variable must not appear more than once in the [variable]s.</p>
;; <p>Semantics: The [variable]s are bound to fresh locations, the [init]s are evaluated in the resulting environment (in some unspecified order), each [variable] is assigned to the result of the corresponding [init], the [body] is evaluated in the resulting environment, and the values of the last expression in <body> are returned.</p>
;; <p>Each binding of a [variable] has the entire letrec expression as its region, making it possible to define mutually recursive procedures.</p>
;; .form (letrec [bindings] [body])
(define-doc (letrec) ...)

;; Returns #t if obj is #f, and returns #f otherwise.
;; .form (not obj)
;; .returns #t if obj is #f, and returns #f otherwise.
;; .example (not #t)           =>  #f
;; .example (not 3)            =>  #f
;; .example (not (list 3))     =>  #f
;; .example (not #f)           =>  #t
;; .example (not '())          =>  #f
;; .example (not (list))       =>  #f
;; .example (not 'nil)         =>  #f
(define (not x) (if x #f #t))

;; If there are no [test]s, #f is returned. Otherwise, the [test] expressions are evaluated from left to right until a [test] returns a true value val or the last [test] is reached.
;; <p>In the former case, the or expression returns val without evaluating the remaining expressions.
;; In the latter case, the last expression is evaluated and its values are returned.</p>
;; .form (or [test1] ...)
;; .example (or (= 2 2) (> 2 1))                    =>  #t
;; .example (or (= 2 2) (< 2 1))                    =>  #t
;; .example (or #f #f #f)                           =>  #f
;; .example (or '(b c) (/ 3 0))                     =>  (b c)
(define-doc (or) ...)

;; <p>[Expression] is evaluated, and the resulting value is stored in the location to which [variable] is bound. </p><p>[Variable] must be bound either in some regionenclosing the set! expression or at the top level.</p>
;; .form (set! [variable] [expression])
;; .returns unspecified
(define-doc (set!) ...)

;; Returns #t if obj is a symbol, otherwise returns #f.
;; .form (symbol? obj)
;; .returns #t if obj is a symbol, otherwise returns #f.
(define-doc (symbol?) ...)

;; Returns the number of elements in vector as an exact integer object.
;; .form (vector-length vector)
;; .returns The number of elements in vector as an exact integer object.
(define-doc (vector-length) ...)

;; Returns the contents of elementk of vector.
;; .pre-condition K must be a valid index of vector.
;; .form (vector-ref vector k)
;; .returns The contents of elementk of vector.
;; .example (vector-ref '#(1 1 2 3 5 8 13 21) 5) =>  8
(define-doc (vector-ref) ...)

;; stores obj in element k of vector, and returns unspecified values.
;; .pre-condition K must be a valid index of vector.
;; .form (vector-set! vector k obj)
;; .returns unspecified
;; .example <pre>(let ((vec (vector 0 '(2 2 2 2) "Anna")))\
;;                    (vector-set! vec 1 '("Sue" "Sue"))\
;;                    vec)\
;;                =>  #(0 ("Sue" "Sue") "Anna")</pre>
(define-doc (vector-set!) ...)

;; If there are no [test]s, #t is returned. Otherwise, the [test] expressions are evaluated from left to right until a [test] returns #f or the last [test] is reached.
;; <p>In the former case, the and expression returns #f without evaluating the remaining expressions.
;; In the latter case, the last expression is evaluated and its values are returned.</p>
;; .form (and [test1] ...)
(define-doc (and) ...)


;; The apply procedure calls proc with the elements of the list (append (list arg1 ...) rest-args) as the actual arguments.
;; .pre-condition Rest-args must be a list. Proc should accept n arguments, where n is number of args plus the length of rest-args.
;; .form (apply proc arg1 ... rest-args)
;; .returns The apply procedure calls proc with the elements of the list (append (list arg1 ...) rest-args) as the actual arguments.
(define-doc (apply) ...)

;; <p>The [begin] keyword has two different roles, depending on its context:</p>
;; <p>It may appear as a form in a [body] , [library body] , or [top-level body], or directly nested in a begin form that appears in a body.
;; In this case, the begin form must have the shape specified in the first header line.</p>
;; <p>This use of begin acts as a splicing form the forms inside the [body] are spliced into the surrounding body, as if the begin wrapper were not actually present.</p>
;; <p>A begin form in a [body] or [library body] must be non-empty if it appears after the first [expression] within the body.
;; It may appear as an ordinary expression and must have the shape specified in the second header line.</p>
;; <p>In this case, the [expression]s are evaluated sequentially from left to right, and the values of the last [expression] are returned.
;; This expression type is used to sequence side effects such as assignments or input and output.</p>
;; .form (begin [form] ...) (begin [expression] [expression] ...)
(define-doc (begin) ...)

;; <p>The procedure call-with-current-continuation (which is the same as the procedure call/cc) packages the current continuation as an "escape procedure"and passes it as an argument to proc.</p>
;; <p>The escape procedure is a Scheme procedure that, if it is later called, will abandon whatever continuation is in effect at that later time and will instead reinstate the continuation that was in effect when the escape procedure was created.</p>
;; .form (call-with-current-continuation proc)
(define-doc (call-with-current-continuation) ...)

;; <p>case expression is evaluated as follows.</p>
;; <p>[Key] is evaluated and its result is compared using eqv? against the data represented by the [datum]s of each [case clause] in turn, proceeding in order from left to right through the set of clauses.</p>
;; <p>If the result of evaluating [key] is equivalent to a datum of a [case clause], the corresponding [expression]s are evaluated from left to right and the results of the last expression in the [case clause] are returned as the results of the case expression. Otherwise, the comparison process continues.</p>
;; <p>If the result of evaluating [key] is different from every datum in each set, then if there is an else clause its expressions are evaluated and the results of the last are the results of the case expression; otherwise the case expression returns unspecified values.</p>
;; .form (case [key] [case clause1] [case clause2] ...)
;; .example <pre>(case (* 2 3)\
;;                  ((2 3 5 7) 'prime)\
;;                  ((1 4 6 8 9) 'composite))  =>  composite</pre>
(define-doc (case) ...)

;; <p>A cond expression is evaluated by evaluating the [test] expressions of successive [cond clause]s in order until one of them evaluates to a true value.</p>
;; <p>When a [test] evaluates to a true value, then the remaining [expression]s in its [cond clause] are evaluated in order, and the results of the last [expression] in the [cond clause] are returned as the results of the entire cond expression.</p>
;; <p>If the selected [cond clause] contains only the [test] and no [expression]s, then the value of the [test] is returned as the result.
;; If the selected [cond clause] uses the => alternate form, then the [expression] is evaluated. Its value must be a procedure.</p>
;; <p>This procedure should accept one argument; it is called on the value of the [test] and the values returned by this procedure are returned by the cond expression.</p>
;; <p>If all [test]s evaluate to #f, and there is no else clause, then the conditional expression returns unspecified values; if there is an else clause, then its [expression]s are evaluated, and the values of the last one are returned.</p>
;; .form (cond [cond clause1] [cond clause2] ...)
;; .example <pre>(cond ((> 3 2) 'greater)\
;;                 ((< 3 2) 'less)) =>  greater</pre>
;; .example <pre>(cond ((> 3 3) 'greater)\
;;                 ((< 3 3) 'less)\
;;                 (else 'equal))   =>  equal</pre>
;; .example <pre>(cond ('(1 2 3) => cadr)\
;;                 (else #f))       =>  2</pre>
(define-doc (cond) ...)

;; The define form is used to create variable bindings and may appear anywhere other definitions may appear.
;; .form (define [variable] [expression]) (define [variable]) (define ([variable] [formals]) [body]) (define ([variable] . [formal]) [body])
(define-doc (define) ...)

;; The define-macro form is used to create traditional macro.
;; .form (define-macro (name . args) body)
(define-doc (define-macro) ...)

;; Returns the product of their arguments.
;; .form (* z1 ...)
;; .returns The product of their arguments.
(define-doc (*) ...)

;; Returns the sum of their arguments.
;; .form (+ z1 ...)
;; .returns The sum of their arguments.
(define-doc (+) ...)

;; Returns the division of their arguments.
;; .form (/ z1 ...)
;; .returns The division of their arguments.
(define-doc (/) ...)

;; Returns the modulo of their arguments.
;; .form (mod z1 z2)
;; .returns The modulo of their arguments.
(define-doc (mode) ...)

;; With two or more arguments, this procedures returns the difference of its arguments, associating to the left. With one argument, however, it returns the additive inverse of its argument.
;; .form (- z1 z2 ...) (- z)
;; .returns With two or more arguments, this procedures returns the difference of its arguments, associating to the left. With one argument, however, it returns the additive inverse of its argument.
(define-doc (-) ...)

;; Returns #t if its arguments are monotonically increasing and #f otherwise.
;; .form (< x1 x2 x3 ...)
;; .returns #t if its arguments are monotonically increasing and #f otherwise.
(define-doc (<) ...)

;; Returns #t if its arguments are monotonically nondecreasing and #f otherwise.
;; .form (<= x1 x2 x3 ...)
;; .returns #t if its arguments are monotonically nondecreasing and #f otherwise.
(define-doc (<=) ...)

;; Returns #t if its arguments are equal and #f otherwise.
;; .form (= x1 x2 x3 ...)
;; .returns #t if its arguments are equal and #f otherwise.
(define-doc (=) ...)

;; Returns #t if its arguments are monotonically decreasing and #f otherwise.
;; .form (> x1 x2 x3 ...)
;; .returns #t if its arguments are monotonically decreasing and #f otherwise.
(define-doc (>) ...)

;; Returns #t if its arguments are monotonically increasing and #f otherwise.
;; .form (> x1 x2 x3 ...)
;; .returns #t if its arguments are monotonically increasing and #f otherwise.
(define-doc (>=) ...)

;; Returns a newly allocated vector whose elements contain the given arguments. Analogous to list.
;; .form (vector obj ...)
;; .returns A newly allocated vector whose elements contain the given arguments. Analogous to list.
(define-doc (vector) ...)

;; Returns #t if obj is a pair, and otherwise returns #f.
;; .form (pair? obj)
;; .returns #t if obj is a pair, and otherwise returns #f.
(define-doc (pair?) ...)

;; Delivers all of its arguments to its continuation.
;; .form (values obj ...)
;; .returns Delivers all of its arguments to its continuation.
;; .internal-references "Base Library" "call-with-values"
(define-doc (values) ...)

;; This error procedure will be replaced with R6RS (error)
;; .form (error message)
;; .returns This error procedure will be replaced with R6RS (error)
(define-doc (error) ...)

;; Returns the name of symbol as an immutable string.
;; .form (symbol->string symbol)
;; .returns Returns the name of symbol as an immutable string.
(define-doc (symbol->string) ...)

;; Returns #t if obj is either #t or #f and returns #f otherwise.
;; .form (boolean? obj)
;; .returns #t if obj is either #t or #f and returns #f otherwise.
(define-doc (boolean?) ...)

;; <p>The eq? predicate is similar to eqv? except that in some cases it is capable of discerning distinctions finer than those detectable by eqv?.</p>
;; <p>The eq? and eqv? predicates are guaranteed to have the same behavior on symbols, booleans, the empty list, pairs, procedures, non-empty strings, bytevectors, and vectors, and records.</p>
;; .returns #t if eq?
;; .example (eq? 'a 'a) =>  #t
;; .example (eq? '(a) '(a))                         =>  #f (unspecified on R6RS)
;; .example (eq? (list 'a) (list 'a))               =>  #f
;; .example (eq? "a" "a")                           =>  #f (unspecified on R6RS)
;; .example (eq? "" "")                             =>  #f (unspecified on R6RS)
;; .example (eq? '() '())                           =>  #t
;; .example (eq? 2 2)                               =>  #t (unspecified on R6RS)
;; .example (eq? #\A #\A)                           =>  #t (unspecified on R6RS)
;; .example (eq? car car)                           =>  #t
;; .example <pre>(let ((n (+ 2 3)))\
;;                 (eq? n n))                       =>  #t (unspecified on R6RS)</pre>
;; .example <pre>(let ((x '(a)))\
;;                 (eq? x x))                       =>  #t (unspecified on R6RS)</pre>
;; .example <pre>(let ((x '#()))\
;;                  (eq? x x))                      =>  #t (unspecified on R6RS)</pre>
;; .example <pre>(let ((p (lambda (x) x)))\
;;                 (eq? p p))                       =>  #t (unspecified on R6RS)</pre>
(define-doc (eq?) ...)

;; Returns #t if obj is a vector. Otherwise the procedure returns #f.
;; .form (vector? obj)
;; .returns #t if obj is a vector. Otherwise the procedure returns #f.
(define-doc (vector?) ...)

; used internal
(define-doc (sys-display) ...)

;; The equal? predicate returns #t if and only if the unfoldings of its arguments into regular trees are equal as ordered trees.
;; .form (equal? obj1 obj2)
;; .returns #t if and only if the unfoldings of its arguments into regular trees are equal as ordered trees.
;; .example (equal? 'a 'a)                                 =>  #t
;; .example (equal? '(a) '(a))                             =>  #t
;; .example (equal? '(a (b) c) '(a (b) c))                 =>  #t
;; .example (equal? "abc" "abc")                           =>  #t
;; .example (equal? 2 2)                                   =>  #t
;; .example (equal? (make-vector 5 'a) (make-vector 5 'a)) =>  #t
(define-doc (equal?) ...)

;; Returns #t if obj is a character, otherwise returns #f.
;; .form (char? obj)
;; .returns #t if obj is a character, otherwise returns #f.
(define-doc (char?) ...)

;; Returns #t if all given charctors are same charctor.
;; .form (char=? char1 char2 char3 ...)
;; .returns #t if all given charctors are same charctor.
(define-doc (char=?) ...)

;; Given a character, char->integer returns its Unicode scalar value as an exact integer object.
;; .form (char->integer char)
;; .returns Given a character, char->integer returns its Unicode scalar value as an exact integer object.
(define-doc (char->integer) ...)

;; For a Unicode scalar value sv, integer->char returns its associated character.
;; .form (integer->char sv)
;; .returns For a Unicode scalar value sv, integer->char returns its associated character.
(define-doc (integer->char) ...)

;; (not implemented yet) Returns #t if obj is a list, #f otherwise. By definition, all lists are chains of pairs that have finite length and are terminated by the empty list.
;; .form (list? obj)
;; .returns #t if obj is a list, #f otherwise. By definition, all lists are chains of pairs that have finite length and are terminated by the empty list.
(define-doc (list?) ...)

;; Returns a newly allocated pair whose car is obj1 and whose cdr is obj2.
;; The pair is guaranteed to be different (in the sense of eqv?) from every existing object.
;; .returns A newly allocated pair whose car is obj1 and whose cdr is obj2.
;; .form (cons obj1 obj2)
;; .example (cons 'a '())                   =>  (a)
;; .example (cons '(a) '(b c d))            =>  ((a) b c d)
;; .example (cons "a" '(b c))               =>  ("a" b c)
;; .example (cons 'a 3)                     =>  (a . 3)
;; .example (cons '(a b) 'c)                =>  ((a b) . c)
(define-doc (cons) ...)

;; Returns the contents of the car field of pair.
;; .returns The contents of the car field of pair.
;; .form (car pair)
;; .example (car '(a b c))                  =>  a
;; .example (car '((a) b c d))              =>  (a)
;; .example (car '(1 . 2))                  =>  1
;; .example (car '())                       &assertion exception (not implemented yet)
(define-doc (car) ...)

;; Returns the contents of the cdr field of pair.
;; .returns The contents of the cdr field of pair.
;; .form (cdr pair)
;; .example (cdr '((a) b c d))              =>  (b c d)
;; .example (cdr '(1 . 2))                  =>  2
;; .example (cdr '())                       &assertion exception (not implemented yet)
(define-doc (cdr) ...)

;; Returns #t if obj is the empty list, #f otherwise.
;; .returns #t if obj is the empty list, #fotherwise.
;; .form (null? obj)
(define-doc (null?) ...)

;; <p>Returns #t if the strings are the same length and contain the same characters in the same positions.</p>
;; <p>Otherwise, the string=? procedure returns #f.Returns #t if obj is a string, otherwise returns #f.</p>
;; .form (string=? string1 string2 string3 ...)
;; .returns Returns #t if the strings are the same length and contain the same characters in the same positions.
(define-doc (string=?) ...)

;; Returns a newly allocated string of length k.
;; If char is given, then all elements of the string are initialized to char, otherwise the contents of the string are unspecified.
;; .form (make-string k &optional char)
;; .returns allocated string of length k.
(define-doc (make-string) ...)

;; Returns a newly allocated string composed of the arguments.
;; .form (string char ...)
;; .returns Returns a newly allocated string composed of the arguments.
(define-doc (string) ...)

;; Returns #t if obj is a string, otherwise returns #f.
;; .form (string? obj)
;; .returns #t if obj is a string, otherwise returns #f.
(define-doc (string?) ...)

;; Returns the number of characters in the given string as an exact integer object.
;; .returns the number of characters in the given string as an exact integer object.
;; .form (string-length string)
(define-doc (string-length) ...)

;; character at index k in string
;; .pre-condition K must be a valid index of string.
;; .returns character at index k in string
;; .form (string-ref string k)
(define-doc (string-ref) ...)

;; stores char in element k of string.
;; .returns unspecified
;; .form (string-set! string k char)
(define-doc (string-set!) ...)

;; Returns the symbol whose name is string.
;; .form (string->symbol string)
;; .example (eq? 'JollyWog\
;;     (string->symbol\
;;       (symbol->string 'JollyWog))) => #t
(define-doc (string->symbol) ...)

;; Returns a number by the given string.
;; .form (string->number string)
;; .returns number
(define-doc (string->number) ...)

;; Returns a newly allocated string whose characters form the concatenation of the given strings.
;; .form (string-append string ...)
;; .returns A newly allocated string whose characters form the concatenation of the given strings.
(define-doc (string-append) ...)

;; Splits string by splitter and returns a list of strings.
;; splitter can be a character.
;; .form (string-split string splitter)
;; .returns a list of splitted strings.
(define-doc (string-split) ...)

;; Takes a number object and returns as a string an external representation of the given number object.
;; .form (number->string z)
;; .returns Takes a number object and returns as a string an external representation of the given number object.
(define-doc (number->string) ...)

;; Takes a number object and a radix and returns as a string an external representation of the given number object in the given radix.
;; .form (number->string z radix)
;; .parameter radix must be 16. (2, 8, 10 is not implemented yet)
;; .returns Takes a number object and a radix and returns as a string an external representation of the given number object in the given radix.
(define-doc (number->string) ...)

;; return #t if obj is number object and #f otherwise.
;; .returns #t if obj is number object and #f otherwise
(define-doc (number? obj) ...)

;; returns (car (car p))
;; .pre-condition p is pair
;; .returns (car (car p))
(define (caar p) (car (car p)))

;; returns (cdr (car p))
;; .pre-condition p is pair
;; .returns (cdr (car p))
(define (cdar p) (cdr (car p)))

;; returns (car (cdr p))
;; .pre-condition p is pair
;; .returns (car (cdr p))
(define (cadr p) (car (cdr p)))

;; returns (cdr (cdr p))
;; .pre-condition p is pair
;; .returns (cdr (cdr p))
(define (cddr p) (cdr (cdr p)))

;; returns (car (car (car p)))
;; .pre-condition p is pair
;; .returns (car (car (car p)))
(define (caaar p) (car (car (car p))))

;; returns (cdr (car (car p)))
;; .pre-condition p is pair
;; .returns (cdr (car (car p)))
(define (cdaar p) (cdr (car (car p))))

;; returns (car (cdr (car p)))
;; .pre-condition p is pair
;; .returns (car (cdr (car p)))
(define (cadar p) (car (cdr (car p))))

;; returns (cdr (cdr (car p)))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car p)))
(define (cddar p) (cdr (cdr (car p))))

;; returns (car (car (cdr p)))
;; .pre-condition p is pair
;; .returns (car (car (cdr p)))
(define (caadr p) (car (car (cdr p))))

;; returns (cdr (car (cdr p)))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr p)))
(define (cdadr p) (cdr (car (cdr p))))

;; returns (car (cdr (cdr p)))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr p)))
(define (caddr p) (car (cdr (cdr p))))

;; returns (cdr (cdr (cdr p)))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr p)))
(define (cdddr p) (cdr (cdr (cdr p))))

;; returns (car (car (car (car p))))
;; .pre-condition p is pair
;; .returns (car (car (car (car p))))
(define (caaaar p) (car (car (car (car p)))))

;; returns (cdr (car (car (car p))))
;; .pre-condition p is pair
;; .returns (cdr (car (car (car p))))
(define (cdaaar p) (cdr (car (car (car p)))))

;; returns (car (cdr (car (car p))))
;; .pre-condition p is pair
;; .returns (car (cdr (car (car p))))
(define (cadaar p) (car (cdr (car (car p)))))

;; returns (cdr (cdr (car (car p))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car (car p))))
(define (cddaar p) (cdr (cdr (car (car p)))))

;; returns (car (car (cdr (car p))))
;; .pre-condition p is pair
;; .returns (car (car (cdr (car p))))
(define (caadar p) (car (car (cdr (car p)))))

;; returns (cdr (car (cdr (car p))))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr (car p))))
(define (cdadar p) (cdr (car (cdr (car p)))))

;; returns (car (cdr (cdr (car p))))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr (car p))))
(define (caddar p) (car (cdr (cdr (car p)))))

;; returns (cdr (cdr (cdr (car p))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr (car p))))
(define (cdddar p) (cdr (cdr (cdr (car p)))))

;; returns (car (car (car (cdr p))))
;; .pre-condition p is pair
;; .returns (car (car (car (cdr p))))
(define (caaadr p) (car (car (car (cdr p)))))

;; returns (cdr (car (car (cdr p))))
;; .pre-condition p is pair
;; .returns (cdr (car (car (cdr p))))
(define (cdaadr p) (cdr (car (car (cdr p)))))

;; returns (car (cdr (car (cdr p))))
;; .pre-condition p is pair
;; .returns (car (cdr (car (cdr p))))
(define (cadadr p) (car (cdr (car (cdr p)))))

;; returns (cdr (cdr (car (cdr p))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car (cdr p))))
(define (cddadr p) (cdr (cdr (car (cdr p)))))

;; returns (car (car (cdr (cdr p))))
;; .pre-condition p is pair
;; .returns (car (car (cdr (cdr p))))
(define (caaddr p) (car (car (cdr (cdr p)))))

;; returns (cdr (car (cdr (cdr p))))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr (cdr p))))
(define (cdaddr p) (cdr (car (cdr (cdr p)))))

;; returns (car (cdr (cdr (cdr p))))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr (cdr p))))
(define (cadddr p) (car (cdr (cdr (cdr p)))))

;; returns (cdr (cdr (cdr (cdr p))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr (cdr p))))
(define (cddddr p) (cdr (cdr (cdr (cdr p)))))

;; returns (car (car (car (car (car p)))))
;; .pre-condition p is pair
;; .returns (car (car (car (car (car p)))))
(define (caaaaar p) (car (car (car (car (car p))))))

;; returns (cdr (car (car (car (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (car (car (car p)))))
(define (cdaaaar p) (cdr (car (car (car (car p))))))

;; returns (car (cdr (car (car (car p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (car (car (car p)))))
(define (cadaaar p) (car (cdr (car (car (car p))))))

;; returns (cdr (cdr (car (car (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car (car (car p)))))
(define (cddaaar p) (cdr (cdr (car (car (car p))))))

;; returns (car (car (cdr (car (car p)))))
;; .pre-condition p is pair
;; .returns (car (car (cdr (car (car p)))))
(define (caadaar p) (car (car (cdr (car (car p))))))

;; returns (cdr (car (cdr (car (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr (car (car p)))))
(define (cdadaar p) (cdr (car (cdr (car (car p))))))

;; returns (car (cdr (cdr (car (car p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr (car (car p)))))
(define (caddaar p) (car (cdr (cdr (car (car p))))))

;; returns (cdr (cdr (cdr (car (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr (car (car p)))))
(define (cdddaar p) (cdr (cdr (cdr (car (car p))))))

;; returns (car (car (car (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (car (car (car (cdr (car p)))))
(define (caaadar p) (car (car (car (cdr (car p))))))

;; returns (cdr (car (car (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (car (cdr (car p)))))
(define (cdaadar p) (cdr (car (car (cdr (car p))))))

;; returns (car (cdr (car (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (car (cdr (car p)))))
(define (cadadar p) (car (cdr (car (cdr (car p))))))

;; returns (cdr (cdr (car (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car (cdr (car p)))))
(define (cddadar p) (cdr (cdr (car (cdr (car p))))))

;; returns (car (car (cdr (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (car (car (cdr (cdr (car p)))))
(define (caaddar p) (car (car (cdr (cdr (car p))))))

;; returns (cdr (car (cdr (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr (cdr (car p)))))
(define (cdaddar p) (cdr (car (cdr (cdr (car p))))))

;; returns (car (cdr (cdr (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr (cdr (car p)))))
(define (cadddar p) (car (cdr (cdr (cdr (car p))))))

;; returns (cdr (cdr (cdr (cdr (car p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr (cdr (car p)))))
(define (cddddar p) (cdr (cdr (cdr (cdr (car p))))))

;; returns (car (car (car (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (car (car (car (cdr p)))))
(define (caaaadr p) (car (car (car (car (cdr p))))))

;; returns (cdr (car (car (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (car (car (cdr p)))))
(define (cdaaadr p) (cdr (car (car (car (cdr p))))))

;; returns (car (cdr (car (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (car (car (cdr p)))))
(define (cadaadr p) (car (cdr (car (car (cdr p))))))

;; returns (cdr (cdr (car (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car (car (cdr p)))))
(define (cddaadr p) (cdr (cdr (car (car (cdr p))))))

;; returns (car (car (cdr (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (car (cdr (car (cdr p)))))
(define (caadadr p) (car (car (cdr (car (cdr p))))))

;; returns (cdr (car (cdr (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr (car (cdr p)))))
(define (cdadadr p) (cdr (car (cdr (car (cdr p))))))

;; returns (car (cdr (cdr (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr (car (cdr p)))))
(define (caddadr p) (car (cdr (cdr (car (cdr p))))))

;; returns (cdr (cdr (cdr (car (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr (car (cdr p)))))
(define (cdddadr p) (cdr (cdr (cdr (car (cdr p))))))

;; returns (car (car (car (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (car (car (cdr (cdr p)))))
(define (caaaddr p) (car (car (car (cdr (cdr p))))))

;; returns (cdr (car (car (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (car (cdr (cdr p)))))
(define (cdaaddr p) (cdr (car (car (cdr (cdr p))))))

;; returns (car (cdr (car (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (car (cdr (cdr p)))))
(define (cadaddr p) (car (cdr (car (cdr (cdr p))))))

;; returns (cdr (cdr (car (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (car (cdr (cdr p)))))
(define (cddaddr p) (cdr (cdr (car (cdr (cdr p))))))

;; returns (car (car (cdr (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (car (cdr (cdr (cdr p)))))
(define (caadddr p) (car (car (cdr (cdr (cdr p))))))

;; returns (cdr (car (cdr (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (car (cdr (cdr (cdr p)))))
(define (cdadddr p) (cdr (car (cdr (cdr (cdr p))))))

;; returns (car (cdr (cdr (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (car (cdr (cdr (cdr (cdr p)))))
(define (caddddr p) (car (cdr (cdr (cdr (cdr p))))))

;; returns (cdr (cdr (cdr (cdr (cdr p)))))
;; .pre-condition p is pair
;; .returns (cdr (cdr (cdr (cdr (cdr p)))))
(define (cdddddr p) (cdr (cdr (cdr (cdr (cdr p))))))

;; Returns whether x is even.
;; .returns whether x is even
(define (even? x)
  (zero? (mod x 2)))

(define (odd? x)
  (= (mod x 2) 1))


;; (define (gen-cxxr n)
;;   (define (association lst1 lst2)
;;     (fold-right (lambda (x y) (append (map (cut cons x <>) lst2) y)) '() lst1))
;;   (define (combination n)
;;     (let loop ([n (- n 1)])
;;       (if (<= n 0)
;;           '((a) (d))
;;           (association '(a d) (loop (- n 1))))))
;;   (define (gen lst)
;;     (let loop ([name ""]
;;                [body "p"]
;;                [lst lst])
;;       (if (null? lst)
;;           (begin
;;             (format #t ";; returns ~a\n" body)
;;             (format #t ";; .pre-condition p is pair\n")
;;             (format #t ";; .returns ~a\n" body)
;;             (format #t "(define (c~ar p) ~a)\n\n" name body))
;;           (loop (format "~a~a" (car lst) name)
;;                 (format "(~a ~a)" (if (eq? 'a (car lst)) 'car 'cdr) body)
;;                 (cdr lst)))))
;;   (let loop ([m 2])
;;     (cond
;;      [(< n m) '()]
;;      [else
;;       (for-each gen (combination m))
;;       (loop (+ m 1))])))

;; (gen-cxxr 5)

;; Calls producer with no arguments and a continuation that, when passed some values, calls the consumer procedure with those values as arguments.
;; The continuation for the call to consumer is the continuation of the call to call-with-values.
;; .parameter producer must be a procedure and should accept zero arguments
;; .parameter consumer must be a procedure and should accept as many values as producer returns
;; .returns result of consumer
;; .internal-references "SRFI-8 Binding to multiple values." "receive"
;; (define (call-with-values producer consumer)
;;   (apply consumer (producer)))
(define (call-with-values producer consumer)
  (receive vals (producer) (apply consumer vals)))

;; returns the subchain of pairs of list obtained by omitting the first k elements
;; .pre-condition l should be a list of size at least k.
;; .returns the subchain of pairs of list obtained by omitting the first k elements
;; .example (list-tail '(a b c d) 2) => (c d)
(define (list-tail l k)
  (if (= k 0)
      l
      (list-tail (cdr l) (- k 1))))

;; returns the kth element of list.
;; .pre-condition l must be a list whose length is at least k + 1.
;; .returns returns the kth element of list.
;; .example (list-ref '(a b c d) 2) => c
(define (list-ref l k)
  (car (list-tail l k)))

;; returns a newly allocated list of the objects contained in the elements of vector
;; .returns returns a newly allocated list of the objects contained in the elements of vector
;; .example (vector->list '#(dah dah didah)) => (dah dah didah)
;; .form (vector->list v)
(define-doc (vector->list) ...)
;;   (let loop ((pos (- (vector-length v) 1)) (l '()))
;;     (if (< pos 0)
;;         l
;;         (loop (- pos 1) (cons (vector-ref v pos) l)))))

;; tests if the number object is = to zero
;; .returns #t is (= n 0)
(define (zero? n)
  (= 0 n))

(define (positive? x)
  (> x 0))

(define (negative? x)
  (< x 0))

;; Returns a newly allocated list of its arguments.
;; .returns a newly allocated list of its arguments.
;; .form (list obj ...)
;; .example (list 'a (+ 3 4) 'c) => (a 7 c)
;; .example (list) => ()
(define (list . a) a)

;; Returns the absolute value of its argument.
;; .returns Returns the absolute value of its argument.
;; .example (abs -7) => 7
(define (abs n)
  (if (>= n 0)
      n
      (* -1 n)))

;; The map procedure applies proc element-wise to the elements of the lists and returns a list of the results, in order.
;; .parameter ll should all have the same length.
;; .parameter proc should accept as many arguments as there are lists and return a single value. should not mutate any of the lists.
;; .returns a list of the results
;; .form (map proc list1 list2 ...)
;; .example (map cadr '((a b) (d e) (g h))) => (b e h)
;; .example (map (lambda (n) (expt n n)) '(1 2 3 4 5)) => (1 4 27 256 3125)
;; .example (map + '(1 2 3) '(4 5 6)) => (5 7 9)
(define (map proc . ll)
  (if (null? (car ll))
      '()
      (if (null? (cdr ll))
          (map1 proc (car ll))
          (let ((tetes (map1 car ll))
                (queues (map1 cdr ll)))
            (cons (apply proc tetes)
                  (apply map (cons proc queues)))))))

;; Returns the length of list.
;; .returns the length of list.
;; (length '(a b c)) => 3
;; (length '(a (b) (c d e))) => 3
;; (length '()) => 0
;; .form (length l)
(define-doc (length) ...)
;; (define (length l)
;;   (let loop ((l l) (len 0))
;;     (if (null? l)
;;         len
;;         (loop (cdr l) (+ len 1)))))

;; Returns a newly allocated list consisting of the elements of list in reverse order.
;; .returns a newly allocated list consisting of the elements of list in reverse order.
;; .example (reverse '(a b c)) => (c b a)
;; .example (reverse '(a (b c) d (e (f)))) => ((e (f)) d (b c) a)
(define (reverse l)
  (let loop ((l l) (rl '()))
    (if (null? l)
        rl
        (loop (cdr l) (cons (car l) rl)))))

;; The list->string procedure returns a newly allocated string formed from the characters in list.
;; .returns The list->string procedure returns a newly allocated string formed from the characters in list.
(define (list->string l)
  (let* ((len (length l))
         (newstring (make-string len))
         (iter (lambda (iter l to)
                 (if (< to len)
                     (begin
                       (string-set! newstring to (car l))
                       (iter iter (cdr l) (+ to 1)))))))
    (iter iter l 0)
    newstring))

;; The for-each procedure applies proc element-wise to the elements of the lists for its side effects, in order from the first elements to the last.
;; .form (for-each proc list1 list2 ...)
;; .pre-condition The lists should all have the same length. Proc should accept as many arguments as there are lists. Proc should not mutate any of the lists.
;; .returns The return values of for-each are unspecified.
;; .example (let ((v (make-vector 5)))\
;;  (for-each (lambda (i)\
;;              (vector-set! v i (* i i)))\
;;            '(0 1 2 3 4))\
;;  v)  => #(0 1 4 9 16)
;; .example (for-each (lambda (x) x) '(1 2 3 4)) => unspecified
;; .example (for-each even? ’()) => unspecified
(define (for-each proc . ll)
  (if (null? (car ll))
      #f
      (if (null? (cdr ll))
          (for-each-1 proc (car ll))
          (let* ((tetes (map car ll))
                 (queues (map cdr ll)))
            (apply proc tetes)
            (apply for-each (cons proc queues))))))

(define (for-each-1 proc lst)
  (if (null? lst)
      #f
      (begin
        (proc (car lst))
        (for-each-1 proc (cdr lst)))))


;; The list->vector procedure returns a newly created vector initialized to the elements of the list list.
;; .returns The list->vector procedure returns a newly created vector initialized to the elements of the list list.
;; .example (list->vector '(dididit dah)) => #(dididit dah)
;; (define (list->vector l)
;;   (let* ((len (length l))
;;          (v (make-vector len)))
;;     (let loop ((l l) (pos 0))
;;       (if (not (null? l))
;;           (begin
;;             (vector-set! v pos (car l))
;;             (loop (cdr l) (+ pos 1)))))
;;     v))

;; Returns a possibly improper list consisting of the elements of the first list followed by the elements of the other lists, with obj as the cdr of the final pair. An improper list results if obj is not a list.
;; .returns Returns a possibly improper list consisting of the elements of the first list followed by the elements of the other lists, with obj as the cdr of the final pair. An improper list results if obj is not a list.
;; .post-condition If append constructs a nonempty chain of pairs, it is always newly allocated. If no pairs are allocated, obj is returned.
;; .example (append '(x) '(y))                      =>  (x y)
;; .example (append '(a) '(b c d))                  =>  (a b c d)
;; .example (append '(a (b)) '((c)))                =>  (a (b) (c))
;; .example (append '(a b) '(c . d))                =>  (a b c . d)
;; .example (append '() 'a)                         =>  a
;; .form (append list ... obj)
(define-doc (append) ...)

;; Applies proc element-wise to the elements of the vectors for its side effects, in order from the first elements to the last. Proc is always called in the same dynamic environment as vector-for-each itself.(todo vector2 ...)
;; .form (vector-for-each proc vector1 vector2 ...)
;; .pre-condition The vectors must all have the same length. Proc should accept as many arguments as there are vectors.
;; .returns unspecified.
(define (vector-for-each proc v1 . v2)
    (apply for-each proc (vector->list v1)
           (map vector->list v2)))
;; (define (vector-for-each proc v)
;;   (let1 len (vector-length v)
;;     (let loop ([i 0])
;;       (cond
;;        [(>= i len) '()]
;;        [else
;;           (proc (vector-ref v i))
;;           (loop (+ i 1))]))))

;; Applies proc element-wise to the elements of the vectors and returns a vector of the results, in order.
;; .form (vector-map proc vector1 vector2 ...)
;; .pre-condition The vectors must all have the same length. Proc should accept as many arguments as there are vectors and return a single value.
;; .returns a vectors
(define (vector-map proc v)
  (let* ([length (vector-length v)]
         [ret    (make-vector length)])
    (let loop ([i 0])
      (cond [(>= i length)
             ret]
            [else
             (vector-set! ret i (proc (vector-ref v i)))
             (loop (+ i 1))]))))


; ==============================================================================================================================================================
;;; Bytevectors.
;;; R6RS library Chapter 2.
;; Stores octet in element k of bytevector.
;; .pre-condition K must be a valid index of bytevector.
;; .form (bytevector-u8-set! bytevector k octet)
;; .returns unspecified
(define-doc (bytevector-u8-set!) ...)

;; Returns, as an exact integer object, the number of bytes in bytevector.
;; .form (bytevector-length bytevector)
;; .returns As an exact integer object, the number of bytes in bytevector.
(define-doc (bytevector-length) ...)

;; Returns the byte at index k of bytevector, as an octet.
;; .pre-condition K must be a valid index of bytevector.
;; .form (bytevector-u8-ref bytevector k)
;; .returns the byte at index k of bytevector, as an octet.
(define-doc (bytevector-u8-ref) ...)

;; Returns a newly allocated (unless empty) string whose character sequence is encoded by the given bytevector.
;; .form (utf8->string bytevector)
;; .returns A newly allocated (unless empty) string whose character sequence is encoded by the given bytevector.
(define-doc (utf8->string) ...)

; ==============================================================================================================================================================
;;; List utilities.
;;; R6RS library Chapter 3.

;; Return the first sublist of list whose car satisfies a given condition with eq?, where the sublists of lists are the lists returned by (list-tail list k) for k less than the length of list.
;; .form (memq obj list)
;; .pre-condition Proc should accept one argument and return a single value. Proc should not mutate list.
;; .returns The first sublist of list whose car satisfies a given condition, where the sublists of lists are the lists returned by (list-tail list k) for k less than the length of list.
(define-doc (memq) ...)

;; Return the first sublist of list whose car satisfies a given condition with equal?, where the sublists of lists are the lists returned by (list-tail list k) for k less than the length of list.
;; .form (member obj list)
;; .pre-condition Proc should accept one argument and return a single value. Proc should not mutate list.
;; .returns The first sublist of list whose car satisfies a given condition, where the sublists of lists are the lists returned by (list-tail list k) for k less than the length of list.
;; (define-doc (member) ...)

; used internal
(define (foldl1 binop l)
  (if (null? (cdr l))
      (car l)
      (foldl1 binop (cons (binop (car l) (cadr l))
                          (cddr l)))))
; used internal
(define (foldl binop start l)
  (if (null? l)
      start
      (foldl binop (binop start (car l)) (cdr l))))

;; <p>The fold-left procedure iterates the combine procedure over an accumulator value and the elements of the lists from left to right, starting with an accumulator value of nil.</p>
;; <p>More specifically, fold-left returns nil if the lists are empty.
;; If they are not empty, combine is first applied to nil and the respective first elements of the lists in order.</p>
;; <p>The result becomes the new accumulator value, and combine is applied to the new accumulator value and the respective next elements of the list.</p>
;; <p>This step is repeated until the end of the list is reached; then the accumulator value is returned. Combine is always called in the same dynamic environment as fold-left itself.</p>
;; .form (fold-left combine nil list1 list2 ...listn)
;; .todo be compatible with R6RS
;; .pre-condition The lists should all have the same length. Combine must be a procedure. It should accept one more argument than there are lists and return a single value. It should not mutate the list arguments.
;; .returns accumlated pair
;; .example (fold-left + 0 '(1 2 3 4 5)) => 15
;; .example (fold-left (lambda (a e) (cons e a)) '()\
;;           '(1 2 3 4 5)) => (5 4 3 2 1)
;; .example (fold-left (lambda (count x) \
;;             (if (odd? x) (+ count 1) count)) \
;;             0 \
;;             '(3 1 4 1 5 9 2 6 5 3)) \
;;           => 7
;; .example (fold-left (lambda (max-len s) \
;;             (max max-len (string-length s))) \
;;             0 \
;;             '("longest" "long" "longer")) \
;;           => 7
;; .example (fold-left + 0 '(1 2 3) '(4 5 6)) \
;;           => 21
;; .example (fold-left cons '(q) '(a b c)) \
;;            => ((((q) . a) . b) . c)
;; from Iron Scheme
(define (fold-left combine nil list1 . lists)
  (if (null? list1)
      nil
      (apply fold-left
             (cons*
              combine
              (apply combine (cons* nil (car list1) (map car lists)))
              (cdr list1)
              (map cdr lists)))))

; used internal
(define (foldr binop start l)
    (if (null? l)
        start
        (binop (car l) (foldr binop start (cdr l)))))

; used internal
(define (foldr1 binop l)
    (if (null? (cdr l))
        (car l)
        (binop (car l) (foldr1 binop (cdr l)))))

; used internal
(define (foldr2 binop start l1 l2)
    (if (null? l1)
        start
        (binop (car l1) (car l2) (foldr2 binop start (cdr l1) (cdr l2)))))

; used internal
(define (fold kons knil lis1)
  (let lp ((lis lis1) (ans knil))
    (if (null? lis) ans
      (lp (cdr lis) (kons (car lis) ans)))))

;; <p>The fold-right procedure iterates the combine procedure over the elements of the lists from right to left and an accumulator value, starting with an accumulator value of nil.</p>
;; <p>More specifically, fold-right returns nil if the lists are empty.
;; If they are not empty, combine is first applied to the respective last elements of the lists in order and nil.</p>
;; <p>The result becomes the new accumulator value, and combine is applied to the respective previous elements of the lists and the new accumulator value.</p>
;; <p>This step is repeated until the beginning of the list is reached; then the accumulator value is returned.</p>
;; <p>Proc is always called in the same dynamic environment as fold-right itself.</p>
;; .form (fold-right combine nil list1 list2 ...listn)
;; .pre-condition The lists should all have the same length. Combine must be a procedure. It should accept one more argument than there are lists and return a single value. Combine should not mutate the list arguments.
;; .todo r6rs compatible
;; .returns accumulated pair
;; .example (fold-right + 0 '(1 2 3 4 5))\
;;           => 15
;; .example (fold-right cons '() '(1 2 3 4 5))\
;;          => (1 2 3 4 5)
;; .example (fold-right (lambda (x l)\
;;            (if (odd? x) (cons x l) l))\
;;            '()\
;;            '(3 1 4 1 5 9 2 6 5))\
;;           => (3 1 1 5 9 5)
;; .example (fold-right cons '(q) '(a b c))\
;;          => (a b c q)
;; .example (fold-right + 0 '(1 2 3) '(4 5 6))\
;;          => 21
; from IronScheme
(define (fold-right combine nil list1 . lists)
  (if (null? list1)
      nil
      (apply combine
             (append
              (list (car list1))
              (map car lists)
              (list
               (apply fold-right
                      (cons*
                       combine
                       nil
                       (cdr list1)
                       (map cdr lists))))))))

;; The remp procedure applies proc to each element of list and returns a list of the elements of list for which proc returned #f.
;; .pre-condition Proc should accept one argument and return a single value. Proc should not mutate list.
;; .returns The remp procedure applies proc to each element of list and returns a list of the elements of list for which proc returned #f.
;; .example (remp even? '(3 1 4 1 5 9 2 6 5)) => (3 1 1 5 9 5)
;; (define (remp pred l)
;;   (filter (lambda (a) (not (pred a))) l))
(define (remp proc l)
  (let loop ([l l]
             [ret '()])
    (if (null? l)
        (reverse ret)
        (let ((e (car l)))
          (if (proc e)
              (loop (cdr l) ret)
              (loop (cdr l) (cons e ret)))))))

(define (remove obj list)
  (remp (lambda (x) (equal? obj x)) list))

(define (remv obj list)
  (remp (lambda (x) (eqv? obj x)) list))

(define (remq obj list)
  (remp (lambda (x) (eq? obj x)) list))

(define (memp proc lst)
  (if (null? lst)
      #f
      (if (proc (car lst))
          lst
          (memp proc (cdr lst)))))

(define (assp proc lst)
  (if (null? lst)
      #f
      (let ([c (car lst)])
        (if (proc (car c)) c
            (assp proc (cdr lst))))))



;; <p>The filter procedure applies proc to each element of list and returns a list of the elements of list for which proc returned a true value.</p>
;; <p>The elements of the result list(s) are in the same order as they appear in the input list.</p>
;; .parameter proc Proc should accept one argument and return a single value. Proc should not mutate list.
;; .returns returns a list of the elements of list for which proc returned a true value.
;; .form (filter proc list)
;; .example (filter even? '(3 1 4 1 5 9 2 6)) => (4 2 6)
(define (filter pred? l)
    (cond ((null? l) '())
      ((pred? (car l)) (cons (car l) (filter pred? (cdr l))))
      (else (filter pred? (cdr l)))))

;; .pre-condition Proc should accept one argument and return a single value. Proc should not mutate list.
;; <p>The find procedure applies proc to the elements of list in order. If proc returns a true value for an element, find immediately returns that element. If proc returns #f for all elements of the list, find returns #f.</p>
;; .returns The find procedure applies proc to the elements of list in order. If proc returns a true value for an element, find immediately returns that element. If proc returns #f for all elements of the list, find returns #f.
;; .example (find even? '(3 1 4 1 5 9)) => 4
;; .example (find even? '(3 1 5 1 5 9)) => #f
(define (find pred lst)
  (let loop ([lst lst])
    (if (null? lst)
        #f
        (if (pred (car lst))
            (car lst)
            (loop (cdr lst))))))

; internal use
(define (generic-assoc releq obj alist)
  (cond ((null? alist)
         #f)
        ((releq (car (car alist)) obj)
         (car alist))
        (else
         (generic-assoc releq obj (cdr alist)))))

;; <p>Find the first pair in alist whose car field satisfies a given condition, and returns that pair without traversing alist further. If no pair in alist satisfies the condition, then #f is returned.</p>
;; <p>The assoc procedure uses equal? to compare obj with the car fields of the pairs in alist, while assv uses eqv? and assq uses eq?.</p>
;; .pre-condition Alist (for "association list") should be a list of pairs. Proc should accept one argument and return a single value. Proc should not mutate alist.
;; .example (define e '((a 1) (b 2) (c 3))) (assq 'a e) => (a 1)
;; .example (assq 'b e) => (b 2)
;; .example (assq 'd e) => #f
;; .example (assq (list 'a) '(((a)) ((b)) ((c)))) => #f
;  .example (assq 5 '((2 3) (5 7) (11 13))) => unspecified
(define (assq obj alist) (generic-assoc eq? obj alist))


;; <p>Find the first pair in alist whose car field satisfies a given condition, and returns that pair without traversing alist further. If no pair in alist satisfies the condition, then #f is returned.</p>
;; <p>The assoc procedure uses equal? to compare obj with the car fields of the pairs in alist, while assv uses eqv? and assq uses eq?.</p>
;; .pre-condition Alist (for "association list") should be a list of pairs. Proc should accept one argument and return a single value. Proc should not mutate alist.
;; .example (assv 5 '((2 3) (5 7) (11 13))) => (5 7)
(define (assv obj alist) (generic-assoc eqv? obj alist))

;; <p>Find the first pair in alist whose car field satisfies a given condition, and returns that pair without traversing alist further. If no pair in alist satisfies the condition, then #f is returned.</p>
;; <p>The assoc procedure uses equal? to compare obj with the car fields of the pairs in alist, while assv uses eqv? and assq uses eq?.</p>
;; .pre-condition Alist (for "association list") should be a list of pairs. Proc should accept one argument and return a single value. Proc should not mutate alist.
;; .example (assoc (list 'a) '(((a)) ((b)) ((c)))) => ((a))
(define (assoc obj alist) (generic-assoc equal? obj alist))


;; <p>For natural numbers i = 0, 1, ..., the for-all procedure successively applies proc to arguments xi1 ... xin, where xij is the ith element of listj, until #f is returned.</p>
;; <p>If proc returns true values for all but the last element of list1, for-all performs a tail call of proc on the kth elements, where k is the length of list1.</p>
;; <p>If proc returns #f on any set of elements, for-all returns #f after the first such application of proc. If the lists are all empty, for-all returns #t.</p>
;; .pre-condition The lists should all have the same length, and proc should accept n arguments and return a single value. Proc should not mutate the list arguments.
; .form (for-all proc list1 list2 ... listn)
(define (for-all proc lst . lists)
  (define (for-all-1 proc lst1)
    (if (null? lst1)
        #t
        (let loop ([lst lst1])
          (cond
           [(not (pair? lst))
            (assertion-violation 'for-all "proper list required" lst1)]
           [(proc (car lst))
            => (lambda (ret)
                 (if (null? (cdr lst))
                     ret
                     (loop (cdr lst))))]
           [else #f]))))
  (define (for-all-n proc list-n)
    (define (map-car l)
      (let loop ([l l])
        (cond
         [(null? l)
          '()]
         [(pair? (car l))
          (cons (caar l) (loop (cdr l)))]
         [else
          (assertion-violation 'for-all "the lists all should have the same length" list-n)])))
    (if (null*? list-n)
        #t
        (let loop ([head (map-car list-n)]
                   [rest (map cdr list-n)])
          (if (null? (car rest))
              (apply proc head)
              (and (apply proc head)
                   (loop (map-car rest) (map cdr rest)))))))
    (if (null? lists)
        (for-all-1 proc lst)
        (for-all-n proc (cons lst lists))))

(define (null*? lst)
  (let loop ([lst lst])
    (if (null? lst)
        #t
        (and (null? (car lst))
             (loop (cdr lst))))))


; ==============================================================================================================================================================
;;; Control structures.
;;; R6RS library Chapter 5.

;; <p>The [init] expressions are evaluated (in some unspecified order), the [variable]s are bound to fresh locations, the results of the [init] expressions are stored in the bindings of the [variable]s, and then the iteration phase begins.</p>
;; <p>Each iteration begins by evaluating [test]; if the result is #f, then the [command]s are evaluated in order for effect, the [step] expressions are evaluated in some unspecified order, the [variable]s are bound to fresh locations holding the results, and the next iteration begins.</p>
;; <p>If [test] evaluates to a true value, the [expression]s are evaluated from left to right and the values of the last [expression] are returned.</p>
;; <p>If no [expression]s are present, then the do expression returns unspecified values.</p>
;; <p>The regionof the binding of a [variable] consists of the entire do expression except for the [init]s.</p>
;; <p>A [step] may be omitted, in which case the effect is the same as if ([variable] [init] [variable]) had been written instead of ([variable] [init]).</p>
;; .form (do (([variable1] [init1] [step1]) ...) ([test] [expression] ...) [command] ...)
;; .example <pre>(do ((vec (make-vector 5))\
;;            (i 0 (+ i 1)))\
;;            ((= i 5) vec)\
;;              (vector-set! vec i i)) =>  #(0 1 2 3 4)</pre>
;; .example <pre>(let ((x '(1 3 5 7 9)))\
;;            (do ((x x (cdr x))\
;;              (sum 0 (+ sum (car x))))\
;;              ((null? x) sum)))</pre>
(define-doc (do) ...)

;; Evaluates test. If it yields false value, body … are evaluated sequentially, and the result(s) of the last evaluation is(are) returned. Otherwise, unspecified value is returned.
;; .form (unless test body ...)
(define-doc (unless) ...)

;; Evaluates test. If it yields true value, body … are evaluated sequentially, and the result(s) of the last evaluation is(are) returned. Otherwise, unspecified value is returned.
;; .form (when test body ...)
(define-doc (when) ...)

; ==============================================================================================================================================================
;;; Exceptions and conditionsI/O.
;;; R6RS library Chapter 7.

;; .pre-condition Thunk must be a procedure and must accept zero arguments. The file is opened for input or output using empty file options, and thunk is called with no arguments.
(define (with-input-from-file filename thunk)
  (let ([org-port (current-input-port)]
        [inport (open-input-file filename)])
    (set-current-input-port! inport)
    (let1 ret (thunk)
      (set-current-input-port! org-port)
      (close-port inport)
      ret)))

(define (with-output-to-file filename thunk)
  (let ([org-port (current-output-port)]
        [inport (open-output-file filename)])
    (set-current-output-port! inport)
    (let1 ret (thunk)
      (set-current-output-port! org-port)
      (close-port inport)
      ret)))

;; Raises a non-continuable exception by invoking the current exception handler on obj.
;; .form (raise obj)
(define-doc (raise) ...)

;; Returns the results of invoking thunk. Handler is installed as the current exception handler for the dynamic extent (as determined by dynamic-wind) of the invocation of thunk.
;; .pre-condition Handler must be a procedure and should accept one argument. Thunk must be a procedure that accepts zero arguments.
;; .returns the results of invoking thunk.
;; .form (with-exception-handler handler thunk)
(define-doc (with-exception-handler) ...)

;; <p>(guard ([variable]    syntax</p>
;; <p>[cond clause1] [cond clause2] ...)</p>
;; <p>[body])</p>
;; <p>=>    auxiliary syntax</p>
;; <p>else    auxiliary syntax</p>
;; <p>Semantics: Evaluating a guard form evaluates [body] with an exception handler that binds the raised object to [variable] and within the scope of that binding evaluates the clauses as if they were the clauses of a cond expression. </p>
;; <p>That implicit cond expression is evaluated with the continuation and dynamic environment of the guard expression. </p>
;; <p>If every [cond clause]'s [test] evaluates to #f and there is no else clause, then raise is re-invoked on the raised object within the dynamic environment of the original call to raise except that the current exception handler is that of the guard expression.</p>
;; .form (guard ([variable] [cond clause1] [cond clause2] ...)
(define-doc (guard) ...)

;; <p>Raises a continuable exception by invoking the current exception handler on obj.</p>
;; <p>The handler is called with a continuation that is equivalent to the continuation of the call to raise-continuable, with these two exceptions:</p>
;; <p>(1) the current exception handler is the one that was in place when the handler being called was installed, and (2) if the handler being called returns, then it will again become the current exception handler. </p>
;;<p>If the handler returns, the values it returns become the values returned by the call to raise-continuable.</p>
;; .form (raise-continuable obj)
(define-doc (raise-continuable) ...)


; ==============================================================================================================================================================
;;; I/O.
;;; R6RS library Chapter 8.

;; Reads an external representation from textual-input-port and returns the datum it represents.
;; .form (read) (read textual-input-port)
;; .returns datum
(define-doc (read) ...)

;; Returns an output port for the named file.
;; .form (open-file-output-port filename)
;; .returns An output port for the named file.
(define-doc (open-file-output-port) ...)

;; Returns an input port for the named file.
;; .form (open-file-input-port filename)
;; .returns An input port for the named file.
(define-doc (open-file-input-port) ...)

;; Closes input-port or output-port, respectively.
;; .form (close-input-port input-port)
;; .returns unspecified
(define-doc (close-input-port) ...)

;; Returns a fresh binary input port connected to standard input. Whether the port supports the port-position and set-port-position! operations is implementation-dependent.
;; .form (standard-input-port)
;; .returns A fresh binary input port connected to standard input. Whether the port supports the port-position and set-port-position! operations is implementation-dependent.
(define-doc (standard-input-port) ...)

;; <p>Reads from binary-input-port, blocking as necessary, until count bytes are available from binary-input-port or until an end of file is reached.</p>
;; <p>If count bytes are available before an end of file, get-bytevector-n returns a bytevector of size count.
;; If fewer bytes are available before an end of file, get-bytevector-n returns a bytevector containing those bytes.</p>
;; <p>In either case, the input port is updated to point just past the bytes read.</p>
;; <p>If an end of file is reached before any bytes are available, get-bytevector-n returns the end-of-file object. </p>
;; .pre-condition Count must be an exact, non-negative integer object representing the number of bytes to be read.
;; .form (get-bytevector-n binary-input-port count)
;; .returns bytevector
(define-doc (get-bytevector-n) ...)

;; Returns the end-of-file object.
;; .form (eof-object)
;; .returns the end-of-file object.
(define-doc (eof-object) ...)

;; <p>Returns a new textual port with the specified transcoder.</p>
;; <p>Otherwise the new textual port's state is largely the same as that of binary-port.</p>
;; <p>If binary-port is an input port, the new textual port will be an input port and will transcode the bytes that have not yet been read from binary-port.
;; If binary-port is an output port, the new textual port will be an output port and will transcode output characters into bytes that are written to the byte sink represented by binary-port.</p>
;; .form (transcoded-port binary-port transcoder)
;; .returns A new textual port with the specified transcoder.
(define-doc (transcoded-port) ...)

;; Predefined codecs for the UTF-8 encoding schemes.
;; .form (utf-8-codec)
;; .returns Predefined codecs for the UTF-8 encoding schemes.
(define-doc (utf-8-codec) ...)

;; Returns transcoder with the behavior specified by its arguments.
;; .form (make-transcoder codec)
;; .returns transcoder with the behavior specified by its arguments.
(define-doc (make-transcoder) ...)

;; <p>Reads from binary-input-port, blocking as necessary, until a byte is available from binary-input-port or until an end of file is reached.</p>
;; <p>If a byte becomes available, get-u8 returns the byte as an octet and updates binary-input-port to point just past that byte.
;; If no input byte is seen before an end of file is reached, the end-of-file object is returned.</p>
;; .form (get-u8 binary-input-port)
;; .returns a byte
(define-doc (get-u8) ...)

;; <p>Note. This procedure is not implementednot all specification.</p>
;; <p>Returns a newly created binary input port whose byte source is an arbitrary algorithm represented by the read! procedure.</p>
;; <p>Id must be a string naming the new port, provided for informational purposes only. Read! must be a procedure and should behave as specified below; it will be called by operations that perform binary input.</p>
;; <p>Each of the remaining arguments may be #f; if any of those arguments is not #f, it must be a procedure and should behave as specified below.</p>
;; <p>(read! bytevector start count)</p>
;; <p>Start will be a non-negative exact integer object, count will be a positive exact integer object, and bytevector will be a bytevector whose length is at least start + count.</p>
;; <p>The read! procedure should obtain up to count bytes from the byte source, and should write those bytes into bytevector starting at index start.</p>
;; <p>The read! procedure should return an exact integer object.</p>
;; <p>This integer object should represent the number of bytes that it has read. To indicate an end of file, the read! procedure should write no bytes and return 0.</p>
;; <p>(get-position)</p>
;; <p>The get-position procedure (if supplied) should return an exact integer object representing the current position of the input port.</p>
;; <p>If not supplied, the custom port will not support the port-position operation.</p>
;; <p>(set-position! pos)</p>
;; <p>Pos will be a non-negative exact integer object. The set-position! procedure (if supplied) should set the position of the input port to pos.</p>
;; <p>If not supplied, the custom port will not support the set-port-position! operation.</p>
;; <p>(close)</p>
;; <p>The close procedure (if supplied) should perform any actions that are necessary when the input port is closed.</p>
;; .form (make-custom-binary-input-port id read! procedure get-position set-position! close)
;; .returns A newly created binary input port whose byte source is an arbitrary algorithm represented by the read! procedure.
(define-doc (make-custom-binary-input-port) ...)

;; Returns default textual ports for regular error output. Normally, this port is associated with standard error.
;; .form (current-error-port)
;; .returns Default textual ports for regular error output. Normally, this port is associated with standard error.
(define-doc (current-error-port) ...)

;; Writes the external representation of obj to textual-output-port. The write procedure operates in the same way as put-datum. If textual-output-port is omitted, it defaults to the value returned by current-output-port.
;; .form (write obj &optional textual-output-port)
;; .returns unspecified
(define-doc (write) ...)

;; Returns #t if obj is the end-of-file object, #f otherwise.
;; .form (eof-object? obj)
;; .returns #t if obj is the end-of-file object, #f otherwise.
(define-doc (eof-object?) ...)

;; <p>Reads from textual-input-port, blocking as necessary until a character is available from textual-input-port, or the data that are available cannot be the prefix of any valid encoding, or an end of file is reached.</p>
;; <p>If a complete character is available before the next end of file, read-char returns that character, and updates the input port to point past that character.
;; If an end of file is reached before any data are read, read-char returns the end-of-file object.
;; If textual-input-port is omitted, it defaults to the value returned by current-input-port.</p>
;; .form (read-char &optional textual-input-port)
;; .returns character
(define-doc (read-char) ...)

;; Returns a textual input port whose characters are drawn from string.
;; .form (open-string-input-port string)
;; .returns A textual input port whose characters are drawn from string.
(define-doc (open-string-input-port) ...)

; used internal
(define-doc (sys-open-output-string) ...)

; used internal
(define-doc (sys-port-seek) ...)

; used internal
(define-doc (sys-get-output-string) ...)

;; used internal
(define-doc (set-current-input-port!) ...)

;; used internal
(define-doc (set-current-output-port!) ...)

;; Opens filename for output, with empty file options, and returns the obtained port.
;; .form (open-output-file filename)
;; .returns Opens filename for output, with empty file options, and returns the obtained port.
(define-doc (open-output-file) ...)

;; Returns a default textual port for input. Normally, this default port is associated with standard input, but can be dynamically re-assigned using the with-input-from-file procedure
;; .form (current-input-port)
;; .returns A default textual port for input. Normally, this default port is associated with standard input, but can be dynamically re-assigned using the with-input-from-file procedure
(define-doc (current-input-port) ...)

;; Returns a default textual port for output. Normally, this default port is associated with standard output, but can be dynamically re-assigned using the with-output-from-file procedure
;; .form (current-output-port)
;; .returns A default textual port for output. Normally, this default port is associated with standard output, but can be dynamically re-assigned using the with-output-from-file procedure
(define-doc (current-output-port) ...)

;; Closes output-port.
;; .form (close-output-port output-port)
;; .returns unspecified
(define-doc (close-output-port) ...)

;; .pre-condition Proc should accept one argument.
;; <p>Open the file named by filename for output, with no specified file options, and call proc with the obtained port as an argument.</p>
;; <p>If proc returns, the port is closed automatically and the values returned by proc are returned.
;; If proc does not return, the port is not closed automatically, unless it is possible to prove that the port will never again be used for an I/O operation.</p>
;; .returns the values returned by proc.
(define (call-with-output-file filename proc)
  (let* ((port (open-output-file filename))
         (ret (proc port)))
    (close-output-port port)
    ret))

;; .pre-condition Proc should accept one argument.
;; <p>Open the file named by filename for input, with no specified file options, and call proc with the obtained port as an argument.</p>
;; <p>If proc returns, the port is closed automatically and the values returned by proc are returned.
;; If proc does not return, the port is not closed automatically, unless it is possible to prove that the port will never again be used for an I/O operation.</p>
;; .returns the values returned by proc.
(define (call-with-input-file filename proc)
  (let* ([port (open-input-file filename)]
         [ret (proc port)])
    (close-input-port port)
    ret))

;; <p>Returns two values: a textual output port and an extraction procedure.</p>
;; <p>The output port accumulates the characters written to it for later extraction by the procedure.</p>
;; <p>The extraction procedure takes no arguments.</p>
;; <p>When called, it returns a string consisting of all of the port's accumulated characters (regardless of the current position),removes the accumulated characters from the port, and resetsthe port's position</p>
;; .returns string-output-port, extraction procedure
(define  (open-string-output-port)
  (let* ([port (sys-open-output-string)]
         [proc (lambda () (let1 s (sys-get-output-string port)
                            (sys-port-seek port 0)
                            s))])
    (values port proc)))

;; <p>Creates a textual output port that accumulates the characters written to it and calls proc with that output port as an argument.</p>
;; <p>Whenever proc returns, a string consisting of all of the port's accumulated characters (regardless of the port's current position) is returned and the port is closed.</p>
;; .parameter proc proc must accept one argument
;; .returns accumulated characters as string
(define (call-with-string-output-port proc)
  (receive (port get-string) (open-string-output-port)
    (proc port)
    (get-string)))

;; <p>Creates an output port that accumulates the bytes written to it and calls proc with that output port as an argument.</p>
;; <p>Whenever proc returns, a bytevector consisting of all of the port's accumulated bytes (regardless of the port’s currentposition) is returned and the port is closed.</p>
;; .parameter proc proc must accept one argument
;; .returns accumulated bytes as bytevector
(define (call-with-bytevector-output-port proc transcoder)
  (receive (port get-bytevector) (open-bytevector-output-port transcoder)
    (proc port)
    (get-bytevector)))

;; <p>Returns two values: an output port and an extraction procedure.</p>
;; <p>The output port accumulates the bytes written to it for later extraction by the procedure.</p>
;; <p>If transcoder is a transcoder, it becomes the transcoder associated with the port.
;; If maybe-transcoder is #f or absent, the port will be a binary port and will support the port-position and set-port-position! operations.</p>
;; <p>The extraction procedure takes no arguments.
;; When called, it returns a bytevector consisting of all the port's accumulated bytes (regardless of the port’s current position), removes the accumulated bytes from the port, and resets the port's position.</p>
;; .parameter transcoder transcoder
;; .returns bytevector-output-port and extraction procedure
;; .todo when transcoder is empty or #f
(define  (open-bytevector-output-port transcoder)
  (let* ([port (sys-open-bytevector-output-port transcoder)]
         [proc (lambda () (sys-get-bytevector port))])
    (values port proc)))

;; Applies proc element-wise to the elements of the bytevector for its side effects, in order from the first elements to the last.
;; .parameter bv bytevector
;; .parameter proc proc must accept one argument
;; .returns unspecified
(define (bytevector-for-each bv proc)
  (let1 len (bytevector-length bv)
    (let loop ([i 0])
      (if (>= i len)
          '()
          (begin (proc (bytevector-u8-ref bv i))
                 (loop (+ i 1)))))))

;; <p><p>Writes a representation of obj to the given textual-output-port.</p></p>
;; <p>Strings that appear in the written representation are not enclosed in doublequotes, and no characters are escaped within those strings.</p>
;; <p>Character objects appear in the representation as if written by write-char instead of by write.</p>
;; <p>The textual-output-port argument may be omitted, in which case it defaults to the value returned by current-output-port.</p>
;; .form (display obj) or (display obj textual-output-port)
;; .returns unspecified
;; .parameter obj object to write.
;; .parameter textual-output-port writes obj to textual-output-port
(define (display x . port)
  (if (null? port)
      (sys-display x)
      (sys-display x (car port))))

;; <p>This is equivalent to using write-char to write #\linefeed to textual-output-port.
;; If textual-output-port is omitted, it defaults to the value returned by current-output-port.</p>
;; .parameter textual-output-port port to write
;; .returns unspecified
;; .todo textual-output-port
(define (newline . p) (apply display "\n" p))

; ==============================================================================================================================================================
;;; File system.
;;; R6RS library Chapter 9.
;; Returns #t if the named file exists at the time the procedure is called, #f otherwise.
;; .form (file-exists? filename)
;; .returns Returns #t if the named file exists at the time the procedure is called, #f otherwise.
(define-doc (file-exists?) ...)

; ==============================================================================================================================================================
;;; Hashtables.
;;; R6RS library Chapter 13.
;; <p>Returns a newly allocated mutable hashtable that accepts arbitrary objects as keys, and compares those keys with eq?. If an argument is given, the initial capacity of the hashtable is set to approximately k elements.</p>
;; .form (make-eq-hashtable) (make-eq-hashtable k)
;; .returns A newly allocated mutable hashtable that accepts arbitrary objects as keys, and compares those keys with eq?. If an argument is given, the initial capacity of the hashtable is set to approximately k elements.
(define-doc (make-eq-hashtable) ...)

;; Changes hashtable to associate key with obj, adding a new association or replacing any existing association for key.
;; .form (hashtable-set! hashtable key obj)
;; .returns unspecified
(define-doc (hashtable-set!) ...)

;; Returns the value in hashtable associated with key. If hashtable does not contain an association for key, default is returned.
;; .form (hashtable-ref hashtable key default)
;; .returns the value in hashtable associated with key. If hashtable does not contain an association for key, default is returned.
(define-doc (hashtable-ref) ...)

;; (not implmented) Returns a vector of all keys in hashtable. The order of the vector is unspecified.
;; .form (hashtable-keys hashtable)
;; .returns A vector of all keys in hashtable. The order of the vector is unspecified.
(define-doc (hashtable-keys) ...)

(define (hashtable-update! hashtable key proc default)
  (cond
   [(hashtable-mutable? hashtable)
    (hashtable-set!
     hashtable key
     (proc (hashtable-ref
            hashtable key default)))]
   [else
    (assertion-violation 'hashtable-update! "can't update! immutable hashtable")]))

(define (hashtable-entries hashtable)
  (let* ([keys (hashtable-keys hashtable)]
         [vals (make-vector (vector-length keys))])
    (let loop ([i 0])
      (cond
       [(>= i (vector-length keys))
        (values keys vals)]
       [else
        (vector-set! vals i (hashtable-ref hashtable (vector-ref keys i)))
        (loop (+ i 1))]))))

; ==============================================================================================================================================================
;;; Eval.
;;; R6RS library Chapter 16.
;; <p>Evaluates expression in the specified environment and returns its value.</p>
;; <p>Note that currently the environment argument is ignored.</p>
;; .returns result
;; .form (eval expression environment)
(define-doc (eval) ...)

; ==============================================================================================================================================================
;;; Mutable pairs.
;;; R6RS library Chapter 17.
;; Stores obj in the car field of pair.
;; .returns unspecified
;; .form (set-car! pair obj)
(define-doc (set-car!) ...)

;; Stores obj in the cdr field of pair.
;; .returns unspecified
;; .form (set-cdr! pair obj)
(define-doc (set-cdr!) ...)

; ==============================================================================================================================================================
;;; Regular expression.
;;; Regular expression is implmented with Oniguruma library.<br>

;; <p>Regexp is a regular expression object. A string string is matched by regexp. If it matches, the function returns a [regmatch] object. Otherwise it returns #f.</p>
;; <p>You can use (#/regexp/ string) style instead of (rxmatch #/regexp/ string).</p>
;; .returns If it matches, the function returns a [regmatch] object. Otherwise it returns #f.
;; .parameter regexp A regular expression object.
;; .parameter string String matched by regexp.
;; .form (rxmatch regexp string)
;; .example (rxmatch #/123/ "12") => #f
;; .example (rxmatch #/\d+/ "a345a") => [regmatch]
;; .internal-references "Regular expression." "regexp"
(define-doc (rxmatch) ...)

;; Regexp is a regular expression object. A string string is matched by regexp. If it matches, the function returns a [regmatch] object. Otherwise it returns #f.
;; .returns If it matches, the function returns a [regmatch] object. Otherwise it returns #f.
;; .parameter regexp A regular expression object.
;; .parameter string String matched by regexp.
;; .form (regexp string)
;; .example (#/123/ "12") => #f
;; .example (#/\d+/ "a345a") => [regmatch]
;; .internal-references "Regular expression." "rxmatch"
(define-doc (regexp) ...)


;; Returns #t if obj is a regexp object.
;; .form (regexp? obj)
;; .returns #t if obj is a regexp object.
;; .example (regexp? #/abc/) => #t
;; .example (regexp? "abc")  => #f
(define-doc (regexp?) ...)

;; Returns a source string describing the regexp regexp. The returned string is immutable.
;; .returns S source string describing the regexp regexp. The returned string is immutable.
;; .form (regexp->string regexp)
;; .example (regexp->string #/abc/) => "abc"
(define-doc (regexp->string) ...)

;; <p>If i equals to zero, the functions return start of entire match.
;; With positive integer I, it returns those of I-th submatches.</p>
;; <p>It is an error to pass other values to I.
;; It is allowed to pass #f to match for convenience.
;; The functions return #f in such case.</p>
;; .returns I-th submatches.
;; .form (rxmatch-start match &optional (i 0))
;; .parameter match [regmatch] object returned by rxmatch
;; .parameter i index
;; .example (rxmatch-start (#/\d+/ "aaaa")) => #f
;; .example (rxmatch-start (rxmatch #/(\d+)(a)/ "a345a") 2) => 4
(define-doc (rxmatch-start) ...)

;; <p>If i equals to zero, the functions return end of entire match.
;; With positive integer I, it returns those of I-th submatches.</p>
;; <p>It is an error to pass other values to I.
;; It is allowed to pass #f to match for convenience.
;; The functions return #f in such case.</p>
;; .returns I-th submatches.
;; .form (rxmatch-end match &optional (i 0))
;; .parameter match [regmatch] object returned by rxmatch
;; .parameter i index
;; .example (rxmatch #/\d+/ "a345a") => 4
(define-doc (rxmatch-end) ...)

;; <p>If i equals to zero, the functions return substring of entire match.
;; With positive integer I, it returns those of I-th submatches.</p>
;; <p>It is an error to pass other values to I.
;; It is allowed to pass #f to match for convenience.
;; The functions return #f in such case.</p>
;; .returns I-th submatches.
;; .form (rxmatch-substring match &optional (i 0))
;; .parameter match [regmatch] object returned by rxmatch
;; .parameter i index
;; .example (rxmatch-substring (#/\d+/ "a345a")) => "345"
(define-doc (rxmatch-substring) ...)

;; Returns substring of the input string after match.
;; If optional argument is given, the i-th submatch is used (0-th submatch is the entire match).
;; .returns Substring of the input string after match.
;; .form (rxmatch-after match &optional (i 0))
;; .example (rxmatch-after (#/abc/ "123abcdef")) => "def"
(define-doc (rxmatch-after) ...)

;; Returns substring of the input string before match.
;; If optional argument is given, the i-th submatch is used (0-th submatch is the entire match).
;; .returns Substring of the input string before match.
;; .form (rxmatch-before match &optional (i 0))
;; .example (rxmatch-before (#/abc/ "123abcdef")) => "123"
(define-doc (rxmatch-before) ...)

;; Works same as (rxmatch-substring regmatch index),
;; .form (regmatch &optional index)
;; .example ((#/abc/ "123abcdef") 0) => "abc"
;; .internal-references "Regular expression." "rxmatch-substring"
(define-doc (regmatch) ...)

;; Works same as (rxmatch-before regmatch)
;; .form  (regmatch 'before &optional index)
;; .example ((#/abc/ "123abcdef") 'before) => "123"
;; .internal-references "Regular expression." "rxmatch-before"
(define-doc (regmatch) ...)

;; Works same as (rxmatch-after regmatch)
;; .form  (regmatch 'after &optional index)
;; .example ((#/abc/ "123abcdef") 'after) => "def"
;; .internal-references "Regular expression." "rxmatch-after"
(define-doc (regmatch) ...)

;; Replaces the part of string that matched to regexp for substitution. Just replaces the first match of regexp.
;; .form (regexp-replace regexp string substitution)
;; .returns replaced string
;; .example (regexp-replace #/abc/ "123abc456" "ABC") => "123ABC456"
(define-doc (regexp-replace) ...)

;; Replaces the part of string that matched to regexp for substitution. Repeats the replacing throughout entire string.
;; .form (regexp-replace-all regexp string substitution)
;; .returns replaced string
(define-doc (regexp-replace-all) ...)

;; .form (string->regexp string)
;; Takes string as a regexp specification, and constructs [regexp] object.
;; .returns [regexp] object
;; .example (string->regexp "abc") #/abc
(define-doc (string->regexp) ...)

; ==============================================================================================================================================================
;;; System interfaces.

;; Returns the value of the environment variable name as a string, or #f if the environment variable is not defined.
;; .form (get-environment-variable name)
;; .returns The value of the environment variable name as a string, or #f if the environment variable is not defined.
;; .example (get-environment-variable "QUERY_STRING")
(define-doc (get-environment-variable) ...)

;; Returns names and values of all the environment variables as an a-list.
;; .form (get-environment-variables)
;; .returns Returns names and values of all the environment variables as an a-list.
;; .example (get-environment-variables)
(define-doc (get-environment-variables) ...)


;; Returns a list of strings of the directory entries.
;; .form (sys-readdir path)
;; .returns A list of strings of the directory entries.
(define-doc (sys-readdir) ...)

;; get-timeofday
;; .form (get-timeofday)
;; .returns (get-timeofday)
(define-doc (get-timeofday) ...)

; ==============================================================================================================================================================
;;; Generic.

;; Same as (let ((var val)) body ...)
;; .form (let1 var val body ...)
(define-doc (let1) ...)

;; Like map, map-to and for-each, except proc receives the index as the first argument.
;; .returns Like map, map-to and for-each, except proc receives the index as the first argument.
;; .example  (map-with-index list '(a b c d)) => ((0 a  (1 b) (2 c (3 d))
(define (map-with-index f l)
  (define (iter f l i)
    (if (null? l)
        l
        (cons (f i (car l)) (iter f (cdr l) (+ i 1)))))
  (iter f l 0))


;; concatnates symbols
;; .returns concatnated symbols
(define (symbol-concat . symbols)
  (define (concat a b)
    (if (null? b)
        a
        (string->symbol (string-append (symbol->string a) (symbol->string b)))))
  (let loop ([symbols symbols])
    (if (null? symbols)
        '()
        (concat (car symbols) (loop (cdr symbols))))))

;; Returns list of lines.
;; .returns list of lines.
(define (string->lines s)
  (string-split s #\newline))

;; Expand macro
;; .returns expanded only once macro form.(Now you can expand only top-level defined macro)
;; .form (macroexpand-1 form)
(define-doc (macroexpand-1) ...)

;; Expand macro
;; .returns expanded macro form.(Now you can expand only top-level defined macro)
;; .form (macroexpand form)
(define (macroexpand sexp)
  (let1 val (macroexpand-1 sexp)
    (if (equal? val sexp)
        sexp
        (macroexpand-1 val))))

;; Returns a new symbol.
;; .form (gensym)
;; .returns A new symbol.
;; .example (gensym) => G100
(define-doc (gensym) ...)

;; If given character char is a valid digit character in radix radix number, the corresponding integer is returned. Otherwise #f is returned.
;; .form (digit->integer char &optional (radix 10))
;; .returns If given character char is a valid digit character in radix radix number, the corresponding integer is returned. Otherwise #f is returned.
;; .example (digit->integer #\4) => 4
;; .example (digit->integer #\e 16) => 14
;; .example (digit->integer #\9 8) => #f
(define-doc (digit->integer) ...)

;; Writes a representation of obj to the current output port and (newline)
;; Strings that appear in the written representation are not enclosed in doublequotes, and no characters are escaped within those strings.
;; Character objects appear in the representation as if written by write-char instead of by write.
;; .returns unspecified values
(define (print obj)
  (display obj)
  (display "\n"))

;; The map1 procedure applies proc element-wise to the elements of the list and returns a list of the results, in order.
;; .parameter l list
;; .parameter proc should accept as many arguments as there are lists and return a single value.
;; .returns a list of the results
;; .form (map1 proc l)
(define (map1 f l)
    (if (null? l)
        l
        (cons (f (car l)) (map1 f (cdr l)))))

;; Returns the cdr of first pair whose car fields satisfies a given key.
;; .returns Returns the cdr of first pair whose car fields satisfies a given key.
(define (assoc-ref lst key)
  (cond [(assoc key lst) => cdr]
        [else #f]))

;; Reads one line (a sequence of characters terminated by newline or EOF) from port and returns a string.
;; .returns line as a string
(define (read-line . port)
  (let* ((char (apply read-char port)))
    (if (eof-object? char)
        char
        (letrec ((loop (lambda (char clist) (if (or (eof-object? char) (char=? #\newline char))
                                                (begin #f (list->string (reverse clist)))
                                                (begin (loop (apply read-char port) (cons char clist))))))) (loop char '())))))
;;         (do ((char char (apply read-char port))
;;              (clist '() (cons char clist)))
;;             ((or (eof-object? char) (char=? #\newline char))
;;              (list->string (reverse clist)))))))

;; Same as (call-with-output-file path (lambda (port) (display content obj)))
;; .returns unspecified.
;; .internal-references "R6RS" "call-with-output-file"
(define (write-to-file path content)
  (call-with-output-file path
    (lambda (port)
      (display content port))))

;; Read string from a file filename.
;; .returns whole file content as string
(define (file->string filename)
  (if (file-exists? filename)
      (call-with-input-file filename
        (lambda (p)
          (let loop ([ret '()][c (read-char p)])
            (if (eof-object? c)
                (list->string (reverse ret))
                (loop (cons c ret) (read-char p))))))
        ""))

;; <p>Convenient string I/O procedure.</p>
;; <pre>(define (call-with-string-io str proc)<br>
;;       (receive (out get-string) (open-string-output-port)<br>
;;         (let1 in (open-string-input-port str)<br>
;;           (proc in out)<br>
;;           (get-string))))</pre>
;; .returns output-string
(define (call-with-string-io str proc)
  (receive (out get-string) (open-string-output-port)
    (let1 in (open-string-input-port str)
      (proc in out)
      (get-string))))

;; Creates a textual input port from string str and calls proc with that input port as an argument.
;; .parameter proc proc must accept one argument
;; .returns values proc returns
(define (call-with-string-input-port str proc)
  (let ((in (open-string-input-port str)))
    (proc in)))

;; ; ==============================================================================================================================================================
;; ;;; CGI.
;; ;;; Note this library will go away once it is switched to the new CGI library.

;; ; used internal
;; (define cgi-header-out? #f)

;; ;; Escape some not safe characters.
;; ;; .returns escaped string
;; (define (cgi-escape text)
;;   (fold (lambda (x y) (regexp-replace-all (car x) y (cdr x)))
;;         text
;;         '(;(#/&/ . "&amp;")
;;           (#/</ . "&lt;")
;;           (#/>/ . "&gt;")
;; ;          (#/\"/ . "&quot;")
;;           (#/[^\\]'/ . "\'"))))

;; ;; Apply "% encode" to string and return the result. Assumes input is UTF-8.
;; ;; .returns encoded string
;; (define (cgi-encode text)
;;   (call-with-string-output-port
;;    (lambda(out)
;;      (bytevector-for-each
;;       (call-with-bytevector-output-port
;;        (lambda (port)
;;          (display  text port))
;;        (make-transcoder (utf-8-codec)))
;;       (lambda (b)
;;         (display "%" out)
;;         (display (number->string b 16) out))))))

;; ;; Initialize CGI library and returns get-parameter and get-request-method procedures.
;; ;; .returns get-parameter and get-request-method procedures as multiple values.
;; ;; .example (receive (get-parameter get-request-method) (cgi-init) ...)
;; (define (cgi-init)
;;   (let1 parsed (cgi-parse-query-string (get-request-body-cgi (get-request-method-cgi)))
;;     (values
;;      (lambda (key)
;;        (let ([value (assoc key parsed)])
;;          (if value
;;              (second value)
;;              #f)))
;;      get-request-method-cgi)))

;; ;; Outputs HTTP header "Status: 200 OK\nContent-type: text/html; charset=utf-8\n"
;; ;; .returns unspecified
;; (define (cgi-header)
;;   (unless cgi-header-out?
;;     (print "Status: 200 OK\nContent-type: text/html; charset=utf-8\n")
;;     (set! cgi-header-out? #t)))

;; ;; Outputs HTTP header "Status: 302 Moved Temporarily\nLocation: [url]\n\n"
;; ;; .parameter url redirect URL
;; ;; .returns unspecified
;; (define (cgi-moved-header url)
;;    (format #t "Status: 302 Moved Temporarily\nLocation: ~a\n\n" url)
;;    (set! cgi-header-out? #t))

;; ;; used internal
;; (define (cgi-parse-query-string input)
;;   (if (or (not (string? input)) (equal? "" input)) '()
;;   (fold-right
;;    (lambda (a b)
;;      (let [(params (string-split a #\=))]
;;        (cons (list (car params) (cadr params)) b)))
;;    '()
;;    (string-split input #\&))))

;; ;; Apply "% decode" to string and return the result.  Assumes input is UTF-8.
;; ;; .returns decoded string
;; (define (cgi-decode s)
;;   (call-with-string-io
;;    s
;;    (lambda (in out)
;;      (let1 p (transcoded-port
;;               (make-custom-binary-input-port
;;                "cgi decode"
;;                (lambda (bv start count)
;;                  (let1 read-byte (lambda ()
;;                                    (let1 c (read-char in)
;;                                      (cond
;;                                       [(eof-object? c) (eof-object)]
;;                                       [(eq? #\+ c) 32]
;;                                       [(eq? #\% c)
;;                                        (let ([a (digit->integer (read-char in) 16)]
;;                                              [b (digit->integer (read-char in) 16)])
;;                                          (+ (* a 16) b))]
;;                                       [else
;;                                        (char->integer c)])))
;;                    (let loop ([size 0]
;;                               [b (read-byte)])
;;                      (cond
;;                       [(eof-object? b) size]
;;                       [else
;;                        (bytevector-u8-set! bv (+ start size) b)
;;                        (if (>= (+ size 1) count)
;;                            '()
;;                            (loop (+ size 1) (read-byte)))]))))
;;                #f #f #f)
;;               (make-transcoder (utf-8-codec)))
;;        (let loop ([c (read-char p)])
;;          (cond
;;           [(eof-object? c) '()]
;;           [else
;;            (display c out)
;;            (loop (read-char p))]))))))

;; ; used internal
;; (define (get-request-method-command-line) (if (equal? (third (command-line)) "GET") 'GET 'POST))

;; ; used internal
;; (define (get-request-body-command-line method) (fourth (command-line)))

;; ; used internal
;; (define (get-request-method-cgi) (if (equal? (sys-getenv "REQUEST_METHOD") "GET") 'GET 'POST))

;; ; used internal
;; (define (get-request-body-cgi method)
;;   (case method
;;     [(POST)
;;      (let* ([content-length (sys-getenv "CONTENT_LENGTH")]
;;             [len            (if content-length (string->number content-length) 0)])
;;        (if (= 0 len)
;;            ""
;;            (utf8->string (get-bytevector-n (standard-input-port) len)))
;;              )]
;;     [else
;;      (sys-getenv "QUERY_STRING")]))

;; ; used internal
;; (define (cgi-print-env key)
;;   (format #t "(~a ~a)<br>" key (sys-getenv key)))

;; ; used internal for debug use.
;; (define (cgi-print-all-env)
;;   (for-each print-env '("HTTP_HOST" "CONTENT_LENGTH" "QUERY_STRING" "HTTP_COOKIE" "REQUEST_METHOD" "CONTENT_TYPE" "PATHINFO" "REQUEST_URI" "SCRIPT_NAME")))

; ==============================================================================================================================================================
;;; SRFI-1 List library.
;;; .section-id srfi-1

;; split-at splits the list x at index i, returning a list of the first i elements, and the remaining tail. It is equivalent to (values (take x i) (drop x i))
;; .returns (values (take x i) (drop x i))
(define (split-at x k)
  (check-arg integer? k split-at)
  (let recur ((lis x) (k k))
    (if (zero? k) (values '() lis)
    (receive (prefix suffix) (recur (cdr lis) (- k 1))
      (values (cons (car lis) prefix) suffix)))))

;; split-at! is the linear-update variant. It is allowed, but not required, to alter the argument list to produce the result.
;; .returns split-at! is the linear-update variant. It is allowed, but not required, to alter the argument list to produce the result.
(define (split-at! x k)
  (check-arg integer? k split-at!)
  (if (zero? k) (values '() x)
      (let* ((prev (drop x (- k 1)))
         (suffix (cdr prev)))
    (set-cdr! prev '())
    (values x suffix))))


;; Provided as a procedure as it can be useful as the termination condition for list-processing procedures that wish to handle all finite lists, both proper and dotted.
;; .returns (not (pair? x))
(define (not-pair? x) (not (pair? x)))
(define-macro (not-pair? x) `(not (pair? ,x)))

;; Determines list equality, given an element-equality procedure. Proper list A equals proper list B if they are of the same length, and their corresponding elements are equal, as determined by elt=. If the element-comparison procedure's first argument is from listi, then its second argument is from listi+1, i.e. it is always called as (elt= a b)  for a an element of list A, and b an element of list B.
(define (list= pred . lists)
  (or (null? lists) ; special case
      (let lp1 ((list-a (car lists)) (others (cdr lists)))
        (or (null? others)
            (let ((list-b (car others))
                  (others (cdr others)))
              (if (eq? list-a list-b)   ; EQ? => LIST=
                  (lp1 list-b others)
                  (let lp2 ((list-a list-a) (list-b list-b))
                    (if (null-list? list-a)
                        (and (null-list? list-b)
                             (lp1 list-b others))
                        (and (not (null-list? list-b))
                             (pred (car list-a) (car list-b))
                             (lp2 (cdr list-a) (cdr list-b)))))))))))


;; Of utility only as a value to be conveniently passed to higher-order procedures.
;; .returns (xcons '(b c) 'a) => (a b c)
;; .example (xcons '(b c) 'a) => (a b c)
(define (xcons d a) (cons a d))

;; Returns an n-element list, whose elements are all the value fill. If the fill argument is not given, the elements of the list may be arbitrary values.
;; .returns an n-element list, whose elements are all the value fill. If the fill argument is not given, the elements of the list may be arbitrary values.
;; .example (make-list 4 'c) => (c c c c)
(define (make-list len . maybe-elt)
  (check-arg (lambda (n) (and (integer? n) (>= n 0))) len make-list)
  (let ((elt (cond ((null? maybe-elt) #f) ; Default value
           ((null? (cdr maybe-elt)) (car maybe-elt))
           (else (error 'make-list "Too many arguments to MAKE-LIST"
                (cons len maybe-elt))))))
    (letrec ((loop (lambda (i ans) (if (<= i 0) (begin #f ans) (begin (loop (- i 1) (cons elt ans))))))) (loop len '()))))
;;     (do ((i len (- i 1))
;;      (ans '() (cons elt ans)))
;;     ((<= i 0) ans))))

;; Returns an n-element list. Element i of the list, where 0 <= i < n, is produced by (init-proc i). No guarantee is made about the dynamic order in which init-proc is applied to these indices.
;; .returns an n-element list. Element i of the list, where 0 <= i < n, is produced by (init-proc i). No guarantee is made about the dynamic order in which init-proc is applied to these indices.
;; .example list-tabulate 4 values) => (0 1 2 3)
(define (list-tabulate len proc)
  (check-arg (lambda (n) (and (integer? n) (>= n 0))) len list-tabulate)
  (check-arg procedure? proc list-tabulate)
  (letrec ((loop (lambda (i ans) (if (< i 0) (begin #f ans) (begin (loop (- i 1) (cons (proc i) ans))))))) (loop (- len 1) '())))
;;   (do ((i (- len 1) (- i 1))
;;        (ans '() (cons (proc i) ans)))
;;       ((< i 0) ans)))

;; Copies the spine of the argument.
;; .returns copied list
(define (list-copy lis)
  (let recur ((lis lis))
    (if (pair? lis)
        (cons (car lis) (recur (cdr lis)))
        lis)))

;; Returns the last pair in the non-empty, finite list pair.
;; .returns the last pair in the non-empty, finite list pair.
;; .example (last-pair '(a b c)) => (c)
(define (last-pair lis)
  (check-arg pair? lis last-pair)
  (let lp ((lis lis))
    (let ((tail (cdr lis)))
      (if (pair? tail) (lp tail) lis))))

;; Returns the last element of the non-empty, finite list pair.
;; .returns the last element of the non-empty, finite list pair.
;; .example (last '(a b c)) => c
(define (last lis) (car (last-pair lis)))

;; Constructs a circular list of the elements.
;; .returns Constructs a circular list of the elements.
;; .example (circular-list 'z 'q) => (z q z q z q ...)
(define (circular-list val1 . vals)
  (let ((ans (cons val1 vals)))
    (set-cdr! (last-pair ans) ans)
    ans))

;; .returns #t iff x is a proper list -- a finite, nil-terminated list.
;; Returns true iff x is a proper list -- a finite, nil-terminated list. More carefully: The empty list is a proper list.
(define (proper-list? x)
  (let lp ((x x) (lag x))
    (if (pair? x)
        (let ((x (cdr x)))
          (if (pair? x)
              (let ((x   (cdr x))
                    (lag (cdr lag)))
                (and (not (eq? x lag)) (lp x lag)))
              (null? x)))
        (null? x))))

;; .returns #t if x is a circular list. A circular list is a value such that for every n >= 0, cdrn(x) is a pair.
;; True if x is a circular list. A circular list is a value such that for every n >= 0, cdrn(x) is a pair.
(define (circular-list? x)
  (let lp ((x x) (lag x))
    (and (pair? x)
         (let ((x (cdr x)))
           (and (pair? x)
                (let ((x   (cdr x))
                      (lag (cdr lag)))
                  (or (eq? x lag) (lp x lag))))))))

;; .returns #t if x is a finite, non-nil-terminated list. That is, there exists an n >= 0 such that cdrn(x) is neither a pair nor (). This includes non-pair, non-() values (e.g. symbols, numbers), which are considered to be dotted lists of length 0.
;; True if x is a finite, non-nil-terminated list. That is, there exists an n >= 0 such that cdrn(x) is neither a pair nor (). This includes non-pair, non-() values (e.g. symbols, numbers), which are considered to be dotted lists of length 0.
(define (dotted-list? x)
  (let lp ((x x) (lag x))
    (if (pair? x)
        (let ((x (cdr x)))
          (if (pair? x)
              (let ((x   (cdr x))
                    (lag (cdr lag)))
                (and (not (eq? x lag)) (lp x lag)))
              (not (null? x))))
        (not (null? x)))))





;; Returns the first i elements of list x.
;; .returns the first i elements of list x.
(define (take lis k)
  (check-arg integer? k take)
  (let recur ((lis lis) (k k))
    (if (zero? k) '()
    (cons (car lis)
          (recur (cdr lis) (- k 1))))))

;; Returns all but the first i elements of list x.
;; .returns all but the first i elements of list x.
(define (drop lis k)
  (check-arg integer? k drop)
  (let iter ((lis lis) (k k))
    (if (zero? k) lis (iter (cdr lis) (- k 1)))))

;; take! is linear-update variants of take. The procedure is allowed, but not required, to alter the argument list to produce the result.
;; .returns take! is linear-update variant of take. The procedure is allowed, but not required, to alter the argument list to produce the result.
(define (take! lis k)
  (check-arg integer? k take!)
  (if (zero? k) '()
      (begin (set-cdr! (drop lis (- k 1)) '())
         lis)))

;; Returns the last i elements of flist.
;; .returns the last i elements of flist.
(define (take-right lis k)
  (check-arg integer? k take-right)
  (let lp ((lag lis)  (lead (drop lis k)))
    (if (pair? lead)
    (lp (cdr lag) (cdr lead))
    lag)))

;; Returns all but the last i elements of flist.
;; .returns all but the last i elements of flist.
(define (drop-right lis k)
  (check-arg integer? k drop-right)
  (let recur ((lag lis) (lead (drop lis k)))
    (if (pair? lead)
    (cons (car lag) (recur (cdr lag) (cdr lead)))
    '())))

;; drop-right! is linear-update variant of drop-right: the procedure is allowed, but not required, to alter the argument list to produce the result.
;; .returns drop-right! is linear-update variant of drop-right: the procedure is allowed, but not required, to alter the argument list to produce the result.
(define (drop-right! lis k)
  (check-arg integer? k drop-right!)
  (let ((lead (drop lis k)))
    (if (pair? lead)

    (let lp ((lag lis)  (lead (cdr lead)))  ; Standard case
      (if (pair? lead)
          (lp (cdr lag) (cdr lead))
          (begin (set-cdr! lag '())
             lis)))
    '())))  ; Special case dropping everything -- no cons to side-effect.

;; .form (first pair)
;; .returns (car pair)
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for car
(define first car)

;; .returns (cadr pair)
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for cadr
(define (second pair) (cadr pair))

;; .returns (caddr pair)
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for caddr
(define (third pair) (caddr pair))

;; .returns (cadddr pair)
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for cadddr
(define (fourth pair) (cadddr pair))

;; .returns (car (cddddr x))
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for (car (cddddr x))
(define (fifth x) (car (cddddr x)))

;; .returns (cadr   (cddddr x))
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for (cadr   (cddddr x))
(define (sixth   x) (cadr   (cddddr x)))

;; .returns (caddr  (cddddr x))
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for (caddr  (cddddr x))
(define (seventh x) (caddr  (cddddr x)))

;; .returns (cadddr (cddddr x))
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for (cadddr (cddddr x))
(define (eighth  x) (cadddr (cddddr x)))

;; .returns (car  (cddddr (cddddr x)))
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for (car  (cddddr (cddddr x)))
(define (ninth   x) (car  (cddddr (cddddr x))))

;; .returns (cadr (cddddr (cddddr x)))
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
;; Synonym for (cadr (cddddr (cddddr x)))
(define (tenth   x) (cadr (cddddr (cddddr x))))


; Copyright (c) 1998, 1999 by Olin Shivers. You may do as you please with
; this code as long as you do not remove this copyright notice or
; hold me liable for its use. Please send bug reports to shivers@ai.mit.edu.
;; .form (cons* elt1 elt2 ...)
;; .returns (cons elt1 (cons elt2 (cons ... eltn)))
;; .example (cons* 1 2 3 4) => (1 2 3 . 4)
;; .example (cons* 1) => 1
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
(define (cons* first . rest)
  (let recur ((x first) (rest rest))
    (if (pair? rest)
        (cons x (recur (car rest) (cdr rest)))
        x)))

;The fundamental pair deconstructor:

;; same as (lambda (p) (values (car p) (cdr p)))
;; .returns (values  (car p) (cdr p))
(define (car+cdr pair) (values (car pair) (cdr pair)))

;; Returns true if the argument is the empty list (), and false otherwise. It is an error to pass this procedure a value which is not a proper or circular list. This procedure is recommended as the termination condition for list-processing procedures that are not defined on dotted lists.
;; .returns true if the argument is the empty list (), and false otherwise.
;; .pre-condition List is a proper or circular list.
;; .form (null-list? list)
(define (null-list? l)
  (cond ((pair? l) #f)
    ((null? l) #t)
    (else (error 'null-list? "argument out of domain" l))))

(define (check-arg pred val caller)
  (let lp ((val val))
    (if (pred val) val (lp (raise (format "Bad argument ~a ~a ~a" val pred caller))))))

(define (%cars+cdrs lists)
  (call-with-current-continuation
    (lambda (abort)
      (let recur ((lists lists))
        (if (pair? lists)
        (receive (list other-lists) (car+cdr lists)
          (if (null-list? list) (abort '() '()) ; LIST is empty -- bail out
          (receive (a d) (car+cdr list)
            (receive (cars cdrs) (recur other-lists)
              (values (cons a cars) (cons d cdrs))))))
        (values '() '()))))))

; Like %CARS+CDRS, but we pass in a final elt tacked onto the end of the
; cars list. What a hack.
(define (%cars+cdrs+ lists cars-final)
  (call-with-current-continuation
    (lambda (abort)
      (let recur ((lists lists))
        (if (pair? lists)
        (receive (list other-lists) (car+cdr lists)
          (if (null-list? list) (abort '() '()) ; LIST is empty -- bail out
          (receive (a d) (car+cdr list)
            (receive (cars cdrs) (recur other-lists)
              (values (cons a cars) (cons d cdrs))))))
        (values (list cars-final) '()))))))



;; Like map, but only true values are saved.
;; .returns Like map, but only true values are saved.
;; .example (filter-map (lambda (x) (and (number? x) (* x x))) '(a 1 b 3 c 7)) => (1 9 49)
;; .reference "SRFI-1" "SRFI-1 List Library" "http://srfi.schemers.org/srfi-1/srfi-1.html"
(define (filter-map f lis1 . lists)
  (check-arg procedure? f filter-map)
  (if (pair? lists)
      (let recur ((lists (cons lis1 lists)))
    (receive (cars cdrs) (%cars+cdrs lists)
      (if (pair? cars)
          (cond ((apply f cars) => (lambda (x) (cons x (recur cdrs))))
            (else (recur cdrs))) ; Tail call in this arm.
          '())))

      ;; Fast path.
      (let recur ((lis lis1))
    (if (null-list? lis) lis
        (let ((tail (recur (cdr lis))))
          (cond ((f (car lis)) => (lambda (x) (cons x tail)))
            (else tail)))))))


; ==============================================================================================================================================================
;;; SRFI-8 Binding to multiple values.
;; <p>This is the way to receive multiple values.</p>
;; <p>Formals can be a (maybe-improper) list of symbols.</p>
;; <p>Expression is evaluated, and the returned value(s) are bound to formals like the binding of lambda formals, then body ... are evaluated.</p>
;; .form (receive formals expression body ...)
;; .returns The results of the last expression in the body are the values of the receive-expression.
;; .example (receive (a b c) (values 1 2 3) (+ a b c)) => 6
(define-doc (receive . args) ...)

; ==============================================================================================================================================================
;;; SRFI-28 Basic format strings.
;; <p>Format arg ... according to string.</p>
;; <p>port specifies the destination;</p>
;; <p>if it is an output port, the formatted result is written to it;</p>
;; <p>if it is #t, the result is written to the current output port;</p>
;; <p>if it is #f, the formatted result is returned as a string.</p>
;; <p>Port can be omitted, as SRFI-28 format; it has the same effects as giving #f to the port.</p>
;; <p>string is a string that contains format directives.</p>
;; <p>A format directive is a character sequence begins with tilda, `~', and ends with some specific characters.</p>
;; <p>The rest of string is copied to the output as is.</p>
;; <p>Currently supported directive is ~a/~A (The corresponding argument is printed by display.), ~s/~S (The corresponding argument is printed by write.)</p>
;; .form (format string arg ...) (format port string arg ...)
;; .returns unspecified or string
;; .example (format #f "apple is ~a" "sweet") => "apple is sweet"
;; .example (call-with-output-string (lambda (out) (format out "apple is ~a" "sweet"))) => "apple is sweet"
(define-doc (format) ...)



; vector-type for Record
(define (vector-type-predicate vt)
  (lambda (v)
    (vector-type-instance-of? v vt)))

(define (typed-vector-constructor vt)
  (lambda args
    (make-typed-vector vt args)))

(define (typed-vector-accessor vt pos)
  (lambda (v)
    (if ((vector-type-predicate vt) v)
        (typed-vector-get-nth v pos)
        (errorf "typed-vector-accessor required ~a, but got ~a" vt (typed-vector-type v)))))

(define (typed-vector-mutator vt pos)
  (lambda (v val)
    (if ((vector-type-predicate vt) v)
        (typed-vector-set-nth v pos val)
        (errorf "typed-vector-mutator required ~a, but got ~a" vt (typed-vector-type v)))))


(define-macro (receive . args)
 `(call-with-values (lambda () ,(cadr args)) (lambda ,(car args) ,@(cddr args))))

(define-macro (acond . clauses)
  (if (null? clauses)
      '()
      (let ((cl1 (car clauses))
            (sym (gensym)))
        `(let ((,sym ,(car cl1)))
           (if ,sym
               (let ((it ,sym)) ,@(cdr cl1))
               (acond ,@(cdr clauses)))))))

; todo check malformed guard
(define-macro (guard x . body)
  `(call/cc
    (lambda (cont)
      (with-exception-handler
       (lambda (,(car x))
         (cont (cond ,@(cdr x))))
       (lambda ()
         ,@body)))))

;; todo document

(define (hashtable-for-each proc ht)
  (let1 keys (hashtable-keys ht)
    (vector-for-each
     (lambda (key)
       (proc key (hashtable-ref ht key)))
     keys)))


(define (hashtable-map proc ht)
  (let1 keys (vector->list (hashtable-keys ht))
    ($map1
     (lambda (key)
       (proc key (hashtable-ref ht key)))
     keys)))


; From elk start.
; http://www-rn.informatik.uni-bremen.de/software/elk/dist.html
;; (define (sort obj pred)
;;   (vector->list (sort! (list->vector obj) pred)))

;; (define (sort! v pred)
;;     (define (internal-sort l r)
;;       (let ((i l) (j r) (x (vector-ref v (/ (- (+ l r) 1) 2))))
;;     (let loop ()
;;          ;; do macro needs match macro!
;;          (letrec ((loop (lambda () (if (not (pred (vector-ref v i) x)) (begin #f) (begin (set! i (+ 1 i)) (loop)))))) (loop))
;; ;         (do () ((not (pred (vector-ref v i) x))) (set! i (+ 1 i)))
;;          (letrec ((loop (lambda () (if (not (pred x (vector-ref v j))) (begin #f) (begin (set! j (- j 1)) (loop)))))) (loop))
;; ;         (do () ((not (pred x (vector-ref v j)))) (set! j (- j 1)))
;;          (if (<= i j)
;;          (let ((temp (vector-ref v i)))
;;            (vector-set! v i (vector-ref v j))
;;            (vector-set! v j temp)
;;            (set! i (+ 1 i))
;;            (set! j (- j 1))))
;;          (if (<= i j)
;;              (loop)))
;;     (if (< l j)
;;         (internal-sort l j))
;;     (if (< i r)
;;         (internal-sort i r))))
;;   (let ((len (vector-length v)))

;;     (if (> len 1)
;;     (internal-sort 0 (- len 1)))
;;     v))
; From elk end

(define (lpad str pad n)
  (let1 rest (- n (string-length (format "~a" str)))
    (let loop ([rest rest]
               [ret (format "~a" str)])
      (if (<= rest 0)
          ret
          (loop (- rest 1) (string-append pad ret))))))

(define (rpad str pad n)
  (let1 rest (- n (string-length (format "~a" str)))
    (let loop ([rest rest]
               [ret (format "~a" str)])
      (if (<= rest 0)
          ret
          (loop (- rest 1) (string-append ret pad))))))


; Result is returned by Object VM::getProfileResult()
; Format is '(total-sample-count ((proc1 . call-count) (proc2 . call-count) ...) sampled-proc1 sampled-proc2 ...)
; Example (define result '(69 ((generic-assoc . 10000) (hoge . 3) (hige . 13) (append . 100000000) ($append-map1-sum . 2)) generic-assoc $append-map1-sum))
;; (define (show-profile result)
;;   (let ([total (first result)]
;;         [calls-hash (second result)]
;;         [syms  (cddr result)]
;;         [table (make-eq-hashtable)])
;;     (print "time%        msec      calls   name")
;;     (let loop ([syms syms])
;;       (cond
;;        [(null? syms)
;;           '()]
;;        [else
;;         (aif (hashtable-ref table (car syms) #f)
;;              (hashtable-set! table (car syms) (+ it 1))
;;              (hashtable-set! table (car syms) 1))
;;         (loop (cdr syms))]))
;;     (print "before")
;;     (print calls-hash)
;;     (print (hashtable-map
;;             (lambda (key value)
;;               (cons key value))
;;             calls-hash))
;;     (print "after")
;;     (for-each
;;      (lambda (x)
;;        (print (car x))
;;        (aif (hashtable-ref calls-hash (first x) #f)
;;          (format #t " ~a   ~a ~a   ~a    ~a\n"
;;                  (lpad (third x) " " 3)
;;                  (lpad (* (second x) 10) " " 10)
;;                  (lpad it " " 10)
;;                  (rpad (first x) " " 30))
;;          (format #t " ~a   ~a ~a   ~a    ~a\n"
;;                  (lpad (third x) " " 3)
;;                  (lpad (* (second x) 10) " " 10)
;;                  (lpad "?" " " 10)
;;                  (rpad (first x) " " 30))
;;         ))
;;      (sort
;;       (hashtable-map
;;        (lambda (key value)
;;          (list key value (/ (* 100 value) total)))
;;        table)
;;       (lambda (x y) (> (third x) (third y)))))))
;; ;;     (let1 seen-syms (vector->list (hashtable-keys table))
;; ;;       (for-each
;; ;;        (lambda (p)
;; ;;          (format #t "   0            0 ~a   ~a\n" (lpad (cdr p) " " 10) (rpad (car p) " " 30)))
;; ;;        ($take (sort (filter (lambda (x) (not (memq (car x) seen-syms))) calls) (lambda (a b) (> (cdr a) (cdr b)))) 30)))
;; ;;     (format #t "  **   ~d          **   total\n" (lpad (* (* total 10)) " " 10))))

;;; Pattern matching.
;;; A port of Andrew Wright's pattern matching macro library.
;;; See the Gauche's pattern match document
;; .reference "Gauche's manual" "match" "http://practical-scheme.net/gauche/man/gauche-refe_163.html#SEC439"
(define-doc (match) ...)


; used internal.
(define-doc (load) ...)

(define (string->list str)
  (let loop ((pos (- (string-length str) 1)) (l '()))
    (if (< pos 0)
        l
      (loop (- pos 1) (cons (string-ref str pos) l)))))


(define-macro (aif test-form then-form . else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,@else-form)))

(define suma (lambda ()3))

(define-macro (define-simple-struct name . elements)
  `(begin
     (define (,(symbol-concat 'make- name) ,@elements)
       (vector ,@elements))
     ,@(map-with-index (lambda (i element) `(define (,(symbol-concat name '- element) x) (vector-ref x ,i))) elements)
     ,@(map-with-index (lambda (i element) `(define (,(symbol-concat name '- 'set '- element '!) x v) (vector-set! x ,i v))) elements)))

(define (hashtable-keys->list ht)
  (vector->list (hashtable-keys ht)))

(define (hashtable->alist ht)
  (hashtable-map cons ht))

(define (get-closure-name closure)
  (aif (%get-closure-name closure)
       it
       'anonymous))


(define (string-chop s len . tail)
  (cond
   [(> (string-length s) len)
     (let1 ret (make-string len)
       (let loop ([i 0])
         (if (>= i len)
           (if (pair? tail)
               (string-append ret (car tail))
               ret)
           (begin
             (string-set! ret i (string-ref s i))
             (loop (+ i 1))))))]
    [else s]))


; If you see "display closure" at name column of profiler results.
; Higepon can improve the result.
; See set-source-info! on compiler and $let.src.
(define (show-profile result)
  (let ([total (first result)]
        [calls-hash (second result)]
        [sample-closures  (cddr result)]
        [sample-table (make-eq-hashtable)])
    ; collect sampled closures into sample-table
    ;   key   => #<closure>
    ;   value => sampling count
    (for-each (lambda (closure)
                (aif (hashtable-ref  sample-table closure #f)
                     (hashtable-set! sample-table closure (+ it 1))
                     (hashtable-set! sample-table closure 1)))
                sample-closures)
    (print "time%        msec      calls   name                              location")
    (for-each
     (lambda (x)
       (let* ([closure  (first x)]
              [src      (source-info closure)]
              [name     (string-chop (format "~a" (if src (cdr src) (get-closure-name closure))) 25 "...)")]
              [location (if src (car src) #f)]
              [file     (if location (car location) #f)]
              [lineno   (if location (second location) #f)]
              [count    (aif (hashtable-ref calls-hash closure #f) it "-")])
         (format #t " ~a   ~a ~a   ~a    ~a\n"
                 (lpad (third x) " " 3)
                 (lpad (* (second x) 10) " " 10)
                 (lpad count " " 10)
                 (rpad name " " 30)
                 (if file (format "~a:~d" file lineno) "")
                 )
        ))
     (list-sort
      (lambda (x y) (> (second x) (second y)))
      (hashtable-map
       (lambda (closure sample-count)
         (list closure sample-count (/ (* 100 sample-count) total)))
       sample-table)
      )
     )
    (let1 seen-syms (vector->list (hashtable-keys sample-table))
      ;; (for-each
;;        (lambda (p)
;;          (let* ([closure (car p)]
;;                 [count  (cdr p)]
;;                 [src      (source-info closure)]
;;                 [name     (string-chop (format "~a" (if src (cdr src) (get-closure-name closure))) 25 "...)")]
;;                 [location (if src (car src) #f)]
;;                 [file     (if location (car location) #f)]
;;                 [lineno   (if location (second location) #f)])
;;          (format #t "   0            0 ~a   ~a    ~a\n"
;;                  (lpad count " " 10)
;;                  (rpad name " " 30)
;;                  (if file (format "~a:~d" file lineno) "")
;;                  )))
;;        (let1 filterd (filter (lambda (x) (not (memq (car x) seen-syms))) (hashtable->alist calls-hash))
;;          (let1 sorted (sort filterd (lambda (a b) (> (cdr a) (cdr b))))
;;        ($take  sorted 30))))
    (format #t "  **   ~d         **   total\n" (lpad (* (* total 10)) " " 10)))))

;; ;; temp
;; (define (append! l1 l2)
;;   (cond ((pair? l1)
;;          (if (pair? (cdr l1))
;;              (append! (cdr l1) l2)
;;              (set-cdr! l1 l2) )
;;          l1 )
;;         (else l2) ) )

;; for psyntax.pp
(define (void) (if #f #f))
(define (eval-core x) (eval x '()))

  (define (ellipsis-map proc ls . ls*)
    (apply map proc ls ls*))


(define (exact? n) #t)
(define (real? n) (number? n))
(define (nan? n) (not (number? n)))

(define (exists proc lst . lists)
  (define (exists-1 proc lst1)
    (if (null? lst1)
        #f
        (let loop ([lst lst1])
          (cond
           [(not (pair? lst))
            (assertion-violation 'exists "proper list required" lst1)]
           [(proc (car lst))
            => (lambda (ret)
                 ret)]
           [else
            (if (null? (cdr lst))
                #f
                (loop (cdr lst)))]))))
  (define (exists-n proc list-n)
    (define (map-car l)
      (let loop ([l l])
        (cond
         [(null? l)
          '()]
         [(pair? (car l))
          (cons (caar l) (loop (cdr l)))]
         [else
          (assertion-violation 'exists "the lists all should have the same length" list-n)])))
    (if (null*? list-n)
        #f
        (let loop ([head (map-car list-n)]
                   [rest (map cdr list-n)])
          (if (null? (car rest))
              (apply proc head)
              (or (apply proc head)
                   (loop (map-car rest) (map cdr rest)))))))
  (if (null? lists)
      (exists-1 proc lst)
      (exists-n proc (cons lst lists))))

(define (partition proc lst)
  (let loop ([lst lst]
             [lst1 '()]
             [lst2 '()])
    (if (null? lst)
        (values (reverse lst1) (reverse lst2))
        (let ([var (car lst)])
          (if (proc var)
              (loop (cdr lst) (cons var lst1) lst2)
              (loop (cdr lst) lst1 (cons var lst2)))))))


(define (expt n m)
  (let loop ([i m]
             [ret 1])
    (if (>= 0 i)
        ret
        (loop (- i 1) (* ret n)))))


;; dynamic-wind implementation
;;   The Scheme Programming Language
;;   Third Edition by R. Kent Dybvig.
(define (dynamic-wind before thunk after) #f)
(define (call/cc cont) #f)
(define (call-with-current-continuation cont) #f)

(let ((winders '()))
  (define common-tail
    (lambda (x y)
      (let ((lx (length x)) (ly (length y)))
        ;; (do ((x (if (> lx ly) (list-tail x (- lx ly)) x) (cdr x))
;;              (y (if (> ly lx) (list-tail y (- ly lx)) y) (cdr y)))
;;             ((eq? x y) x))
        (letrec ([loop (lambda (x y)
                         (if (eq? x y)
                             x
                             (loop (cdr x) (cdr y))))])
          (loop (if (> lx ly)
                    (list-tail x (- lx ly))
                    x)
                (if (> ly lx)
                    (list-tail y (- ly lx))
                    y))))))
  (define do-wind
    (lambda (new)
      (let ((tail (common-tail new winders)))
        (let f ((l winders))
          (if (not (eq? l tail))
              (begin
                (set! winders (cdr l))
                ((cdar l))
                (f (cdr l)))))
        (let f ((l new))
          (if (not (eq? l tail))
              (begin
                (f (cdr l))
                ((caar l))
                (set! winders l)))))))
  (set! call/cc
      (lambda (f)
        (%call/cc (lambda (k)
             (f (let ((save winders))
                  (lambda x
                    (if (not (eq? save winders)) (do-wind save))
                    (apply k x))))))))
  (set! call-with-current-continuation call/cc)
  (set! dynamic-wind
    (lambda (in body out)
      (in)
      (set! winders (cons (cons in out) winders))
      ;; we need multiple values
      (receive ans (body)
        (set! winders (cdr winders))
        (out)
        (apply values ans)))))

;; srfi-39 parameter objects
(define make-parameter
  (lambda (init . conv)
    (let ((converter
           (if (null? conv) (lambda (x) x) (car conv))))
      (let ((global-cell
             (cons #f (converter init))))
        (letrec ((parameter
                  (lambda new-val
                    (let ((cell (dynamic-lookup parameter global-cell)))
                      (cond ((null? new-val)
                             (cdr cell))
                            ((null? (cdr new-val))
                             (set-cdr! cell (converter (car new-val))))
                            (else ; this case is needed for parameterize
                             (converter (car new-val))))))))
          (set-car! global-cell parameter)
          parameter)))))

(define-macro (parameterize . sexp)
  (let ([expr1 (map first (car sexp))]
        [expr2 (map second (car sexp))]
        [body (cdr sexp)])
    `(dynamic-bind (list ,@expr1)
                   (list ,@expr2)
                   (lambda () ,@body))))

(define dynamic-bind
  (lambda (parameters values body)
    (let* ((old-local
            (dynamic-env-local-get))
           (new-cells
            (map (lambda (parameter value)
                   (cons parameter (parameter value #f)))
                 parameters
                 values))
           (new-local
            (append new-cells old-local)))
      (dynamic-wind
          (lambda () (dynamic-env-local-set! new-local))
          body
          (lambda () (dynamic-env-local-set! old-local))))))

(define dynamic-lookup
  (lambda (parameter global-cell)
    (or (assq parameter (dynamic-env-local-get))
        global-cell)))

(define dynamic-env-local '())

(define dynamic-env-local-get
  (lambda () dynamic-env-local))

(define dynamic-env-local-set!
  (lambda (new-env) (set! dynamic-env-local new-env)))

(define current-exception-handler (make-parameter #f))
(define parent-exception-handler (make-parameter #f))

;; borrowed from ypsilon scheme by Yoshikatsu Fujita
(define (with-exception-handler new thunk)
  (let ((parent (current-exception-handler)))
    (parameterize
        ((parent-exception-handler parent)
         (current-exception-handler
          (lambda (condition)
            (parameterize ((current-exception-handler parent))
              (new condition)))))
      (thunk))))

(define (condition-printer c)
  (if (condition? c)
  (receive (out get-string) (open-string-output-port)
    (for-each
     (lambda (x)
       (cond
        [(record? x)
         (let ([rtd (record-rtd x)])
           (format out "   ~d. ~a" 0 (record-type-name rtd))
           (let ([v (record-type-field-names rtd)])
             (case (vector-length v)
               [(0) (newline out)]
               [(1)
                (display ": " out)
                (write ((record-accessor rtd 0) x) out)
                (newline out)]
               [else
                (display ":\n" out)
                (let f ([i 0])
                  (unless (= i (vector-length v))
                    (display "       " out)
                    (display (vector-ref v i) out)
                    (display ": " out)
                    (write ((record-accessor rtd i) x) out)
                    (newline out)
                    (f (+ i 1))))])))]
        [else
         (display x out)]))
     (simple-conditions c))
    (get-string))
  c))


(define (raise c)
  (when (and (not (condition? c)) (not (string? c)))
    (format #t "Warning: raise arguments is wrong. condition expected but got ~a\n" c))
  (cond ((current-exception-handler)
         => (lambda (proc)
              (proc c)
              (cond ((parent-exception-handler)
                     => (lambda (proc)
                          (proc c))))
              (throw "    in raise: returned from non-continuable exception"))))
    (throw (format "    Unhandled exception\n\n~a" (condition-printer c))))


(define (raise-continuable c)
  (cond ((current-exception-handler)
         => (lambda (proc) (proc c)))
        (else
         (error 'raise-continuable "unhandled exception has occurred" c))))

(define (get-string-n port count)
  "")

(define (symbol-append . symbols)
  (string->symbol (apply string-append (map symbol->string symbols))))

(define-macro (define-simple-struct name fields)
  (let ([rtd (symbol-append name '- 'rtd)]
        [rcd (symbol-append name '- 'rcd)]
        [accessors (map (lambda (field) (symbol-append name '- field)) fields)]
        [field-set (list->vector (map (lambda (field) (list 'mutable field)) fields))]
        [constructor (symbol-append 'make- name)])
     `(begin
        (define ,rtd
          (make-record-type-descriptor
           ',name #f #f #f #f
           ',field-set))
        (define ,rcd
          (make-record-constructor-descriptor
           ,rtd #f #f))
        (define ,constructor
          (record-constructor ,rcd))
        ,@(let loop ([i 0]
                     [accessors accessors]
                     [ret '()])
           (if (null? accessors)
               ret
               (loop (+ i 1) (cdr accessors) (cons (list 'define (car accessors) (list 'record-accessor rtd i) ) ret))))
        )))

(define-macro (t exp equal expected )
  (let ([val (gensym)])
    `(let ([,val ,exp])
       (unless (equal? ,expected ,val)
         (error 'test (format "~a failed" ',exp) (list ,expected '=> ,val))))))

;(define-simple-struct enum-set (type members))
(begin (define enum-set-rtd (make-record-type-descriptor 'enum-set #f #f #f #f '#((mutable type) (mutable members)))) (define enum-set-rcd (make-record-constructor-descriptor enum-set-rtd #f #f)) (define make-enum-set (record-constructor enum-set-rcd)) (define enum-set-members (record-accessor enum-set-rtd 1)) (define enum-set-type (record-accessor enum-set-rtd 0)))

;; (define-simple-struct enum-type (universe indexer))
(begin (define enum-type-rtd (make-record-type-descriptor 'enum-type #f #f #f #f '#((mutable universe) (mutable indexer)))) (define enum-type-rcd (make-record-constructor-descriptor enum-type-rtd #f #f)) (define make-enum-type (record-constructor enum-type-rcd)) (define enum-type-indexer (record-accessor enum-type-rtd 1)) (define enum-type-universe (record-accessor enum-type-rtd 0)))

(define (make-enumeration-type symbol-list)
  (let ([ht (make-eq-hashtable)])
    (let loop ([symbol-list symbol-list]
               [i 0])
      (if (null? symbol-list)
          '()
          (begin (hashtable-set! ht (car symbol-list) i)
                 (loop (cdr symbol-list) (+ i 1)))))
    (make-enum-type symbol-list
                    (lambda (symbol)
                      (hashtable-ref ht symbol #f)))))


(define (make-enumeration symbol-list)
  (make-enum-set (make-enumeration-type symbol-list) symbol-list))

(define (enum-set-universe enum-set)
  (make-enum-set (enum-set-type enum-set)
                 (enum-type-universe (enum-set-type enum-set))))

(define (enum-set-indexer enum-set)
  (enum-type-indexer (enum-set-type enum-set)))

(define (enum-set-constructor enum-set)
  (lambda (symbol-list)
    (let ([universe (enum-type-universe (enum-set-type enum-set))])
      (if (for-all (lambda (x) (memq x universe)) symbol-list)
          (make-enum-set (enum-set-type enum-set) symbol-list)
          (assertion-violation 'enum-set-constructor "the symbol list must all belong to the universe." universe symbol-list)))))

(define (enum-set->list enum-set)
  (let ([universe (enum-type-universe (enum-set-type enum-set))]
        [members (enum-set-members enum-set)])
    (let loop ([universe universe])
      (cond
       [(null? universe) '()]
       [(memq (car universe) members)
        (cons (car universe) (loop (cdr universe)))]
       [else
        (loop (cdr universe))]))))

(define (enum-set-member? symbol enum-set)
  (and (memq symbol (enum-set-members enum-set)) #t))

(define (enum-set-subset? enum-set1 enum-set2)
  (and
   (let ([enum-set2-univese (enum-set->list (enum-set-universe enum-set2))])
     (for-all
      (lambda (symbol) (memq symbol enum-set2-univese))
      (enum-set->list (enum-set-universe enum-set1))))
   (for-all
    (lambda (symbol) (enum-set-member? symbol enum-set2))
    (enum-set-members enum-set1))))

(define (enum-set=? enum-set1 enum-set2)
  (and (enum-set-subset? enum-set1 enum-set2)
       (enum-set-subset? enum-set2 enum-set1)))

(define (enum-set-union enum-set1 enum-set2)
  (define (union lst1 lst2)
    (let loop ([ret lst1]
               [lst lst2])
      (cond
       [(null? lst) ret]
       [(memq (car lst) ret)
        (loop ret (cdr lst))]
       [else
        (loop (cons (car lst) ret) (cdr lst))])))
  (if (eq? (enum-set-type enum-set1) (enum-set-type enum-set2))
      (make-enum-set (enum-set-type enum-set1)
                     (union (enum-set-members enum-set1) (enum-set-members enum-set2)))
      (assertion-violation 'enum-set-union "enum-set1 and enum-set2 must be enumeration sets that have the same enumeration type.")))

(define (enum-set-intersection enum-set1 enum-set2)
  (define (intersection lst1 lst2)
    (let loop ([ret '()]
               [lst lst1])
      (if (null? lst)
          ret
          (cond
           [(memq (car lst) lst2)
             (loop (cons (car lst) ret) (cdr lst))]
           [else
            (loop ret (cdr lst))]))))
  (if (eq? (enum-set-type enum-set1) (enum-set-type enum-set2))
      (make-enum-set (enum-set-type enum-set1)
                     (intersection (enum-set-members enum-set1) (enum-set-members enum-set2)))
      (assertion-violation 'enum-set-intersection "enum-set1 and enum-set2 must be enumeration sets that have the same enumeration type.")))

(define (enum-set-difference enum-set1 enum-set2)
  (define (difference lst1 lst2)
    (let loop ([ret '()]
               [lst lst1])
      (if (null? lst)
          ret
          (cond
           [(memq (car lst) lst2)
            (loop ret (cdr lst))]
           [else
            (loop (cons (car lst) ret) (cdr lst))]))))
  (if (eq? (enum-set-type enum-set1) (enum-set-type enum-set2))
      (make-enum-set (enum-set-type enum-set1)
                     (difference (enum-set-members enum-set1) (enum-set-members enum-set2)))
      (assertion-violation 'enum-set-difference "enum-set1 and enum-set2 must be enumeration sets that have the same enumeration type.")))

(define (enum-set-complement enum-set)
  (let ([members (enum-set-members enum-set)])
    (make-enum-set (enum-set-type enum-set)
                   (filter (lambda (symbol) (not (memq symbol members))) (enum-type-universe (enum-set-type enum-set))))))

(define (enum-set-projection enum-set1 enum-set2)
  (if (enum-set-subset? enum-set1 enum-set2)
      enum-set1
      (let ([universe2 (enum-type-universe (enum-set-type enum-set2))]
            [members1 (enum-set-members enum-set1)])
        (make-enum-set (enum-set-type enum-set2)
                       (filter (lambda (symbol) (memq symbol universe2)) members1)))))

(define (pretty-print x p) (display x p) (newline p))

;; quick hack
(define-macro (let-values clause . body)
  `(receive ,(caar clause) ,(cadar clause)
       ,@body))
(define list-head take)

;; sorting
;; from Ypsilon Scheme System by Y.FUJITA, LittleWing Company Limited start.
(define list-sort
  (lambda (proc lst)

    (define merge
      (lambda (lst1 lst2)
        (cond
         ((null? lst1) lst2)
         ((null? lst2) lst1)
         (else
          (if (proc (car lst2) (car lst1))
              (cons (car lst2) (merge lst1 (cdr lst2)))
              (cons (car lst1) (merge (cdr lst1) lst2)))))))

    (define sort
      (lambda (lst n)
        (cond ((= n 1)
               (list (car lst)))
              ((= n 2)
               (if (proc (cadr lst) (car lst))
                   (list (cadr lst) (car lst))
                   (list (car lst) (cadr lst))))
              (else
               (let ((n/2 (div n 2)))
                 (merge (sort lst n/2)
                        (sort (list-tail lst n/2) (- n n/2))))))))

    (define divide
      (lambda (lst)
        (let loop ((acc 1) (lst lst))
          (cond ((null? (cdr lst)) (values acc '()))
                (else
                 (if (proc (car lst) (cadr lst))
                     (loop (+ acc 1) (cdr lst))
                     (values acc (cdr lst))))))))

    (cond ((null? lst) '())
          (else
           (let ((len (length lst)))
             (let-values (((n rest) (divide lst)))
               (cond ((null? rest) lst)
                     (else
                      (merge (list-head lst n)
                             (sort rest (- len n)))))))))))

(define vector-sort
  (lambda (proc vect)
    (let ((lst (vector->list vect)))
      (let ((lst2 (list-sort proc lst)))
        (cond ((eq? lst lst2) vect)
              (else
               (list->vector lst2)))))))

(define vector-sort!
  (lambda (proc vect)
    (let* ((n (vector-length vect)) (work (make-vector (+ (div n 2) 1))))

      (define simple-sort!
        (lambda (first last)
          (let loop1 ((i first))
            (cond ((< i last)
                   (let ((m (vector-ref vect i)) (k i))
                     (let loop2 ((j (+ i 1)))
                       (cond ((<= j last)
                              (if (proc (vector-ref vect j) m)
                                  (begin
                                    (set! m (vector-ref vect j))
                                    (set! k j)))
                              (loop2 (+ j 1)))
                             (else
                              (vector-set! vect k (vector-ref vect i))
                              (vector-set! vect i m)
                              (loop1 (+ i 1)))))))))))

      (define sort!
        (lambda (first last)
          (cond ((> (- last first) 10)
                 (let ((middle (div (+ first last) 2)))
                   (sort! first middle)
                   (sort! (+ middle 1) last)
                   (let loop ((i first) (p2size 0))
                     (cond ((> i middle)
                            (let loop ((p1 (+ middle 1)) (p2 0) (p3 first))
                              (cond ((and (<= p1 last) (< p2 p2size))
                                     (cond ((proc (vector-ref work p2) (vector-ref vect p1))
                                            (vector-set! vect p3 (vector-ref work p2))
                                            (loop p1 (+ p2 1) (+ p3 1)))
                                           (else
                                            (vector-set! vect p3 (vector-ref vect p1))
                                            (loop (+ p1 1) p2 (+ p3 1)))))
                                    (else
                                     (let loop ((s2 p2)(d3 p3))
                                       (cond ((< s2 p2size)
                                              (vector-set! vect d3 (vector-ref work s2))
                                              (loop (+ s2 1) (+ d3 1)))))))))
                           (else
                            (vector-set! work p2size (vector-ref vect i))
                            (loop (+ i 1) (+ p2size 1)))))))
                (else
                 (simple-sort! first last)))))

      (sort! 0 (- n 1)))))
;; from Ypsilon Scheme System end.

(define (substring string start end)
  (let* ([len (- end start)]
         [ret (make-string len)])
    (let loop ([i 0])
      (cond [(= i len) ret]
            [else
             (string-set! ret i (string-ref string (+ i start)))
             (loop (+ i 1))]))))

(define (string-compare s1 s2)
  (define (compare s1 s2 len)
    (let loop ([index 0])
      (cond [(= index len) 0]
            [(char=? (string-ref s1 index) (string-ref s2 index))
             (loop (+ index 1))]
            [(char>? (string-ref s1 index) (string-ref s2 index)) 1]
            [else -1])))
  (let* ([s1-len (string-length s1)]
         [s2-len (string-length s2)]
         [shorter-len (min s1-len s2-len)]
         [compare-result (compare s1 s2 shorter-len)])
    (cond
     [(zero? compare-result)
      (cond [(= s1-len s2-len) 0]
            [(> s1-len s2-len) 1]
            [else -1])]
     [else compare-result])))

(define (string<? string . strings)
  (if (null? strings)
      #t
      (and (= -1 (string-compare string (car strings)))
           (apply string<? (car strings) (cdr strings)))))

(define (string>? string . strings)
  (if (null? strings)
      #t
      (and (= 1 (string-compare string (car strings)))
           (apply string>? (car strings) (cdr strings)))))

(define (string<=? string . strings)
  (if (null? strings)
      #t
      (and (<= (string-compare string (car strings)) 0)
           (apply string<=? (car strings) (cdr strings)))))

(define (string>=? string . strings)
  (if (null? strings)
      #t
      (and (>= (string-compare string (car strings)) 0)
           (apply string>=? (car strings) (cdr strings)))))


(define (file->list file)
  (with-input-from-file file
    (lambda ()
      (let loop ([line (read-line)]
                 [ret '()])
        (cond
         [(eof-object? line) (reverse ret)]
         [else
          (loop (read-line) (cons line ret))])))))

(define-macro (case-lambda . x)
  `(lambda args
     ((match-lambda
          ,@x)
      args)))

(define (alist->eq-hash-table alist)
  (let ([hashtable (make-eq-hashtable)])
    (for-each (lambda (x) (hashtable-set! hashtable (car x) (cdr x)))
              alist)
    hashtable))

(define (ralist->eq-hash-table alist)
  (let ([hashtable (make-eq-hashtable)])
    (for-each (lambda (x) (hashtable-set! hashtable (cdr x) (car x)))
              alist)
    hashtable))

(define composition-exclusion-list '(
 2392 2393 2394 2395 2396
 2397 2398 2399 2524 2525
 2527 2611 2614 2649 2650
 2651 2654 2908 2909 3907
 3917 3922 3927 3932 3945
 3958 3960 3987 3997 4002
 4007 4012 4025 64285 64287
 64298 64299 64300 64301 64302
 64303 64304 64305 64306 64307
 64308 64309 64310 64312 64313
 64314 64315 64316 64318 64320
 64321 64323 64324 64326 64327
 64328 64329 64330 64331 64332
 64333 64334 10972 119134 119135
 119136 119137 119138 119139 119140
 119227 119228 119229 119230 119231
 119232))

(define compatible-decompose-list '( (160 . (32))
 (168 . (32 776)) (170 . (97)) (175 . (32 772)) (178 . (50)) (179 . (51))
 (180 . (32 769)) (181 . (956)) (184 . (32 807)) (185 . (49)) (186 . (111))
 (188 . (49 8260 52)) (189 . (49 8260 50)) (190 . (51 8260 52)) (306 . (73 74)) (307 . (105 106))
 (319 . (76 183)) (320 . (108 183)) (329 . (700 110)) (383 . (115)) (452 . (68 381))
 (453 . (68 382)) (454 . (100 382)) (455 . (76 74)) (456 . (76 106)) (457 . (108 106))
 (458 . (78 74)) (459 . (78 106)) (460 . (110 106)) (497 . (68 90)) (498 . (68 122))
 (499 . (100 122)) (688 . (104)) (689 . (614)) (690 . (106)) (691 . (114))
 (692 . (633)) (693 . (635)) (694 . (641)) (695 . (119)) (696 . (121))
 (728 . (32 774)) (729 . (32 775)) (730 . (32 778)) (731 . (32 808)) (732 . (32 771))
 (733 . (32 779)) (736 . (611)) (737 . (108)) (738 . (115)) (739 . (120))
 (740 . (661)) (890 . (32 837)) (900 . (32 769)) (976 . (946)) (977 . (952))
 (978 . (933)) (981 . (966)) (982 . (960)) (1008 . (954)) (1009 . (961))
 (1010 . (962)) (1012 . (920)) (1013 . (949)) (1017 . (931)) (1415 . (1381 1410))
 (1653 . (1575 1652)) (1654 . (1608 1652)) (1655 . (1735 1652)) (1656 . (1610 1652)) (3635 . (3661 3634))
 (3763 . (3789 3762)) (3804 . (3755 3737)) (3805 . (3755 3745)) (3852 . (3851)) (3959 . (4018 3969))
 (3961 . (4019 3969)) (4348 . (4316)) (7468 . (65)) (7469 . (198)) (7470 . (66))
 (7472 . (68)) (7473 . (69)) (7474 . (398)) (7475 . (71)) (7476 . (72))
 (7477 . (73)) (7478 . (74)) (7479 . (75)) (7480 . (76)) (7481 . (77))
 (7482 . (78)) (7484 . (79)) (7485 . (546)) (7486 . (80)) (7487 . (82))
 (7488 . (84)) (7489 . (85)) (7490 . (87)) (7491 . (97)) (7492 . (592))
 (7493 . (593)) (7494 . (7426)) (7495 . (98)) (7496 . (100)) (7497 . (101))
 (7498 . (601)) (7499 . (603)) (7500 . (604)) (7501 . (103)) (7503 . (107))
 (7504 . (109)) (7505 . (331)) (7506 . (111)) (7507 . (596)) (7508 . (7446))
 (7509 . (7447)) (7510 . (112)) (7511 . (116)) (7512 . (117)) (7513 . (7453))
 (7514 . (623)) (7515 . (118)) (7516 . (7461)) (7517 . (946)) (7518 . (947))
 (7519 . (948)) (7520 . (966)) (7521 . (967)) (7522 . (105)) (7523 . (114))
 (7524 . (117)) (7525 . (118)) (7526 . (946)) (7527 . (947)) (7528 . (961))
 (7529 . (966)) (7530 . (967)) (7544 . (1085)) (7579 . (594)) (7580 . (99))
 (7581 . (597)) (7582 . (240)) (7583 . (604)) (7584 . (102)) (7585 . (607))
 (7586 . (609)) (7587 . (613)) (7588 . (616)) (7589 . (617)) (7590 . (618))
 (7591 . (7547)) (7592 . (669)) (7593 . (621)) (7594 . (7557)) (7595 . (671))
 (7596 . (625)) (7597 . (624)) (7598 . (626)) (7599 . (627)) (7600 . (628))
 (7601 . (629)) (7602 . (632)) (7603 . (642)) (7604 . (643)) (7605 . (427))
 (7606 . (649)) (7607 . (650)) (7608 . (7452)) (7609 . (651)) (7610 . (652))
 (7611 . (122)) (7612 . (656)) (7613 . (657)) (7614 . (658)) (7615 . (952))
 (7834 . (97 702)) (8125 . (32 787)) (8127 . (32 787)) (8128 . (32 834)) (8190 . (32 788))
 (8194 . (32)) (8195 . (32)) (8196 . (32)) (8197 . (32)) (8198 . (32))
 (8199 . (32)) (8200 . (32)) (8201 . (32)) (8202 . (32)) (8209 . (8208))
 (8215 . (32 819)) (8228 . (46)) (8229 . (46 46)) (8230 . (46 46 46)) (8239 . (32))
 (8243 . (8242 8242)) (8244 . (8242 8242 8242)) (8246 . (8245 8245)) (8247 . (8245 8245 8245)) (8252 . (33 33))
 (8254 . (32 773)) (8263 . (63 63)) (8264 . (63 33)) (8265 . (33 63)) (8279 . (8242 8242 8242 8242))
 (8287 . (32)) (8304 . (48)) (8305 . (105)) (8308 . (52)) (8309 . (53))
 (8310 . (54)) (8311 . (55)) (8312 . (56)) (8313 . (57)) (8314 . (43))
 (8315 . (8722)) (8316 . (61)) (8317 . (40)) (8318 . (41)) (8319 . (110))
 (8320 . (48)) (8321 . (49)) (8322 . (50)) (8323 . (51)) (8324 . (52))
 (8325 . (53)) (8326 . (54)) (8327 . (55)) (8328 . (56)) (8329 . (57))
 (8330 . (43)) (8331 . (8722)) (8332 . (61)) (8333 . (40)) (8334 . (41))
 (8336 . (97)) (8337 . (101)) (8338 . (111)) (8339 . (120)) (8340 . (601))
 (8360 . (82 115)) (8448 . (97 47 99)) (8449 . (97 47 115)) (8450 . (67)) (8451 . (176 67))
 (8453 . (99 47 111)) (8454 . (99 47 117)) (8455 . (400)) (8457 . (176 70)) (8458 . (103))
 (8459 . (72)) (8460 . (72)) (8461 . (72)) (8462 . (104)) (8463 . (295))
 (8464 . (73)) (8465 . (73)) (8466 . (76)) (8467 . (108)) (8469 . (78))
 (8470 . (78 111)) (8473 . (80)) (8474 . (81)) (8475 . (82)) (8476 . (82))
 (8477 . (82)) (8480 . (83 77)) (8481 . (84 69 76)) (8482 . (84 77)) (8484 . (90))
 (8488 . (90)) (8492 . (66)) (8493 . (67)) (8495 . (101)) (8496 . (69))
 (8497 . (70)) (8499 . (77)) (8500 . (111)) (8501 . (1488)) (8502 . (1489))
 (8503 . (1490)) (8504 . (1491)) (8505 . (105)) (8507 . (70 65 88)) (8508 . (960))
 (8509 . (947)) (8510 . (915)) (8511 . (928)) (8512 . (8721)) (8517 . (68))
 (8518 . (100)) (8519 . (101)) (8520 . (105)) (8521 . (106)) (8531 . (49 8260 51))
 (8532 . (50 8260 51)) (8533 . (49 8260 53)) (8534 . (50 8260 53)) (8535 . (51 8260 53)) (8536 . (52 8260 53))
 (8537 . (49 8260 54)) (8538 . (53 8260 54)) (8539 . (49 8260 56)) (8540 . (51 8260 56)) (8541 . (53 8260 56))
 (8542 . (55 8260 56)) (8543 . (49 8260)) (8544 . (73)) (8545 . (73 73)) (8546 . (73 73 73))
 (8547 . (73 86)) (8548 . (86)) (8549 . (86 73)) (8550 . (86 73 73)) (8551 . (86 73 73 73))
 (8552 . (73 88)) (8553 . (88)) (8554 . (88 73)) (8555 . (88 73 73)) (8556 . (76))
 (8557 . (67)) (8558 . (68)) (8559 . (77)) (8560 . (105)) (8561 . (105 105))
 (8562 . (105 105 105)) (8563 . (105 118)) (8564 . (118)) (8565 . (118 105)) (8566 . (118 105 105))
 (8567 . (118 105 105 105)) (8568 . (105 120)) (8569 . (120)) (8570 . (120 105)) (8571 . (120 105 105))
 (8572 . (108)) (8573 . (99)) (8574 . (100)) (8575 . (109)) (8748 . (8747 8747))
 (8749 . (8747 8747 8747)) (8751 . (8750 8750)) (8752 . (8750 8750 8750)) (9312 . (49)) (9313 . (50))
 (9314 . (51)) (9315 . (52)) (9316 . (53)) (9317 . (54)) (9318 . (55))
 (9319 . (56)) (9320 . (57)) (9321 . (49 48)) (9322 . (49 49)) (9323 . (49 50))
 (9324 . (49 51)) (9325 . (49 52)) (9326 . (49 53)) (9327 . (49 54)) (9328 . (49 55))
 (9329 . (49 56)) (9330 . (49 57)) (9331 . (50 48)) (9332 . (40 49 41)) (9333 . (40 50 41))
 (9334 . (40 51 41)) (9335 . (40 52 41)) (9336 . (40 53 41)) (9337 . (40 54 41)) (9338 . (40 55 41))
 (9339 . (40 56 41)) (9340 . (40 57 41)) (9341 . (40 49 48 41)) (9342 . (40 49 49 41)) (9343 . (40 49 50 41))
 (9344 . (40 49 51 41)) (9345 . (40 49 52 41)) (9346 . (40 49 53 41)) (9347 . (40 49 54 41)) (9348 . (40 49 55 41))
 (9349 . (40 49 56 41)) (9350 . (40 49 57 41)) (9351 . (40 50 48 41)) (9352 . (49 46)) (9353 . (50 46))
 (9354 . (51 46)) (9355 . (52 46)) (9356 . (53 46)) (9357 . (54 46)) (9358 . (55 46))
 (9359 . (56 46)) (9360 . (57 46)) (9361 . (49 48 46)) (9362 . (49 49 46)) (9363 . (49 50 46))
 (9364 . (49 51 46)) (9365 . (49 52 46)) (9366 . (49 53 46)) (9367 . (49 54 46)) (9368 . (49 55 46))
 (9369 . (49 56 46)) (9370 . (49 57 46)) (9371 . (50 48 46)) (9372 . (40 97 41)) (9373 . (40 98 41))
 (9374 . (40 99 41)) (9375 . (40 100 41)) (9376 . (40 101 41)) (9377 . (40 102 41)) (9378 . (40 103 41))
 (9379 . (40 104 41)) (9380 . (40 105 41)) (9381 . (40 106 41)) (9382 . (40 107 41)) (9383 . (40 108 41))
 (9384 . (40 109 41)) (9385 . (40 110 41)) (9386 . (40 111 41)) (9387 . (40 112 41)) (9388 . (40 113 41))
 (9389 . (40 114 41)) (9390 . (40 115 41)) (9391 . (40 116 41)) (9392 . (40 117 41)) (9393 . (40 118 41))
 (9394 . (40 119 41)) (9395 . (40 120 41)) (9396 . (40 121 41)) (9397 . (40 122 41)) (9398 . (65))
 (9399 . (66)) (9400 . (67)) (9401 . (68)) (9402 . (69)) (9403 . (70))
 (9404 . (71)) (9405 . (72)) (9406 . (73)) (9407 . (74)) (9408 . (75))
 (9409 . (76)) (9410 . (77)) (9411 . (78)) (9412 . (79)) (9413 . (80))
 (9414 . (81)) (9415 . (82)) (9416 . (83)) (9417 . (84)) (9418 . (85))
 (9419 . (86)) (9420 . (87)) (9421 . (88)) (9422 . (89)) (9423 . (90))
 (9424 . (97)) (9425 . (98)) (9426 . (99)) (9427 . (100)) (9428 . (101))
 (9429 . (102)) (9430 . (103)) (9431 . (104)) (9432 . (105)) (9433 . (106))
 (9434 . (107)) (9435 . (108)) (9436 . (109)) (9437 . (110)) (9438 . (111))
 (9439 . (112)) (9440 . (113)) (9441 . (114)) (9442 . (115)) (9443 . (116))
 (9444 . (117)) (9445 . (118)) (9446 . (119)) (9447 . (120)) (9448 . (121))
 (9449 . (122)) (9450 . (48)) (10764 . (8747 8747 8747 8747)) (10868 . (58 58 61)) (10869 . (61 61))
 (10870 . (61 61 61)) (11388 . (106)) (11389 . (86)) (11631 . (11617)) (11935 . (27597))
 (12019 . (40863)) (12032 . (19968)) (12033 . (20008)) (12034 . (20022)) (12035 . (20031))
 (12036 . (20057)) (12037 . (20101)) (12038 . (20108)) (12039 . (20128)) (12040 . (20154))
 (12041 . (20799)) (12042 . (20837)) (12043 . (20843)) (12044 . (20866)) (12045 . (20886))
 (12046 . (20907)) (12047 . (20960)) (12048 . (20981)) (12049 . (20992)) (12050 . (21147))
 (12051 . (21241)) (12052 . (21269)) (12053 . (21274)) (12054 . (21304)) (12055 . (21313))
 (12056 . (21340)) (12057 . (21353)) (12058 . (21378)) (12059 . (21430)) (12060 . (21448))
 (12061 . (21475)) (12062 . (22231)) (12063 . (22303)) (12064 . (22763)) (12065 . (22786))
 (12066 . (22794)) (12067 . (22805)) (12068 . (22823)) (12069 . (22899)) (12070 . (23376))
 (12071 . (23424)) (12072 . (23544)) (12073 . (23567)) (12074 . (23586)) (12075 . (23608))
 (12076 . (23662)) (12077 . (23665)) (12078 . (24027)) (12079 . (24037)) (12080 . (24049))
 (12081 . (24062)) (12082 . (24178)) (12083 . (24186)) (12084 . (24191)) (12085 . (24308))
 (12086 . (24318)) (12087 . (24331)) (12088 . (24339)) (12089 . (24400)) (12090 . (24417))
 (12091 . (24435)) (12092 . (24515)) (12093 . (25096)) (12094 . (25142)) (12095 . (25163))
 (12096 . (25903)) (12097 . (25908)) (12098 . (25991)) (12099 . (26007)) (12100 . (26020))
 (12101 . (26041)) (12102 . (26080)) (12103 . (26085)) (12104 . (26352)) (12105 . (26376))
 (12106 . (26408)) (12107 . (27424)) (12108 . (27490)) (12109 . (27513)) (12110 . (27571))
 (12111 . (27595)) (12112 . (27604)) (12113 . (27611)) (12114 . (27663)) (12115 . (27668))
 (12116 . (27700)) (12117 . (28779)) (12118 . (29226)) (12119 . (29238)) (12120 . (29243))
 (12121 . (29247)) (12122 . (29255)) (12123 . (29273)) (12124 . (29275)) (12125 . (29356))
 (12126 . (29572)) (12127 . (29577)) (12128 . (29916)) (12129 . (29926)) (12130 . (29976))
 (12131 . (29983)) (12132 . (29992)) (12133 . (30000)) (12134 . (30091)) (12135 . (30098))
 (12136 . (30326)) (12137 . (30333)) (12138 . (30382)) (12139 . (30399)) (12140 . (30446))
 (12141 . (30683)) (12142 . (30690)) (12143 . (30707)) (12144 . (31034)) (12145 . (31160))
 (12146 . (31166)) (12147 . (31348)) (12148 . (31435)) (12149 . (31481)) (12150 . (31859))
 (12151 . (31992)) (12152 . (32566)) (12153 . (32593)) (12154 . (32650)) (12155 . (32701))
 (12156 . (32769)) (12157 . (32780)) (12158 . (32786)) (12159 . (32819)) (12160 . (32895))
 (12161 . (32905)) (12162 . (33251)) (12163 . (33258)) (12164 . (33267)) (12165 . (33276))
 (12166 . (33292)) (12167 . (33307)) (12168 . (33311)) (12169 . (33390)) (12170 . (33394))
 (12171 . (33400)) (12172 . (34381)) (12173 . (34411)) (12174 . (34880)) (12175 . (34892))
 (12176 . (34915)) (12177 . (35198)) (12178 . (35211)) (12179 . (35282)) (12180 . (35328))
 (12181 . (35895)) (12182 . (35910)) (12183 . (35925)) (12184 . (35960)) (12185 . (35997))
 (12186 . (36196)) (12187 . (36208)) (12188 . (36275)) (12189 . (36523)) (12190 . (36554))
 (12191 . (36763)) (12192 . (36784)) (12193 . (36789)) (12194 . (37009)) (12195 . (37193))
 (12196 . (37318)) (12197 . (37324)) (12198 . (37329)) (12199 . (38263)) (12200 . (38272))
 (12201 . (38428)) (12202 . (38582)) (12203 . (38585)) (12204 . (38632)) (12205 . (38737))
 (12206 . (38750)) (12207 . (38754)) (12208 . (38761)) (12209 . (38859)) (12210 . (38893))
 (12211 . (38899)) (12212 . (38913)) (12213 . (39080)) (12214 . (39131)) (12215 . (39135))
 (12216 . (39318)) (12217 . (39321)) (12218 . (39340)) (12219 . (39592)) (12220 . (39640))
 (12221 . (39647)) (12222 . (39717)) (12223 . (39727)) (12224 . (39730)) (12225 . (39740))
 (12226 . (39770)) (12227 . (40165)) (12228 . (40565)) (12229 . (40575)) (12230 . (40613))
 (12231 . (40635)) (12232 . (40643)) (12233 . (40653)) (12234 . (40657)) (12235 . (40697))
 (12236 . (40701)) (12237 . (40718)) (12238 . (40723)) (12239 . (40736)) (12240 . (40763))
 (12241 . (40778)) (12242 . (40786)) (12243 . (40845)) (12244 . (40860)) (12245 . (40864))
 (12288 . (32)) (12342 . (12306)) (12344 . (21313)) (12345 . (21316)) (12346 . (21317))
 (12443 . (32 12441)) (12444 . (32 12442)) (12447 . (12424 12426)) (12543 . (12467 12488)) (12593 . (4352))
 (12594 . (4353)) (12595 . (4522)) (12596 . (4354)) (12597 . (4524)) (12598 . (4525))
 (12599 . (4355)) (12600 . (4356)) (12601 . (4357)) (12602 . (4528)) (12603 . (4529))
 (12604 . (4530)) (12605 . (4531)) (12606 . (4532)) (12607 . (4533)) (12608 . (4378))
 (12609 . (4358)) (12610 . (4359)) (12611 . (4360)) (12612 . (4385)) (12613 . (4361))
 (12614 . (4362)) (12615 . (4363)) (12616 . (4364)) (12617 . (4365)) (12618 . (4366))
 (12619 . (4367)) (12620 . (4368)) (12621 . (4369)) (12622 . (4370)) (12623 . (4449))
 (12624 . (4450)) (12625 . (4451)) (12626 . (4452)) (12627 . (4453)) (12628 . (4454))
 (12629 . (4455)) (12630 . (4456)) (12631 . (4457)) (12632 . (4458)) (12633 . (4459))
 (12634 . (4460)) (12635 . (4461)) (12636 . (4462)) (12637 . (4463)) (12638 . (4464))
 (12639 . (4465)) (12640 . (4466)) (12641 . (4467)) (12642 . (4468)) (12643 . (4469))
 (12644 . (4448)) (12645 . (4372)) (12646 . (4373)) (12647 . (4551)) (12648 . (4552))
 (12649 . (4556)) (12650 . (4558)) (12651 . (4563)) (12652 . (4567)) (12653 . (4569))
 (12654 . (4380)) (12655 . (4573)) (12656 . (4575)) (12657 . (4381)) (12658 . (4382))
 (12659 . (4384)) (12660 . (4386)) (12661 . (4387)) (12662 . (4391)) (12663 . (4393))
 (12664 . (4395)) (12665 . (4396)) (12666 . (4397)) (12667 . (4398)) (12668 . (4399))
 (12669 . (4402)) (12670 . (4406)) (12671 . (4416)) (12672 . (4423)) (12673 . (4428))
 (12674 . (4593)) (12675 . (4594)) (12676 . (4439)) (12677 . (4440)) (12678 . (4441))
 (12679 . (4484)) (12680 . (4485)) (12681 . (4488)) (12682 . (4497)) (12683 . (4498))
 (12684 . (4500)) (12685 . (4510)) (12686 . (4513)) (12690 . (19968)) (12691 . (20108))
 (12692 . (19977)) (12693 . (22235)) (12694 . (19978)) (12695 . (20013)) (12696 . (19979))
 (12697 . (30002)) (12698 . (20057)) (12699 . (19993)) (12700 . (19969)) (12701 . (22825))
 (12702 . (22320)) (12703 . (20154)) (12800 . (40 4352 41)) (12801 . (40 4354 41)) (12802 . (40 4355 41))
 (12803 . (40 4357 41)) (12804 . (40 4358 41)) (12805 . (40 4359 41)) (12806 . (40 4361 41)) (12807 . (40 4363 41))
 (12808 . (40 4364 41)) (12809 . (40 4366 41)) (12810 . (40 4367 41)) (12811 . (40 4368 41)) (12812 . (40 4369 41))
 (12813 . (40 4370 41)) (12814 . (40 4352 4449 41)) (12815 . (40 4354 4449 41)) (12816 . (40 4355 4449 41)) (12817 . (40 4357 4449 41))
 (12818 . (40 4358 4449 41)) (12819 . (40 4359 4449 41)) (12820 . (40 4361 4449 41)) (12821 . (40 4363 4449 41)) (12822 . (40 4364 4449 41))
 (12823 . (40 4366 4449 41)) (12824 . (40 4367 4449 41)) (12825 . (40 4368 4449 41)) (12826 . (40 4369 4449 41)) (12827 . (40 4370 4449 41))
 (12828 . (40 4364 4462 41)) (12829 . (40 4363 4457 4364 4453 4523 41)) (12830 . (40 4363 4457 4370 4462 41)) (12832 . (40 19968 41)) (12833 . (40 20108 41))
 (12834 . (40 19977 41)) (12835 . (40 22235 41)) (12836 . (40 20116 41)) (12837 . (40 20845 41)) (12838 . (40 19971 41))
 (12839 . (40 20843 41)) (12840 . (40 20061 41)) (12841 . (40 21313 41)) (12842 . (40 26376 41)) (12843 . (40 28779 41))
 (12844 . (40 27700 41)) (12845 . (40 26408 41)) (12846 . (40 37329 41)) (12847 . (40 22303 41)) (12848 . (40 26085 41))
 (12849 . (40 26666 41)) (12850 . (40 26377 41)) (12851 . (40 31038 41)) (12852 . (40 21517 41)) (12853 . (40 29305 41))
 (12854 . (40 36001 41)) (12855 . (40 31069 41)) (12856 . (40 21172 41)) (12857 . (40 20195 41)) (12858 . (40 21628 41))
 (12859 . (40 23398 41)) (12860 . (40 30435 41)) (12861 . (40 20225 41)) (12862 . (40 36039 41)) (12863 . (40 21332 41))
 (12864 . (40 31085 41)) (12865 . (40 20241 41)) (12866 . (40 33258 41)) (12867 . (40 33267 41)) (12880 . (80 84 69))
 (12881 . (50 49)) (12882 . (50 50)) (12883 . (50 51)) (12884 . (50 52)) (12885 . (50 53))
 (12886 . (50 54)) (12887 . (50 55)) (12888 . (50 56)) (12889 . (50 57)) (12890 . (51 48))
 (12891 . (51 49)) (12892 . (51 50)) (12893 . (51 51)) (12894 . (51 52)) (12895 . (51 53))
 (12896 . (4352)) (12897 . (4354)) (12898 . (4355)) (12899 . (4357)) (12900 . (4358))
 (12901 . (4359)) (12902 . (4361)) (12903 . (4363)) (12904 . (4364)) (12905 . (4366))
 (12906 . (4367)) (12907 . (4368)) (12908 . (4369)) (12909 . (4370)) (12910 . (4352 4449))
 (12911 . (4354 4449)) (12912 . (4355 4449)) (12913 . (4357 4449)) (12914 . (4358 4449)) (12915 . (4359 4449))
 (12916 . (4361 4449)) (12917 . (4363 4449)) (12918 . (4364 4449)) (12919 . (4366 4449)) (12920 . (4367 4449))
 (12921 . (4368 4449)) (12922 . (4369 4449)) (12923 . (4370 4449)) (12924 . (4366 4449 4535 4352 4457)) (12925 . (4364 4462 4363 4468))
 (12926 . (4363 4462)) (12928 . (19968)) (12929 . (20108)) (12930 . (19977)) (12931 . (22235))
 (12932 . (20116)) (12933 . (20845)) (12934 . (19971)) (12935 . (20843)) (12936 . (20061))
 (12937 . (21313)) (12938 . (26376)) (12939 . (28779)) (12940 . (27700)) (12941 . (26408))
 (12942 . (37329)) (12943 . (22303)) (12944 . (26085)) (12945 . (26666)) (12946 . (26377))
 (12947 . (31038)) (12948 . (21517)) (12949 . (29305)) (12950 . (36001)) (12951 . (31069))
 (12952 . (21172)) (12953 . (31192)) (12954 . (30007)) (12955 . (22899)) (12956 . (36969))
 (12957 . (20778)) (12958 . (21360)) (12959 . (27880)) (12960 . (38917)) (12961 . (20241))
 (12962 . (20889)) (12963 . (27491)) (12964 . (19978)) (12965 . (20013)) (12966 . (19979))
 (12967 . (24038)) (12968 . (21491)) (12969 . (21307)) (12970 . (23447)) (12971 . (23398))
 (12972 . (30435)) (12973 . (20225)) (12974 . (36039)) (12975 . (21332)) (12976 . (22812))
 (12977 . (51 54)) (12978 . (51 55)) (12979 . (51 56)) (12980 . (51 57)) (12981 . (52 48))
 (12982 . (52 49)) (12983 . (52 50)) (12984 . (52 51)) (12985 . (52 52)) (12986 . (52 53))
 (12987 . (52 54)) (12988 . (52 55)) (12989 . (52 56)) (12990 . (52 57)) (12991 . (53 48))
 (12992 . (49 26376)) (12993 . (50 26376)) (12994 . (51 26376)) (12995 . (52 26376)) (12996 . (53 26376))
 (12997 . (54 26376)) (12998 . (55 26376)) (12999 . (56 26376)) (13000 . (57 26376)) (13001 . (49 48 26376))
 (13002 . (49 49 26376)) (13003 . (49 50 26376)) (13004 . (72 103)) (13005 . (101 114 103)) (13006 . (101 86))
 (13007 . (76 84 68)) (13008 . (12450)) (13009 . (12452)) (13010 . (12454)) (13011 . (12456))
 (13012 . (12458)) (13013 . (12459)) (13014 . (12461)) (13015 . (12463)) (13016 . (12465))
 (13017 . (12467)) (13018 . (12469)) (13019 . (12471)) (13020 . (12473)) (13021 . (12475))
 (13022 . (12477)) (13023 . (12479)) (13024 . (12481)) (13025 . (12484)) (13026 . (12486))
 (13027 . (12488)) (13028 . (12490)) (13029 . (12491)) (13030 . (12492)) (13031 . (12493))
 (13032 . (12494)) (13033 . (12495)) (13034 . (12498)) (13035 . (12501)) (13036 . (12504))
 (13037 . (12507)) (13038 . (12510)) (13039 . (12511)) (13040 . (12512)) (13041 . (12513))
 (13042 . (12514)) (13043 . (12516)) (13044 . (12518)) (13045 . (12520)) (13046 . (12521))
 (13047 . (12522)) (13048 . (12523)) (13049 . (12524)) (13050 . (12525)) (13051 . (12527))
 (13052 . (12528)) (13053 . (12529)) (13054 . (12530)) (13056 . (12450 12497 12540 12488)) (13057 . (12450 12523 12501 12449))
 (13058 . (12450 12531 12506 12450)) (13059 . (12450 12540 12523)) (13060 . (12452 12491 12531 12464)) (13061 . (12452 12531 12481)) (13062 . (12454 12457 12531))
 (13063 . (12456 12473 12463 12540 12489)) (13064 . (12456 12540 12459 12540)) (13065 . (12458 12531 12473)) (13066 . (12458 12540 12512)) (13067 . (12459 12452 12522))
 (13068 . (12459 12521 12483 12488)) (13069 . (12459 12525 12522 12540)) (13070 . (12460 12525 12531)) (13071 . (12460 12531 12510)) (13072 . (12462 12460))
 (13073 . (12462 12491 12540)) (13074 . (12461 12517 12522 12540)) (13075 . (12462 12523 12480 12540)) (13076 . (12461 12525)) (13077 . (12461 12525 12464 12521 12512))
 (13078 . (12461 12525 12513 12540 12488 12523)) (13079 . (12461 12525 12527 12483 12488)) (13080 . (12464 12521 12512)) (13081 . (12464 12521 12512 12488 12531)) (13082 . (12463 12523 12476 12452 12525))
 (13083 . (12463 12525 12540 12493)) (13084 . (12465 12540 12473)) (13085 . (12467 12523 12490)) (13086 . (12467 12540 12509)) (13087 . (12469 12452 12463 12523))
 (13088 . (12469 12531 12481 12540 12512)) (13089 . (12471 12522 12531 12464)) (13090 . (12475 12531 12481)) (13091 . (12475 12531 12488)) (13092 . (12480 12540 12473))
 (13093 . (12487 12471)) (13094 . (12489 12523)) (13095 . (12488 12531)) (13096 . (12490 12494)) (13097 . (12494 12483 12488))
 (13098 . (12495 12452 12484)) (13099 . (12497 12540 12475 12531 12488)) (13100 . (12497 12540 12484)) (13101 . (12496 12540 12524 12523)) (13102 . (12500 12450 12473 12488 12523))
 (13103 . (12500 12463 12523)) (13104 . (12500 12467)) (13105 . (12499 12523)) (13106 . (12501 12449 12521 12483 12489)) (13107 . (12501 12451 12540 12488))
 (13108 . (12502 12483 12471 12455 12523)) (13109 . (12501 12521 12531)) (13110 . (12504 12463 12479 12540 12523)) (13111 . (12506 12477)) (13112 . (12506 12491 12498))
 (13113 . (12504 12523 12484)) (13114 . (12506 12531 12473)) (13115 . (12506 12540 12472)) (13116 . (12505 12540 12479)) (13117 . (12509 12452 12531 12488))
 (13118 . (12508 12523 12488)) (13119 . (12507 12531)) (13120 . (12509 12531 12489)) (13121 . (12507 12540 12523)) (13122 . (12507 12540 12531))
 (13123 . (12510 12452 12463 12525)) (13124 . (12510 12452 12523)) (13125 . (12510 12483 12495)) (13126 . (12510 12523 12463)) (13127 . (12510 12531 12471 12519 12531))
 (13128 . (12511 12463 12525 12531)) (13129 . (12511 12522)) (13130 . (12511 12522 12496 12540 12523)) (13131 . (12513 12460)) (13132 . (12513 12460 12488 12531))
 (13133 . (12513 12540 12488 12523)) (13134 . (12516 12540 12489)) (13135 . (12516 12540 12523)) (13136 . (12518 12450 12531)) (13137 . (12522 12483 12488 12523))
 (13138 . (12522 12521)) (13139 . (12523 12500 12540)) (13140 . (12523 12540 12502 12523)) (13141 . (12524 12512)) (13142 . (12524 12531 12488 12466 12531))
 (13143 . (12527 12483 12488)) (13144 . (48 28857)) (13145 . (49 28857)) (13146 . (50 28857)) (13147 . (51 28857))
 (13148 . (52 28857)) (13149 . (53 28857)) (13150 . (54 28857)) (13151 . (55 28857)) (13152 . (56 28857))
 (13153 . (57 28857)) (13154 . (49 48 28857)) (13155 . (49 49 28857)) (13156 . (49 50 28857)) (13157 . (49 51 28857))
 (13158 . (49 52 28857)) (13159 . (49 53 28857)) (13160 . (49 54 28857)) (13161 . (49 55 28857)) (13162 . (49 56 28857))
 (13163 . (49 57 28857)) (13164 . (50 48 28857)) (13165 . (50 49 28857)) (13166 . (50 50 28857)) (13167 . (50 51 28857))
 (13168 . (50 52 28857)) (13169 . (104 80 97)) (13170 . (100 97)) (13171 . (65 85)) (13172 . (98 97 114))
 (13173 . (111 86)) (13174 . (112 99)) (13175 . (100 109)) (13176 . (100 109 178)) (13177 . (100 109 179))
 (13178 . (73 85)) (13179 . (24179 25104)) (13180 . (26157 21644)) (13181 . (22823 27491)) (13182 . (26126 27835))
 (13183 . (26666 24335 20250 31038)) (13184 . (112 65)) (13185 . (110 65)) (13186 . (956 65)) (13187 . (109 65))
 (13188 . (107 65)) (13189 . (75 66)) (13190 . (77 66)) (13191 . (71 66)) (13192 . (99 97 108))
 (13193 . (107 99 97 108)) (13194 . (112 70)) (13195 . (110 70)) (13196 . (956 70)) (13197 . (956 103))
 (13198 . (109 103)) (13199 . (107 103)) (13200 . (72 122)) (13201 . (107 72 122)) (13202 . (77 72 122))
 (13203 . (71 72 122)) (13204 . (84 72 122)) (13205 . (956 8467)) (13206 . (109 8467)) (13207 . (100 8467))
 (13208 . (107 8467)) (13209 . (102 109)) (13210 . (110 109)) (13211 . (956 109)) (13212 . (109 109))
 (13213 . (99 109)) (13214 . (107 109)) (13215 . (109 109 178)) (13216 . (99 109 178)) (13217 . (109 178))
 (13218 . (107 109 178)) (13219 . (109 109 179)) (13220 . (99 109 179)) (13221 . (109 179)) (13222 . (107 109 179))
 (13223 . (109 8725 115)) (13224 . (109 8725 115 178)) (13225 . (80 97)) (13226 . (107 80 97)) (13227 . (77 80 97))
 (13228 . (71 80 97)) (13229 . (114 97 100)) (13230 . (114 97 100 8725 115)) (13231 . (114 97 100 8725 115 178)) (13232 . (112 115))
 (13233 . (110 115)) (13234 . (956 115)) (13235 . (109 115)) (13236 . (112 86)) (13237 . (110 86))
 (13238 . (956 86)) (13239 . (109 86)) (13240 . (107 86)) (13241 . (77 86)) (13242 . (112 87))
 (13243 . (110 87)) (13244 . (956 87)) (13245 . (109 87)) (13246 . (107 87)) (13247 . (77 87))
 (13248 . (107 937)) (13249 . (77 937)) (13250 . (97 46 109 46)) (13251 . (66 113)) (13252 . (99 99))
 (13253 . (99 100)) (13254 . (67 8725 107 103)) (13255 . (67 111 46)) (13256 . (100 66)) (13257 . (71 121))
 (13258 . (104 97)) (13259 . (72 80)) (13260 . (105 110)) (13261 . (75 75)) (13262 . (75 77))
 (13263 . (107 116)) (13264 . (108 109)) (13265 . (108 110)) (13266 . (108 111 103)) (13267 . (108 120))
 (13268 . (109 98)) (13269 . (109 105 108)) (13270 . (109 111 108)) (13271 . (80 72)) (13272 . (112 46 109 46))
 (13273 . (80 80 77)) (13274 . (80 82)) (13275 . (115 114)) (13276 . (83 118)) (13277 . (87 98))
 (13278 . (86 8725 109)) (13279 . (65 8725 109)) (13280 . (49 26085)) (13281 . (50 26085)) (13282 . (51 26085))
 (13283 . (52 26085)) (13284 . (53 26085)) (13285 . (54 26085)) (13286 . (55 26085)) (13287 . (56 26085))
 (13288 . (57 26085)) (13289 . (49 48 26085)) (13290 . (49 49 26085)) (13291 . (49 50 26085)) (13292 . (49 51 26085))
 (13293 . (49 52 26085)) (13294 . (49 53 26085)) (13295 . (49 54 26085)) (13296 . (49 55 26085)) (13297 . (49 56 26085))
 (13298 . (49 57 26085)) (13299 . (50 48 26085)) (13300 . (50 49 26085)) (13301 . (50 50 26085)) (13302 . (50 51 26085))
 (13303 . (50 52 26085)) (13304 . (50 53 26085)) (13305 . (50 54 26085)) (13306 . (50 55 26085)) (13307 . (50 56 26085))
 (13308 . (50 57 26085)) (13309 . (51 48 26085)) (13310 . (51 49 26085)) (13311 . (103 97 108)) (42864 . (42863))
 (64256 . (102 102)) (64257 . (102 105)) (64258 . (102 108)) (64259 . (102 102 105)) (64260 . (102 102 108))
 (64261 . (383 116)) (64262 . (115 116)) (64275 . (1396 1398)) (64276 . (1396 1381)) (64277 . (1396 1387))
 (64278 . (1406 1398)) (64279 . (1396 1389)) (64288 . (1506)) (64289 . (1488)) (64290 . (1491))
 (64291 . (1492)) (64292 . (1499)) (64293 . (1500)) (64294 . (1501)) (64295 . (1512))
 (64296 . (1514)) (64297 . (43)) (64335 . (1488 1500)) (64336 . (1649)) (64337 . (1649))
 (64338 . (1659)) (64339 . (1659)) (64340 . (1659)) (64341 . (1659)) (64342 . (1662))
 (64343 . (1662)) (64344 . (1662)) (64345 . (1662)) (64346 . (1664)) (64347 . (1664))
 (64348 . (1664)) (64349 . (1664)) (64350 . (1658)) (64351 . (1658)) (64352 . (1658))
 (64353 . (1658)) (64354 . (1663)) (64355 . (1663)) (64356 . (1663)) (64357 . (1663))
 (64358 . (1657)) (64359 . (1657)) (64360 . (1657)) (64361 . (1657)) (64362 . (1700))
 (64363 . (1700)) (64364 . (1700)) (64365 . (1700)) (64366 . (1702)) (64367 . (1702))
 (64368 . (1702)) (64369 . (1702)) (64370 . (1668)) (64371 . (1668)) (64372 . (1668))
 (64373 . (1668)) (64374 . (1667)) (64375 . (1667)) (64376 . (1667)) (64377 . (1667))
 (64378 . (1670)) (64379 . (1670)) (64380 . (1670)) (64381 . (1670)) (64382 . (1671))
 (64383 . (1671)) (64384 . (1671)) (64385 . (1671)) (64386 . (1677)) (64387 . (1677))
 (64388 . (1676)) (64389 . (1676)) (64390 . (1678)) (64391 . (1678)) (64392 . (1672))
 (64393 . (1672)) (64394 . (1688)) (64395 . (1688)) (64396 . (1681)) (64397 . (1681))
 (64398 . (1705)) (64399 . (1705)) (64400 . (1705)) (64401 . (1705)) (64402 . (1711))
 (64403 . (1711)) (64404 . (1711)) (64405 . (1711)) (64406 . (1715)) (64407 . (1715))
 (64408 . (1715)) (64409 . (1715)) (64410 . (1713)) (64411 . (1713)) (64412 . (1713))
 (64413 . (1713)) (64414 . (1722)) (64415 . (1722)) (64416 . (1723)) (64417 . (1723))
 (64418 . (1723)) (64419 . (1723)) (64420 . (1728)) (64421 . (1728)) (64422 . (1729))
 (64423 . (1729)) (64424 . (1729)) (64425 . (1729)) (64426 . (1726)) (64427 . (1726))
 (64428 . (1726)) (64429 . (1726)) (64430 . (1746)) (64431 . (1746)) (64432 . (1747))
 (64433 . (1747)) (64467 . (1709)) (64468 . (1709)) (64469 . (1709)) (64470 . (1709))
 (64471 . (1735)) (64472 . (1735)) (64473 . (1734)) (64474 . (1734)) (64475 . (1736))
 (64476 . (1736)) (64477 . (1655)) (64478 . (1739)) (64479 . (1739)) (64480 . (1733))
 (64481 . (1733)) (64482 . (1737)) (64483 . (1737)) (64484 . (1744)) (64485 . (1744))
 (64486 . (1744)) (64487 . (1744)) (64488 . (1609)) (64489 . (1609)) (64490 . (1574 1575))
 (64491 . (1574 1575)) (64492 . (1574 1749)) (64493 . (1574 1749)) (64494 . (1574 1608)) (64495 . (1574 1608))
 (64496 . (1574 1735)) (64497 . (1574 1735)) (64498 . (1574 1734)) (64499 . (1574 1734)) (64500 . (1574 1736))
 (64501 . (1574 1736)) (64502 . (1574 1744)) (64503 . (1574 1744)) (64504 . (1574 1744)) (64505 . (1574 1609))
 (64506 . (1574 1609)) (64507 . (1574 1609)) (64508 . (1740)) (64509 . (1740)) (64510 . (1740))
 (64511 . (1740)) (64512 . (1574 1580)) (64513 . (1574 1581)) (64514 . (1574 1605)) (64515 . (1574 1609))
 (64516 . (1574 1610)) (64517 . (1576 1580)) (64518 . (1576 1581)) (64519 . (1576 1582)) (64520 . (1576 1605))
 (64521 . (1576 1609)) (64522 . (1576 1610)) (64523 . (1578 1580)) (64524 . (1578 1581)) (64525 . (1578 1582))
 (64526 . (1578 1605)) (64527 . (1578 1609)) (64528 . (1578 1610)) (64529 . (1579 1580)) (64530 . (1579 1605))
 (64531 . (1579 1609)) (64532 . (1579 1610)) (64533 . (1580 1581)) (64534 . (1580 1605)) (64535 . (1581 1580))
 (64536 . (1581 1605)) (64537 . (1582 1580)) (64538 . (1582 1581)) (64539 . (1582 1605)) (64540 . (1587 1580))
 (64541 . (1587 1581)) (64542 . (1587 1582)) (64543 . (1587 1605)) (64544 . (1589 1581)) (64545 . (1589 1605))
 (64546 . (1590 1580)) (64547 . (1590 1581)) (64548 . (1590 1582)) (64549 . (1590 1605)) (64550 . (1591 1581))
 (64551 . (1591 1605)) (64552 . (1592 1605)) (64553 . (1593 1580)) (64554 . (1593 1605)) (64555 . (1594 1580))
 (64556 . (1594 1605)) (64557 . (1601 1580)) (64558 . (1601 1581)) (64559 . (1601 1582)) (64560 . (1601 1605))
 (64561 . (1601 1609)) (64562 . (1601 1610)) (64563 . (1602 1581)) (64564 . (1602 1605)) (64565 . (1602 1609))
 (64566 . (1602 1610)) (64567 . (1603 1575)) (64568 . (1603 1580)) (64569 . (1603 1581)) (64570 . (1603 1582))
 (64571 . (1603 1604)) (64572 . (1603 1605)) (64573 . (1603 1609)) (64574 . (1603 1610)) (64575 . (1604 1580))
 (64576 . (1604 1581)) (64577 . (1604 1582)) (64578 . (1604 1605)) (64579 . (1604 1609)) (64580 . (1604 1610))
 (64581 . (1605 1580)) (64582 . (1605 1581)) (64583 . (1605 1582)) (64584 . (1605 1605)) (64585 . (1605 1609))
 (64586 . (1605 1610)) (64587 . (1606 1580)) (64588 . (1606 1581)) (64589 . (1606 1582)) (64590 . (1606 1605))
 (64591 . (1606 1609)) (64592 . (1606 1610)) (64593 . (1607 1580)) (64594 . (1607 1605)) (64595 . (1607 1609))
 (64596 . (1607 1610)) (64597 . (1610 1580)) (64598 . (1610 1581)) (64599 . (1610 1582)) (64600 . (1610 1605))
 (64601 . (1610 1609)) (64602 . (1610 1610)) (64603 . (1584 1648)) (64604 . (1585 1648)) (64605 . (1609 1648))
 (64606 . (32 1612 1617)) (64607 . (32 1613 1617)) (64608 . (32 1614 1617)) (64609 . (32 1615 1617)) (64610 . (32 1616 1617))
 (64611 . (32 1617 1648)) (64612 . (1574 1585)) (64613 . (1574 1586)) (64614 . (1574 1605)) (64615 . (1574 1606))
 (64616 . (1574 1609)) (64617 . (1574 1610)) (64618 . (1576 1585)) (64619 . (1576 1586)) (64620 . (1576 1605))
 (64621 . (1576 1606)) (64622 . (1576 1609)) (64623 . (1576 1610)) (64624 . (1578 1585)) (64625 . (1578 1586))
 (64626 . (1578 1605)) (64627 . (1578 1606)) (64628 . (1578 1609)) (64629 . (1578 1610)) (64630 . (1579 1585))
 (64631 . (1579 1586)) (64632 . (1579 1605)) (64633 . (1579 1606)) (64634 . (1579 1609)) (64635 . (1579 1610))
 (64636 . (1601 1609)) (64637 . (1601 1610)) (64638 . (1602 1609)) (64639 . (1602 1610)) (64640 . (1603 1575))
 (64641 . (1603 1604)) (64642 . (1603 1605)) (64643 . (1603 1609)) (64644 . (1603 1610)) (64645 . (1604 1605))
 (64646 . (1604 1609)) (64647 . (1604 1610)) (64648 . (1605 1575)) (64649 . (1605 1605)) (64650 . (1606 1585))
 (64651 . (1606 1586)) (64652 . (1606 1605)) (64653 . (1606 1606)) (64654 . (1606 1609)) (64655 . (1606 1610))
 (64656 . (1609 1648)) (64657 . (1610 1585)) (64658 . (1610 1586)) (64659 . (1610 1605)) (64660 . (1610 1606))
 (64661 . (1610 1609)) (64662 . (1610 1610)) (64663 . (1574 1580)) (64664 . (1574 1581)) (64665 . (1574 1582))
 (64666 . (1574 1605)) (64667 . (1574 1607)) (64668 . (1576 1580)) (64669 . (1576 1581)) (64670 . (1576 1582))
 (64671 . (1576 1605)) (64672 . (1576 1607)) (64673 . (1578 1580)) (64674 . (1578 1581)) (64675 . (1578 1582))
 (64676 . (1578 1605)) (64677 . (1578 1607)) (64678 . (1579 1605)) (64679 . (1580 1581)) (64680 . (1580 1605))
 (64681 . (1581 1580)) (64682 . (1581 1605)) (64683 . (1582 1580)) (64684 . (1582 1605)) (64685 . (1587 1580))
 (64686 . (1587 1581)) (64687 . (1587 1582)) (64688 . (1587 1605)) (64689 . (1589 1581)) (64690 . (1589 1582))
 (64691 . (1589 1605)) (64692 . (1590 1580)) (64693 . (1590 1581)) (64694 . (1590 1582)) (64695 . (1590 1605))
 (64696 . (1591 1581)) (64697 . (1592 1605)) (64698 . (1593 1580)) (64699 . (1593 1605)) (64700 . (1594 1580))
 (64701 . (1594 1605)) (64702 . (1601 1580)) (64703 . (1601 1581)) (64704 . (1601 1582)) (64705 . (1601 1605))
 (64706 . (1602 1581)) (64707 . (1602 1605)) (64708 . (1603 1580)) (64709 . (1603 1581)) (64710 . (1603 1582))
 (64711 . (1603 1604)) (64712 . (1603 1605)) (64713 . (1604 1580)) (64714 . (1604 1581)) (64715 . (1604 1582))
 (64716 . (1604 1605)) (64717 . (1604 1607)) (64718 . (1605 1580)) (64719 . (1605 1581)) (64720 . (1605 1582))
 (64721 . (1605 1605)) (64722 . (1606 1580)) (64723 . (1606 1581)) (64724 . (1606 1582)) (64725 . (1606 1605))
 (64726 . (1606 1607)) (64727 . (1607 1580)) (64728 . (1607 1605)) (64729 . (1607 1648)) (64730 . (1610 1580))
 (64731 . (1610 1581)) (64732 . (1610 1582)) (64733 . (1610 1605)) (64734 . (1610 1607)) (64735 . (1574 1605))
 (64736 . (1574 1607)) (64737 . (1576 1605)) (64738 . (1576 1607)) (64739 . (1578 1605)) (64740 . (1578 1607))
 (64741 . (1579 1605)) (64742 . (1579 1607)) (64743 . (1587 1605)) (64744 . (1587 1607)) (64745 . (1588 1605))
 (64746 . (1588 1607)) (64747 . (1603 1604)) (64748 . (1603 1605)) (64749 . (1604 1605)) (64750 . (1606 1605))
 (64751 . (1606 1607)) (64752 . (1610 1605)) (64753 . (1610 1607)) (64754 . (1600 1614 1617)) (64755 . (1600 1615 1617))
 (64756 . (1600 1616 1617)) (64757 . (1591 1609)) (64758 . (1591 1610)) (64759 . (1593 1609)) (64760 . (1593 1610))
 (64761 . (1594 1609)) (64762 . (1594 1610)) (64763 . (1587 1609)) (64764 . (1587 1610)) (64765 . (1588 1609))
 (64766 . (1588 1610)) (64767 . (1581 1609)) (64768 . (1581 1610)) (64769 . (1580 1609)) (64770 . (1580 1610))
 (64771 . (1582 1609)) (64772 . (1582 1610)) (64773 . (1589 1609)) (64774 . (1589 1610)) (64775 . (1590 1609))
 (64776 . (1590 1610)) (64777 . (1588 1580)) (64778 . (1588 1581)) (64779 . (1588 1582)) (64780 . (1588 1605))
 (64781 . (1588 1585)) (64782 . (1587 1585)) (64783 . (1589 1585)) (64784 . (1590 1585)) (64785 . (1591 1609))
 (64786 . (1591 1610)) (64787 . (1593 1609)) (64788 . (1593 1610)) (64789 . (1594 1609)) (64790 . (1594 1610))
 (64791 . (1587 1609)) (64792 . (1587 1610)) (64793 . (1588 1609)) (64794 . (1588 1610)) (64795 . (1581 1609))
 (64796 . (1581 1610)) (64797 . (1580 1609)) (64798 . (1580 1610)) (64799 . (1582 1609)) (64800 . (1582 1610))
 (64801 . (1589 1609)) (64802 . (1589 1610)) (64803 . (1590 1609)) (64804 . (1590 1610)) (64805 . (1588 1580))
 (64806 . (1588 1581)) (64807 . (1588 1582)) (64808 . (1588 1605)) (64809 . (1588 1585)) (64810 . (1587 1585))
 (64811 . (1589 1585)) (64812 . (1590 1585)) (64813 . (1588 1580)) (64814 . (1588 1581)) (64815 . (1588 1582))
 (64816 . (1588 1605)) (64817 . (1587 1607)) (64818 . (1588 1607)) (64819 . (1591 1605)) (64820 . (1587 1580))
 (64821 . (1587 1581)) (64822 . (1587 1582)) (64823 . (1588 1580)) (64824 . (1588 1581)) (64825 . (1588 1582))
 (64826 . (1591 1605)) (64827 . (1592 1605)) (64828 . (1575 1611)) (64829 . (1575 1611)) (64848 . (1578 1580 1605))
 (64849 . (1578 1581 1580)) (64850 . (1578 1581 1580)) (64851 . (1578 1581 1605)) (64852 . (1578 1582 1605)) (64853 . (1578 1605 1580))
 (64854 . (1578 1605 1581)) (64855 . (1578 1605 1582)) (64856 . (1580 1605 1581)) (64857 . (1580 1605 1581)) (64858 . (1581 1605 1610))
 (64859 . (1581 1605 1609)) (64860 . (1587 1581 1580)) (64861 . (1587 1580 1581)) (64862 . (1587 1580 1609)) (64863 . (1587 1605 1581))
 (64864 . (1587 1605 1581)) (64865 . (1587 1605 1580)) (64866 . (1587 1605 1605)) (64867 . (1587 1605 1605)) (64868 . (1589 1581 1581))
 (64869 . (1589 1581 1581)) (64870 . (1589 1605 1605)) (64871 . (1588 1581 1605)) (64872 . (1588 1581 1605)) (64873 . (1588 1580 1610))
 (64874 . (1588 1605 1582)) (64875 . (1588 1605 1582)) (64876 . (1588 1605 1605)) (64877 . (1588 1605 1605)) (64878 . (1590 1581 1609))
 (64879 . (1590 1582 1605)) (64880 . (1590 1582 1605)) (64881 . (1591 1605 1581)) (64882 . (1591 1605 1581)) (64883 . (1591 1605 1605))
 (64884 . (1591 1605 1610)) (64885 . (1593 1580 1605)) (64886 . (1593 1605 1605)) (64887 . (1593 1605 1605)) (64888 . (1593 1605 1609))
 (64889 . (1594 1605 1605)) (64890 . (1594 1605 1610)) (64891 . (1594 1605 1609)) (64892 . (1601 1582 1605)) (64893 . (1601 1582 1605))
 (64894 . (1602 1605 1581)) (64895 . (1602 1605 1605)) (64896 . (1604 1581 1605)) (64897 . (1604 1581 1610)) (64898 . (1604 1581 1609))
 (64899 . (1604 1580 1580)) (64900 . (1604 1580 1580)) (64901 . (1604 1582 1605)) (64902 . (1604 1582 1605)) (64903 . (1604 1605 1581))
 (64904 . (1604 1605 1581)) (64905 . (1605 1581 1580)) (64906 . (1605 1581 1605)) (64907 . (1605 1581 1610)) (64908 . (1605 1580 1581))
 (64909 . (1605 1580 1605)) (64910 . (1605 1582 1580)) (64911 . (1605 1582 1605)) (64914 . (1605 1580 1582)) (64915 . (1607 1605 1580))
 (64916 . (1607 1605 1605)) (64917 . (1606 1581 1605)) (64918 . (1606 1581 1609)) (64919 . (1606 1580 1605)) (64920 . (1606 1580 1605))
 (64921 . (1606 1580 1609)) (64922 . (1606 1605 1610)) (64923 . (1606 1605 1609)) (64924 . (1610 1605 1605)) (64925 . (1610 1605 1605))
 (64926 . (1576 1582 1610)) (64927 . (1578 1580 1610)) (64928 . (1578 1580 1609)) (64929 . (1578 1582 1610)) (64930 . (1578 1582 1609))
 (64931 . (1578 1605 1610)) (64932 . (1578 1605 1609)) (64933 . (1580 1605 1610)) (64934 . (1580 1581 1609)) (64935 . (1580 1605 1609))
 (64936 . (1587 1582 1609)) (64937 . (1589 1581 1610)) (64938 . (1588 1581 1610)) (64939 . (1590 1581 1610)) (64940 . (1604 1580 1610))
 (64941 . (1604 1605 1610)) (64942 . (1610 1581 1610)) (64943 . (1610 1580 1610)) (64944 . (1610 1605 1610)) (64945 . (1605 1605 1610))
 (64946 . (1602 1605 1610)) (64947 . (1606 1581 1610)) (64948 . (1602 1605 1581)) (64949 . (1604 1581 1605)) (64950 . (1593 1605 1610))
 (64951 . (1603 1605 1610)) (64952 . (1606 1580 1581)) (64953 . (1605 1582 1610)) (64954 . (1604 1580 1605)) (64955 . (1603 1605 1605))
 (64956 . (1604 1580 1605)) (64957 . (1606 1580 1581)) (64958 . (1580 1581 1610)) (64959 . (1581 1580 1610)) (64960 . (1605 1580 1610))
 (64961 . (1601 1605 1610)) (64962 . (1576 1581 1610)) (64963 . (1603 1605 1605)) (64964 . (1593 1580 1605)) (64965 . (1589 1605 1605))
 (64966 . (1587 1582 1610)) (64967 . (1606 1580 1610)) (65008 . (1589 1604 1746)) (65009 . (1602 1604 1746)) (65010 . (1575 1604 1604 1607))
 (65011 . (1575 1603 1576 1585)) (65012 . (1605 1581 1605 1583)) (65013 . (1589 1604 1593 1605)) (65014 . (1585 1587 1608 1604)) (65015 . (1593 1604 1610 1607))
 (65016 . (1608 1587 1604 1605)) (65017 . (1589 1604 1609)) (65018 . (1589 1604 1609 32 1575 1604 1604 1607 32 1593 1604 1610 1607 32 1608 1587 1604 1605)) (65019 . (1580 1604 32 1580 1604 1575 1604 1607)) (65020 . (1585 1740 1575 1604))
 (65040 . (44)) (65041 . (12289)) (65042 . (12290)) (65043 . (58)) (65044 . (59))
 (65045 . (33)) (65046 . (63)) (65047 . (12310)) (65048 . (12311)) (65049 . (8230))
 (65072 . (8229)) (65073 . (8212)) (65074 . (8211)) (65075 . (95)) (65076 . (95))
 (65077 . (40)) (65078 . (41)) (65079 . (123)) (65080 . (125)) (65081 . (12308))
 (65082 . (12309)) (65083 . (12304)) (65084 . (12305)) (65085 . (12298)) (65086 . (12299))
 (65087 . (12296)) (65088 . (12297)) (65089 . (12300)) (65090 . (12301)) (65091 . (12302))
 (65092 . (12303)) (65095 . (91)) (65096 . (93)) (65097 . (8254)) (65098 . (8254))
 (65099 . (8254)) (65100 . (8254)) (65101 . (95)) (65102 . (95)) (65103 . (95))
 (65104 . (44)) (65105 . (12289)) (65106 . (46)) (65108 . (59)) (65109 . (58))
 (65110 . (63)) (65111 . (33)) (65112 . (8212)) (65113 . (40)) (65114 . (41))
 (65115 . (123)) (65116 . (125)) (65117 . (12308)) (65118 . (12309)) (65119 . (35))
 (65120 . (38)) (65121 . (42)) (65122 . (43)) (65123 . (45)) (65124 . (60))
 (65125 . (62)) (65126 . (61)) (65128 . (92)) (65129 . (36)) (65130 . (37))
 (65131 . (64)) (65136 . (32 1611)) (65137 . (1600 1611)) (65138 . (32 1612)) (65140 . (32 1613))
 (65142 . (32 1614)) (65143 . (1600 1614)) (65144 . (32 1615)) (65145 . (1600 1615)) (65146 . (32 1616))
 (65147 . (1600 1616)) (65148 . (32 1617)) (65149 . (1600 1617)) (65150 . (32 1618)) (65151 . (1600 1618))
 (65152 . (1569)) (65153 . (1570)) (65154 . (1570)) (65155 . (1571)) (65156 . (1571))
 (65157 . (1572)) (65158 . (1572)) (65159 . (1573)) (65160 . (1573)) (65161 . (1574))
 (65162 . (1574)) (65163 . (1574)) (65164 . (1574)) (65165 . (1575)) (65166 . (1575))
 (65167 . (1576)) (65168 . (1576)) (65169 . (1576)) (65170 . (1576)) (65171 . (1577))
 (65172 . (1577)) (65173 . (1578)) (65174 . (1578)) (65175 . (1578)) (65176 . (1578))
 (65177 . (1579)) (65178 . (1579)) (65179 . (1579)) (65180 . (1579)) (65181 . (1580))
 (65182 . (1580)) (65183 . (1580)) (65184 . (1580)) (65185 . (1581)) (65186 . (1581))
 (65187 . (1581)) (65188 . (1581)) (65189 . (1582)) (65190 . (1582)) (65191 . (1582))
 (65192 . (1582)) (65193 . (1583)) (65194 . (1583)) (65195 . (1584)) (65196 . (1584))
 (65197 . (1585)) (65198 . (1585)) (65199 . (1586)) (65200 . (1586)) (65201 . (1587))
 (65202 . (1587)) (65203 . (1587)) (65204 . (1587)) (65205 . (1588)) (65206 . (1588))
 (65207 . (1588)) (65208 . (1588)) (65209 . (1589)) (65210 . (1589)) (65211 . (1589))
 (65212 . (1589)) (65213 . (1590)) (65214 . (1590)) (65215 . (1590)) (65216 . (1590))
 (65217 . (1591)) (65218 . (1591)) (65219 . (1591)) (65220 . (1591)) (65221 . (1592))
 (65222 . (1592)) (65223 . (1592)) (65224 . (1592)) (65225 . (1593)) (65226 . (1593))
 (65227 . (1593)) (65228 . (1593)) (65229 . (1594)) (65230 . (1594)) (65231 . (1594))
 (65232 . (1594)) (65233 . (1601)) (65234 . (1601)) (65235 . (1601)) (65236 . (1601))
 (65237 . (1602)) (65238 . (1602)) (65239 . (1602)) (65240 . (1602)) (65241 . (1603))
 (65242 . (1603)) (65243 . (1603)) (65244 . (1603)) (65245 . (1604)) (65246 . (1604))
 (65247 . (1604)) (65248 . (1604)) (65249 . (1605)) (65250 . (1605)) (65251 . (1605))
 (65252 . (1605)) (65253 . (1606)) (65254 . (1606)) (65255 . (1606)) (65256 . (1606))
 (65257 . (1607)) (65258 . (1607)) (65259 . (1607)) (65260 . (1607)) (65261 . (1608))
 (65262 . (1608)) (65263 . (1609)) (65264 . (1609)) (65265 . (1610)) (65266 . (1610))
 (65267 . (1610)) (65268 . (1610)) (65269 . (1604 1570)) (65270 . (1604 1570)) (65271 . (1604 1571))
 (65272 . (1604 1571)) (65273 . (1604 1573)) (65274 . (1604 1573)) (65275 . (1604 1575)) (65276 . (1604 1575))
 (65281 . (33)) (65282 . (34)) (65283 . (35)) (65284 . (36)) (65285 . (37))
 (65286 . (38)) (65287 . (39)) (65288 . (40)) (65289 . (41)) (65290 . (42))
 (65291 . (43)) (65292 . (44)) (65293 . (45)) (65294 . (46)) (65295 . (47))
 (65296 . (48)) (65297 . (49)) (65298 . (50)) (65299 . (51)) (65300 . (52))
 (65301 . (53)) (65302 . (54)) (65303 . (55)) (65304 . (56)) (65305 . (57))
 (65306 . (58)) (65307 . (59)) (65308 . (60)) (65309 . (61)) (65310 . (62))
 (65311 . (63)) (65312 . (64)) (65313 . (65)) (65314 . (66)) (65315 . (67))
 (65316 . (68)) (65317 . (69)) (65318 . (70)) (65319 . (71)) (65320 . (72))
 (65321 . (73)) (65322 . (74)) (65323 . (75)) (65324 . (76)) (65325 . (77))
 (65326 . (78)) (65327 . (79)) (65328 . (80)) (65329 . (81)) (65330 . (82))
 (65331 . (83)) (65332 . (84)) (65333 . (85)) (65334 . (86)) (65335 . (87))
 (65336 . (88)) (65337 . (89)) (65338 . (90)) (65339 . (91)) (65340 . (92))
 (65341 . (93)) (65342 . (94)) (65343 . (95)) (65344 . (96)) (65345 . (97))
 (65346 . (98)) (65347 . (99)) (65348 . (100)) (65349 . (101)) (65350 . (102))
 (65351 . (103)) (65352 . (104)) (65353 . (105)) (65354 . (106)) (65355 . (107))
 (65356 . (108)) (65357 . (109)) (65358 . (110)) (65359 . (111)) (65360 . (112))
 (65361 . (113)) (65362 . (114)) (65363 . (115)) (65364 . (116)) (65365 . (117))
 (65366 . (118)) (65367 . (119)) (65368 . (120)) (65369 . (121)) (65370 . (122))
 (65371 . (123)) (65372 . (124)) (65373 . (125)) (65374 . (126)) (65375 . (10629))
 (65376 . (10630)) (65377 . (12290)) (65378 . (12300)) (65379 . (12301)) (65380 . (12289))
 (65381 . (12539)) (65382 . (12530)) (65383 . (12449)) (65384 . (12451)) (65385 . (12453))
 (65386 . (12455)) (65387 . (12457)) (65388 . (12515)) (65389 . (12517)) (65390 . (12519))
 (65391 . (12483)) (65392 . (12540)) (65393 . (12450)) (65394 . (12452)) (65395 . (12454))
 (65396 . (12456)) (65397 . (12458)) (65398 . (12459)) (65399 . (12461)) (65400 . (12463))
 (65401 . (12465)) (65402 . (12467)) (65403 . (12469)) (65404 . (12471)) (65405 . (12473))
 (65406 . (12475)) (65407 . (12477)) (65408 . (12479)) (65409 . (12481)) (65410 . (12484))
 (65411 . (12486)) (65412 . (12488)) (65413 . (12490)) (65414 . (12491)) (65415 . (12492))
 (65416 . (12493)) (65417 . (12494)) (65418 . (12495)) (65419 . (12498)) (65420 . (12501))
 (65421 . (12504)) (65422 . (12507)) (65423 . (12510)) (65424 . (12511)) (65425 . (12512))
 (65426 . (12513)) (65427 . (12514)) (65428 . (12516)) (65429 . (12518)) (65430 . (12520))
 (65431 . (12521)) (65432 . (12522)) (65433 . (12523)) (65434 . (12524)) (65435 . (12525))
 (65436 . (12527)) (65437 . (12531)) (65438 . (12441)) (65439 . (12442)) (65440 . (12644))
 (65441 . (12593)) (65442 . (12594)) (65443 . (12595)) (65444 . (12596)) (65445 . (12597))
 (65446 . (12598)) (65447 . (12599)) (65448 . (12600)) (65449 . (12601)) (65450 . (12602))
 (65451 . (12603)) (65452 . (12604)) (65453 . (12605)) (65454 . (12606)) (65455 . (12607))
 (65456 . (12608)) (65457 . (12609)) (65458 . (12610)) (65459 . (12611)) (65460 . (12612))
 (65461 . (12613)) (65462 . (12614)) (65463 . (12615)) (65464 . (12616)) (65465 . (12617))
 (65466 . (12618)) (65467 . (12619)) (65468 . (12620)) (65469 . (12621)) (65470 . (12622))
 (65474 . (12623)) (65475 . (12624)) (65476 . (12625)) (65477 . (12626)) (65478 . (12627))
 (65479 . (12628)) (65482 . (12629)) (65483 . (12630)) (65484 . (12631)) (65485 . (12632))
 (65486 . (12633)) (65487 . (12634)) (65490 . (12635)) (65491 . (12636)) (65492 . (12637))
 (65493 . (12638)) (65494 . (12639)) (65495 . (12640)) (65498 . (12641)) (65499 . (12642))
 (65500 . (12643)) (65504 . (162)) (65505 . (163)) (65506 . (172)) (65507 . (175))
 (65508 . (166)) (65509 . (165)) (65510 . (8361)) (65512 . (9474)) (65513 . (8592))
 (65514 . (8593)) (65515 . (8594)) (65516 . (8595)) (65517 . (9632)) (65518 . (9675))
 (119808 . (65)) (119809 . (66)) (119810 . (67)) (119811 . (68)) (119812 . (69))
 (119813 . (70)) (119814 . (71)) (119815 . (72)) (119816 . (73)) (119817 . (74))
 (119818 . (75)) (119819 . (76)) (119820 . (77)) (119821 . (78)) (119822 . (79))
 (119823 . (80)) (119824 . (81)) (119825 . (82)) (119826 . (83)) (119827 . (84))
 (119828 . (85)) (119829 . (86)) (119830 . (87)) (119831 . (88)) (119832 . (89))
 (119833 . (90)) (119834 . (97)) (119835 . (98)) (119836 . (99)) (119837 . (100))
 (119838 . (101)) (119839 . (102)) (119840 . (103)) (119841 . (104)) (119842 . (105))
 (119843 . (106)) (119844 . (107)) (119845 . (108)) (119846 . (109)) (119847 . (110))
 (119848 . (111)) (119849 . (112)) (119850 . (113)) (119851 . (114)) (119852 . (115))
 (119853 . (116)) (119854 . (117)) (119855 . (118)) (119856 . (119)) (119857 . (120))
 (119858 . (121)) (119859 . (122)) (119860 . (65)) (119861 . (66)) (119862 . (67))
 (119863 . (68)) (119864 . (69)) (119865 . (70)) (119866 . (71)) (119867 . (72))
 (119868 . (73)) (119869 . (74)) (119870 . (75)) (119871 . (76)) (119872 . (77))
 (119873 . (78)) (119874 . (79)) (119875 . (80)) (119876 . (81)) (119877 . (82))
 (119878 . (83)) (119879 . (84)) (119880 . (85)) (119881 . (86)) (119882 . (87))
 (119883 . (88)) (119884 . (89)) (119885 . (90)) (119886 . (97)) (119887 . (98))
 (119888 . (99)) (119889 . (100)) (119890 . (101)) (119891 . (102)) (119892 . (103))
 (119894 . (105)) (119895 . (106)) (119896 . (107)) (119897 . (108)) (119898 . (109))
 (119899 . (110)) (119900 . (111)) (119901 . (112)) (119902 . (113)) (119903 . (114))
 (119904 . (115)) (119905 . (116)) (119906 . (117)) (119907 . (118)) (119908 . (119))
 (119909 . (120)) (119910 . (121)) (119911 . (122)) (119912 . (65)) (119913 . (66))
 (119914 . (67)) (119915 . (68)) (119916 . (69)) (119917 . (70)) (119918 . (71))
 (119919 . (72)) (119920 . (73)) (119921 . (74)) (119922 . (75)) (119923 . (76))
 (119924 . (77)) (119925 . (78)) (119926 . (79)) (119927 . (80)) (119928 . (81))
 (119929 . (82)) (119930 . (83)) (119931 . (84)) (119932 . (85)) (119933 . (86))
 (119934 . (87)) (119935 . (88)) (119936 . (89)) (119937 . (90)) (119938 . (97))
 (119939 . (98)) (119940 . (99)) (119941 . (100)) (119942 . (101)) (119943 . (102))
 (119944 . (103)) (119945 . (104)) (119946 . (105)) (119947 . (106)) (119948 . (107))
 (119949 . (108)) (119950 . (109)) (119951 . (110)) (119952 . (111)) (119953 . (112))
 (119954 . (113)) (119955 . (114)) (119956 . (115)) (119957 . (116)) (119958 . (117))
 (119959 . (118)) (119960 . (119)) (119961 . (120)) (119962 . (121)) (119963 . (122))
 (119964 . (65)) (119966 . (67)) (119967 . (68)) (119970 . (71)) (119973 . (74))
 (119974 . (75)) (119977 . (78)) (119978 . (79)) (119979 . (80)) (119980 . (81))
 (119982 . (83)) (119983 . (84)) (119984 . (85)) (119985 . (86)) (119986 . (87))
 (119987 . (88)) (119988 . (89)) (119989 . (90)) (119990 . (97)) (119991 . (98))
 (119992 . (99)) (119993 . (100)) (119995 . (102)) (119997 . (104)) (119998 . (105))
 (119999 . (106)) (120000 . (107)) (120001 . (108)) (120002 . (109)) (120003 . (110))
 (120005 . (112)) (120006 . (113)) (120007 . (114)) (120008 . (115)) (120009 . (116))
 (120010 . (117)) (120011 . (118)) (120012 . (119)) (120013 . (120)) (120014 . (121))
 (120015 . (122)) (120016 . (65)) (120017 . (66)) (120018 . (67)) (120019 . (68))
 (120020 . (69)) (120021 . (70)) (120022 . (71)) (120023 . (72)) (120024 . (73))
 (120025 . (74)) (120026 . (75)) (120027 . (76)) (120028 . (77)) (120029 . (78))
 (120030 . (79)) (120031 . (80)) (120032 . (81)) (120033 . (82)) (120034 . (83))
 (120035 . (84)) (120036 . (85)) (120037 . (86)) (120038 . (87)) (120039 . (88))
 (120040 . (89)) (120041 . (90)) (120042 . (97)) (120043 . (98)) (120044 . (99))
 (120045 . (100)) (120046 . (101)) (120047 . (102)) (120048 . (103)) (120049 . (104))
 (120050 . (105)) (120051 . (106)) (120052 . (107)) (120053 . (108)) (120054 . (109))
 (120055 . (110)) (120056 . (111)) (120057 . (112)) (120058 . (113)) (120059 . (114))
 (120060 . (115)) (120061 . (116)) (120062 . (117)) (120063 . (118)) (120064 . (119))
 (120065 . (120)) (120066 . (121)) (120067 . (122)) (120068 . (65)) (120069 . (66))
 (120071 . (68)) (120072 . (69)) (120073 . (70)) (120074 . (71)) (120077 . (74))
 (120078 . (75)) (120079 . (76)) (120080 . (77)) (120081 . (78)) (120082 . (79))
 (120083 . (80)) (120084 . (81)) (120086 . (83)) (120087 . (84)) (120088 . (85))
 (120089 . (86)) (120090 . (87)) (120091 . (88)) (120092 . (89)) (120094 . (97))
 (120095 . (98)) (120096 . (99)) (120097 . (100)) (120098 . (101)) (120099 . (102))
 (120100 . (103)) (120101 . (104)) (120102 . (105)) (120103 . (106)) (120104 . (107))
 (120105 . (108)) (120106 . (109)) (120107 . (110)) (120108 . (111)) (120109 . (112))
 (120110 . (113)) (120111 . (114)) (120112 . (115)) (120113 . (116)) (120114 . (117))
 (120115 . (118)) (120116 . (119)) (120117 . (120)) (120118 . (121)) (120119 . (122))
 (120120 . (65)) (120121 . (66)) (120123 . (68)) (120124 . (69)) (120125 . (70))
 (120126 . (71)) (120128 . (73)) (120129 . (74)) (120130 . (75)) (120131 . (76))
 (120132 . (77)) (120134 . (79)) (120138 . (83)) (120139 . (84)) (120140 . (85))
 (120141 . (86)) (120142 . (87)) (120143 . (88)) (120144 . (89)) (120146 . (97))
 (120147 . (98)) (120148 . (99)) (120149 . (100)) (120150 . (101)) (120151 . (102))
 (120152 . (103)) (120153 . (104)) (120154 . (105)) (120155 . (106)) (120156 . (107))
 (120157 . (108)) (120158 . (109)) (120159 . (110)) (120160 . (111)) (120161 . (112))
 (120162 . (113)) (120163 . (114)) (120164 . (115)) (120165 . (116)) (120166 . (117))
 (120167 . (118)) (120168 . (119)) (120169 . (120)) (120170 . (121)) (120171 . (122))
 (120172 . (65)) (120173 . (66)) (120174 . (67)) (120175 . (68)) (120176 . (69))
 (120177 . (70)) (120178 . (71)) (120179 . (72)) (120180 . (73)) (120181 . (74))
 (120182 . (75)) (120183 . (76)) (120184 . (77)) (120185 . (78)) (120186 . (79))
 (120187 . (80)) (120188 . (81)) (120189 . (82)) (120190 . (83)) (120191 . (84))
 (120192 . (85)) (120193 . (86)) (120194 . (87)) (120195 . (88)) (120196 . (89))
 (120197 . (90)) (120198 . (97)) (120199 . (98)) (120200 . (99)) (120201 . (100))
 (120202 . (101)) (120203 . (102)) (120204 . (103)) (120205 . (104)) (120206 . (105))
 (120207 . (106)) (120208 . (107)) (120209 . (108)) (120210 . (109)) (120211 . (110))
 (120212 . (111)) (120213 . (112)) (120214 . (113)) (120215 . (114)) (120216 . (115))
 (120217 . (116)) (120218 . (117)) (120219 . (118)) (120220 . (119)) (120221 . (120))
 (120222 . (121)) (120223 . (122)) (120224 . (65)) (120225 . (66)) (120226 . (67))
 (120227 . (68)) (120228 . (69)) (120229 . (70)) (120230 . (71)) (120231 . (72))
 (120232 . (73)) (120233 . (74)) (120234 . (75)) (120235 . (76)) (120236 . (77))
 (120237 . (78)) (120238 . (79)) (120239 . (80)) (120240 . (81)) (120241 . (82))
 (120242 . (83)) (120243 . (84)) (120244 . (85)) (120245 . (86)) (120246 . (87))
 (120247 . (88)) (120248 . (89)) (120249 . (90)) (120250 . (97)) (120251 . (98))
 (120252 . (99)) (120253 . (100)) (120254 . (101)) (120255 . (102)) (120256 . (103))
 (120257 . (104)) (120258 . (105)) (120259 . (106)) (120260 . (107)) (120261 . (108))
 (120262 . (109)) (120263 . (110)) (120264 . (111)) (120265 . (112)) (120266 . (113))
 (120267 . (114)) (120268 . (115)) (120269 . (116)) (120270 . (117)) (120271 . (118))
 (120272 . (119)) (120273 . (120)) (120274 . (121)) (120275 . (122)) (120276 . (65))
 (120277 . (66)) (120278 . (67)) (120279 . (68)) (120280 . (69)) (120281 . (70))
 (120282 . (71)) (120283 . (72)) (120284 . (73)) (120285 . (74)) (120286 . (75))
 (120287 . (76)) (120288 . (77)) (120289 . (78)) (120290 . (79)) (120291 . (80))
 (120292 . (81)) (120293 . (82)) (120294 . (83)) (120295 . (84)) (120296 . (85))
 (120297 . (86)) (120298 . (87)) (120299 . (88)) (120300 . (89)) (120301 . (90))
 (120302 . (97)) (120303 . (98)) (120304 . (99)) (120305 . (100)) (120306 . (101))
 (120307 . (102)) (120308 . (103)) (120309 . (104)) (120310 . (105)) (120311 . (106))
 (120312 . (107)) (120313 . (108)) (120314 . (109)) (120315 . (110)) (120316 . (111))
 (120317 . (112)) (120318 . (113)) (120319 . (114)) (120320 . (115)) (120321 . (116))
 (120322 . (117)) (120323 . (118)) (120324 . (119)) (120325 . (120)) (120326 . (121))
 (120327 . (122)) (120328 . (65)) (120329 . (66)) (120330 . (67)) (120331 . (68))
 (120332 . (69)) (120333 . (70)) (120334 . (71)) (120335 . (72)) (120336 . (73))
 (120337 . (74)) (120338 . (75)) (120339 . (76)) (120340 . (77)) (120341 . (78))
 (120342 . (79)) (120343 . (80)) (120344 . (81)) (120345 . (82)) (120346 . (83))
 (120347 . (84)) (120348 . (85)) (120349 . (86)) (120350 . (87)) (120351 . (88))
 (120352 . (89)) (120353 . (90)) (120354 . (97)) (120355 . (98)) (120356 . (99))
 (120357 . (100)) (120358 . (101)) (120359 . (102)) (120360 . (103)) (120361 . (104))
 (120362 . (105)) (120363 . (106)) (120364 . (107)) (120365 . (108)) (120366 . (109))
 (120367 . (110)) (120368 . (111)) (120369 . (112)) (120370 . (113)) (120371 . (114))
 (120372 . (115)) (120373 . (116)) (120374 . (117)) (120375 . (118)) (120376 . (119))
 (120377 . (120)) (120378 . (121)) (120379 . (122)) (120380 . (65)) (120381 . (66))
 (120382 . (67)) (120383 . (68)) (120384 . (69)) (120385 . (70)) (120386 . (71))
 (120387 . (72)) (120388 . (73)) (120389 . (74)) (120390 . (75)) (120391 . (76))
 (120392 . (77)) (120393 . (78)) (120394 . (79)) (120395 . (80)) (120396 . (81))
 (120397 . (82)) (120398 . (83)) (120399 . (84)) (120400 . (85)) (120401 . (86))
 (120402 . (87)) (120403 . (88)) (120404 . (89)) (120405 . (90)) (120406 . (97))
 (120407 . (98)) (120408 . (99)) (120409 . (100)) (120410 . (101)) (120411 . (102))
 (120412 . (103)) (120413 . (104)) (120414 . (105)) (120415 . (106)) (120416 . (107))
 (120417 . (108)) (120418 . (109)) (120419 . (110)) (120420 . (111)) (120421 . (112))
 (120422 . (113)) (120423 . (114)) (120424 . (115)) (120425 . (116)) (120426 . (117))
 (120427 . (118)) (120428 . (119)) (120429 . (120)) (120430 . (121)) (120431 . (122))
 (120432 . (65)) (120433 . (66)) (120434 . (67)) (120435 . (68)) (120436 . (69))
 (120437 . (70)) (120438 . (71)) (120439 . (72)) (120440 . (73)) (120441 . (74))
 (120442 . (75)) (120443 . (76)) (120444 . (77)) (120445 . (78)) (120446 . (79))
 (120447 . (80)) (120448 . (81)) (120449 . (82)) (120450 . (83)) (120451 . (84))
 (120452 . (85)) (120453 . (86)) (120454 . (87)) (120455 . (88)) (120456 . (89))
 (120457 . (90)) (120458 . (97)) (120459 . (98)) (120460 . (99)) (120461 . (100))
 (120462 . (101)) (120463 . (102)) (120464 . (103)) (120465 . (104)) (120466 . (105))
 (120467 . (106)) (120468 . (107)) (120469 . (108)) (120470 . (109)) (120471 . (110))
 (120472 . (111)) (120473 . (112)) (120474 . (113)) (120475 . (114)) (120476 . (115))
 (120477 . (116)) (120478 . (117)) (120479 . (118)) (120480 . (119)) (120481 . (120))
 (120482 . (121)) (120483 . (122)) (120484 . (305)) (120485 . (567)) (120488 . (913))
 (120489 . (914)) (120490 . (915)) (120491 . (916)) (120492 . (917)) (120493 . (918))
 (120494 . (919)) (120495 . (920)) (120496 . (921)) (120497 . (922)) (120498 . (923))
 (120499 . (924)) (120500 . (925)) (120501 . (926)) (120502 . (927)) (120503 . (928))
 (120504 . (929)) (120505 . (1012)) (120506 . (931)) (120507 . (932)) (120508 . (933))
 (120509 . (934)) (120510 . (935)) (120511 . (936)) (120512 . (937)) (120513 . (8711))
 (120514 . (945)) (120515 . (946)) (120516 . (947)) (120517 . (948)) (120518 . (949))
 (120519 . (950)) (120520 . (951)) (120521 . (952)) (120522 . (953)) (120523 . (954))
 (120524 . (955)) (120525 . (956)) (120526 . (957)) (120527 . (958)) (120528 . (959))
 (120529 . (960)) (120530 . (961)) (120531 . (962)) (120532 . (963)) (120533 . (964))
 (120534 . (965)) (120535 . (966)) (120536 . (967)) (120537 . (968)) (120538 . (969))
 (120539 . (8706)) (120540 . (1013)) (120541 . (977)) (120542 . (1008)) (120543 . (981))
 (120544 . (1009)) (120545 . (982)) (120546 . (913)) (120547 . (914)) (120548 . (915))
 (120549 . (916)) (120550 . (917)) (120551 . (918)) (120552 . (919)) (120553 . (920))
 (120554 . (921)) (120555 . (922)) (120556 . (923)) (120557 . (924)) (120558 . (925))
 (120559 . (926)) (120560 . (927)) (120561 . (928)) (120562 . (929)) (120563 . (1012))
 (120564 . (931)) (120565 . (932)) (120566 . (933)) (120567 . (934)) (120568 . (935))
 (120569 . (936)) (120570 . (937)) (120571 . (8711)) (120572 . (945)) (120573 . (946))
 (120574 . (947)) (120575 . (948)) (120576 . (949)) (120577 . (950)) (120578 . (951))
 (120579 . (952)) (120580 . (953)) (120581 . (954)) (120582 . (955)) (120583 . (956))
 (120584 . (957)) (120585 . (958)) (120586 . (959)) (120587 . (960)) (120588 . (961))
 (120589 . (962)) (120590 . (963)) (120591 . (964)) (120592 . (965)) (120593 . (966))
 (120594 . (967)) (120595 . (968)) (120596 . (969)) (120597 . (8706)) (120598 . (1013))
 (120599 . (977)) (120600 . (1008)) (120601 . (981)) (120602 . (1009)) (120603 . (982))
 (120604 . (913)) (120605 . (914)) (120606 . (915)) (120607 . (916)) (120608 . (917))
 (120609 . (918)) (120610 . (919)) (120611 . (920)) (120612 . (921)) (120613 . (922))
 (120614 . (923)) (120615 . (924)) (120616 . (925)) (120617 . (926)) (120618 . (927))
 (120619 . (928)) (120620 . (929)) (120621 . (1012)) (120622 . (931)) (120623 . (932))
 (120624 . (933)) (120625 . (934)) (120626 . (935)) (120627 . (936)) (120628 . (937))
 (120629 . (8711)) (120630 . (945)) (120631 . (946)) (120632 . (947)) (120633 . (948))
 (120634 . (949)) (120635 . (950)) (120636 . (951)) (120637 . (952)) (120638 . (953))
 (120639 . (954)) (120640 . (955)) (120641 . (956)) (120642 . (957)) (120643 . (958))
 (120644 . (959)) (120645 . (960)) (120646 . (961)) (120647 . (962)) (120648 . (963))
 (120649 . (964)) (120650 . (965)) (120651 . (966)) (120652 . (967)) (120653 . (968))
 (120654 . (969)) (120655 . (8706)) (120656 . (1013)) (120657 . (977)) (120658 . (1008))
 (120659 . (981)) (120660 . (1009)) (120661 . (982)) (120662 . (913)) (120663 . (914))
 (120664 . (915)) (120665 . (916)) (120666 . (917)) (120667 . (918)) (120668 . (919))
 (120669 . (920)) (120670 . (921)) (120671 . (922)) (120672 . (923)) (120673 . (924))
 (120674 . (925)) (120675 . (926)) (120676 . (927)) (120677 . (928)) (120678 . (929))
 (120679 . (1012)) (120680 . (931)) (120681 . (932)) (120682 . (933)) (120683 . (934))
 (120684 . (935)) (120685 . (936)) (120686 . (937)) (120687 . (8711)) (120688 . (945))
 (120689 . (946)) (120690 . (947)) (120691 . (948)) (120692 . (949)) (120693 . (950))
 (120694 . (951)) (120695 . (952)) (120696 . (953)) (120697 . (954)) (120698 . (955))
 (120699 . (956)) (120700 . (957)) (120701 . (958)) (120702 . (959)) (120703 . (960))
 (120704 . (961)) (120705 . (962)) (120706 . (963)) (120707 . (964)) (120708 . (965))
 (120709 . (966)) (120710 . (967)) (120711 . (968)) (120712 . (969)) (120713 . (8706))
 (120714 . (1013)) (120715 . (977)) (120716 . (1008)) (120717 . (981)) (120718 . (1009))
 (120719 . (982)) (120720 . (913)) (120721 . (914)) (120722 . (915)) (120723 . (916))
 (120724 . (917)) (120725 . (918)) (120726 . (919)) (120727 . (920)) (120728 . (921))
 (120729 . (922)) (120730 . (923)) (120731 . (924)) (120732 . (925)) (120733 . (926))
 (120734 . (927)) (120735 . (928)) (120736 . (929)) (120737 . (1012)) (120738 . (931))
 (120739 . (932)) (120740 . (933)) (120741 . (934)) (120742 . (935)) (120743 . (936))
 (120744 . (937)) (120745 . (8711)) (120746 . (945)) (120747 . (946)) (120748 . (947))
 (120749 . (948)) (120750 . (949)) (120751 . (950)) (120752 . (951)) (120753 . (952))
 (120754 . (953)) (120755 . (954)) (120756 . (955)) (120757 . (956)) (120758 . (957))
 (120759 . (958)) (120760 . (959)) (120761 . (960)) (120762 . (961)) (120763 . (962))
 (120764 . (963)) (120765 . (964)) (120766 . (965)) (120767 . (966)) (120768 . (967))
 (120769 . (968)) (120770 . (969)) (120771 . (8706)) (120772 . (1013)) (120773 . (977))
 (120774 . (1008)) (120775 . (981)) (120776 . (1009)) (120777 . (982)) (120778 . (988))
 (120779 . (989)) (120782 . (48)) (120783 . (49)) (120784 . (50)) (120785 . (51))
 (120786 . (52)) (120787 . (53)) (120788 . (54)) (120789 . (55)) (120790 . (56))
 (120791 . (57)) (120792 . (48)) (120793 . (49)) (120794 . (50)) (120795 . (51))
 (120796 . (52)) (120797 . (53)) (120798 . (54)) (120799 . (55)) (120800 . (56))
 (120801 . (57)) (120802 . (48)) (120803 . (49)) (120804 . (50)) (120805 . (51))
 (120806 . (52)) (120807 . (53)) (120808 . (54)) (120809 . (55)) (120810 . (56))
 (120811 . (57)) (120812 . (48)) (120813 . (49)) (120814 . (50)) (120815 . (51))
 (120816 . (52)) (120817 . (53)) (120818 . (54)) (120819 . (55)) (120820 . (56))
 (120821 . (57)) (120822 . (48)) (120823 . (49)) (120824 . (50)) (120825 . (51))
 (120826 . (52)) (120827 . (53)) (120828 . (54)) (120829 . (55)) (120830 . (56))
 (120831 . (57))))
(define combination-class-list '((1 . (820 821 822 823 824 8402 8403 8408 8409 8410 8421 8422 8426 8427 68153 119143 119144 119145))
                                 (103 . (3640 3641))
                                 (7 . (2364 2492 2620 2748 2876 3260 4151 6964 7223))
                                 (202 . (801 802 807 808 7632))
                                 (8 . (12441 12442))
                                 (9 . (2381 2509 2637 2765 2893 3021 3149 3277 3405 3530 3642 3972 4153 4154 5908 5940 6098 6980 7082 43014 43204 43347 68159))
                                 (107 . (3656 3657 3658 3659))
                                 (10 . (1456))
                                 (11 . (1457))
                                 (12 . (1458))
                                 (13 . (1459))
                                 (14 . (1460))
                                 (15 . (1461))
                                 (16 . (1462))
                                 (17 . (1463))
                                 (18 . (1464 1479))
                                 (19 . (1465 1466))
                                 (214 . (7630))
                                 (20 . (1467))
                                 (118 . (3768 3769))
                                 (21 . (1468))
                                 (216 . (795 3897 119141 119142 119150 119151 119152 119153 119154))
                                 (22 . (1469))
                                 (23 . (1471))
                                 (218 . (12330))
                                 (24 . (1473))
                                 (122 . (3784 3785 3786 3787))
                                 (25 . (1474))
                                 (220 . (790 791 792 793 796 797 798 799 800 803 804 805 806 809 810 811 812 813 814 815 816 817 818 819 825 826 827 828 839 840 841 845 846 851 852 853 854 857 858 1425 1430 1435 1442 1443 1444 1445 1446 1447 1450 1477 1621 1622 1628 1763 1770 1773 1841 1844 1847 1848 1849 1851 1852 1854 1858 1860 1862 1864 2034 2386 3864 3865 3893 3895 4038 4237 6459 6680 7020 7618 7626 7631 7679 8424 8428 8429 8430 8431 43307 43308 43309 66045 68109 68154 119163 119164 119165 119166 119167 119168 119169 119170 119178 119179))
                                 (26 . (64286))
                                 (27 . (1611))
                                 (222 . (1434 1453 6457 12333))
                                 (28 . (1612))
                                 (29 . (1613))
                                 (224 . (12334 12335))
                                 (30 . (1560 1614))
                                 (31 . (1561 1615))
                                 (226 . (119149))
                                 (129 . (3953))
                                 (32 . (1562 1616))
                                 (130 . (3954 3962 3963 3964 3965 3968))
                                 (33 . (1617))
                                 (228 . (1454 6313 12331))
                                 (34 . (1618))
                                 (132 . (3956))
                                 (35 . (1648))
                                 (230 . (768 769 770 771 772 773 774 775 776 777 778 779 780 781 782 783 784 785 786 787 788 829 830 831 832 833 834 835 836 838 842 843 844 848 849 850 855 859 867 868 869 870 871 872 873 874 875 876 877 878 879 1155 1156 1157 1158 1159 1426 1427 1428 1429 1431 1432 1433 1436 1437 1438 1439 1440 1441 1448 1449 1451 1452 1455 1476 1552 1553 1554 1555 1556 1557 1558 1559 1619 1620 1623 1624 1625 1626 1627 1629 1630 1750 1751 1752 1753 1754 1755 1756 1759 1760 1761 1762 1764 1767 1768 1771 1772 1840 1842 1843 1845 1846 1850 1853 1855 1856 1857 1859 1861 1863 1865 1866 2027 2028 2029 2030 2031 2032 2033 2035 2385 2387 2388 3970 3971 3974 3975 4959 6109 6458 6679 7019 7021 7022 7023 7024 7025 7026 7027 7616 7617 7619 7620 7621 7622 7623 7624 7625 7627 7628 7633 7634 7635 7636 7637 7638 7639 7640 7641 7642 7643 7644 7645 7646 7647 7648 7649 7650 7651 7652 7653 7654 7678 8400 8401 8404 8405 8406 8407 8411 8412 8417 8423 8425 8432 11744 11745 11746 11747 11748 11749 11750 11751 11752 11753 11754 11755 11756 11757 11758 11759 11760 11761 11762 11763 11764 11765 11766 11767 11768 11769 11770 11771 11772 11773 11774 11775 42607 42620 42621 65056 65057 65058 65059 65060 65061 65062 68111 68152 119173 119174 119175 119176 119177 119210 119211 119212 119213 119362 119363 119364))
                                 (36 . (1809))
                                 (232 . (789 794 856 12332))
                                 (233 . (860 863 866))
                                 (234 . (861 862 864 865 7629))
                                 (240 . (837))
                                 (84 . (3157))
                                 (91 . (3158))
                                 ))

(define canonical-decompose-list '( (192 . (65 768))
 (193 . (65 769)) (194 . (65 770)) (195 . (65 771)) (196 . (65 776)) (197 . (65 778))
 (199 . (67 807)) (200 . (69 768)) (201 . (69 769)) (202 . (69 770)) (203 . (69 776))
 (204 . (73 768)) (205 . (73 769)) (206 . (73 770)) (207 . (73 776)) (209 . (78 771))
 (210 . (79 768)) (211 . (79 769)) (212 . (79 770)) (213 . (79 771)) (214 . (79 776))
 (217 . (85 768)) (218 . (85 769)) (219 . (85 770)) (220 . (85 776)) (221 . (89 769))
 (224 . (97 768)) (225 . (97 769)) (226 . (97 770)) (227 . (97 771)) (228 . (97 776))
 (229 . (97 778)) (231 . (99 807)) (232 . (101 768)) (233 . (101 769)) (234 . (101 770))
 (235 . (101 776)) (236 . (105 768)) (237 . (105 769)) (238 . (105 770)) (239 . (105 776))
 (241 . (110 771)) (242 . (111 768)) (243 . (111 769)) (244 . (111 770)) (245 . (111 771))
 (246 . (111 776)) (249 . (117 768)) (250 . (117 769)) (251 . (117 770)) (252 . (117 776))
 (253 . (121 769)) (255 . (121 776)) (256 . (65 772)) (257 . (97 772)) (258 . (65 774))
 (259 . (97 774)) (260 . (65 808)) (261 . (97 808)) (262 . (67 769)) (263 . (99 769))
 (264 . (67 770)) (265 . (99 770)) (266 . (67 775)) (267 . (99 775)) (268 . (67 780))
 (269 . (99 780)) (270 . (68 780)) (271 . (100 780)) (274 . (69 772)) (275 . (101 772))
 (276 . (69 774)) (277 . (101 774)) (278 . (69 775)) (279 . (101 775)) (280 . (69 808))
 (281 . (101 808)) (282 . (69 780)) (283 . (101 780)) (284 . (71 770)) (285 . (103 770))
 (286 . (71 774)) (287 . (103 774)) (288 . (71 775)) (289 . (103 775)) (290 . (71 807))
 (291 . (103 807)) (292 . (72 770)) (293 . (104 770)) (296 . (73 771)) (297 . (105 771))
 (298 . (73 772)) (299 . (105 772)) (300 . (73 774)) (301 . (105 774)) (302 . (73 808))
 (303 . (105 808)) (304 . (73 775)) (308 . (74 770)) (309 . (106 770)) (310 . (75 807))
 (311 . (107 807)) (313 . (76 769)) (314 . (108 769)) (315 . (76 807)) (316 . (108 807))
 (317 . (76 780)) (318 . (108 780)) (323 . (78 769)) (324 . (110 769)) (325 . (78 807))
 (326 . (110 807)) (327 . (78 780)) (328 . (110 780)) (332 . (79 772)) (333 . (111 772))
 (334 . (79 774)) (335 . (111 774)) (336 . (79 779)) (337 . (111 779)) (340 . (82 769))
 (341 . (114 769)) (342 . (82 807)) (343 . (114 807)) (344 . (82 780)) (345 . (114 780))
 (346 . (83 769)) (347 . (115 769)) (348 . (83 770)) (349 . (115 770)) (350 . (83 807))
 (351 . (115 807)) (352 . (83 780)) (353 . (115 780)) (354 . (84 807)) (355 . (116 807))
 (356 . (84 780)) (357 . (116 780)) (360 . (85 771)) (361 . (117 771)) (362 . (85 772))
 (363 . (117 772)) (364 . (85 774)) (365 . (117 774)) (366 . (85 778)) (367 . (117 778))
 (368 . (85 779)) (369 . (117 779)) (370 . (85 808)) (371 . (117 808)) (372 . (87 770))
 (373 . (119 770)) (374 . (89 770)) (375 . (121 770)) (376 . (89 776)) (377 . (90 769))
 (378 . (122 769)) (379 . (90 775)) (380 . (122 775)) (381 . (90 780)) (382 . (122 780))
 (416 . (79 795)) (417 . (111 795)) (431 . (85 795)) (432 . (117 795)) (461 . (65 780))
 (462 . (97 780)) (463 . (73 780)) (464 . (105 780)) (465 . (79 780)) (466 . (111 780))
 (467 . (85 780)) (468 . (117 780)) (469 . (220 772)) (470 . (252 772)) (471 . (220 769))
 (472 . (252 769)) (473 . (220 780)) (474 . (252 780)) (475 . (220 768)) (476 . (252 768))
 (478 . (196 772)) (479 . (228 772)) (480 . (550 772)) (481 . (551 772)) (482 . (198 772))
 (483 . (230 772)) (486 . (71 780)) (487 . (103 780)) (488 . (75 780)) (489 . (107 780))
 (490 . (79 808)) (491 . (111 808)) (492 . (490 772)) (493 . (491 772)) (494 . (439 780))
 (495 . (658 780)) (496 . (106 780)) (500 . (71 769)) (501 . (103 769)) (504 . (78 768))
 (505 . (110 768)) (506 . (197 769)) (507 . (229 769)) (508 . (198 769)) (509 . (230 769))
 (510 . (216 769)) (511 . (248 769)) (512 . (65 783)) (513 . (97 783)) (514 . (65 785))
 (515 . (97 785)) (516 . (69 783)) (517 . (101 783)) (518 . (69 785)) (519 . (101 785))
 (520 . (73 783)) (521 . (105 783)) (522 . (73 785)) (523 . (105 785)) (524 . (79 783))
 (525 . (111 783)) (526 . (79 785)) (527 . (111 785)) (528 . (82 783)) (529 . (114 783))
 (530 . (82 785)) (531 . (114 785)) (532 . (85 783)) (533 . (117 783)) (534 . (85 785))
 (535 . (117 785)) (536 . (83 806)) (537 . (115 806)) (538 . (84 806)) (539 . (116 806))
 (542 . (72 780)) (543 . (104 780)) (550 . (65 775)) (551 . (97 775)) (552 . (69 807))
 (553 . (101 807)) (554 . (214 772)) (555 . (246 772)) (556 . (213 772)) (557 . (245 772))
 (558 . (79 775)) (559 . (111 775)) (560 . (558 772)) (561 . (559 772)) (562 . (89 772))
 (563 . (121 772)) (832 . (768)) (833 . (769)) (835 . (787)) (836 . (776 769))
 (884 . (697)) (894 . (59)) (901 . (168 769)) (902 . (913 769)) (903 . (183))
 (904 . (917 769)) (905 . (919 769)) (906 . (921 769)) (908 . (927 769)) (910 . (933 769))
 (911 . (937 769)) (912 . (970 769)) (938 . (921 776)) (939 . (933 776)) (940 . (945 769))
 (941 . (949 769)) (942 . (951 769)) (943 . (953 769)) (944 . (971 769)) (970 . (953 776))
 (971 . (965 776)) (972 . (959 769)) (973 . (965 769)) (974 . (969 769)) (979 . (978 769))
 (980 . (978 776)) (1024 . (1045 768)) (1025 . (1045 776)) (1027 . (1043 769)) (1031 . (1030 776))
 (1036 . (1050 769)) (1037 . (1048 768)) (1038 . (1059 774)) (1049 . (1048 774)) (1081 . (1080 774))
 (1104 . (1077 768)) (1105 . (1077 776)) (1107 . (1075 769)) (1111 . (1110 776)) (1116 . (1082 769))
 (1117 . (1080 768)) (1118 . (1091 774)) (1142 . (1140 783)) (1143 . (1141 783)) (1217 . (1046 774))
 (1218 . (1078 774)) (1232 . (1040 774)) (1233 . (1072 774)) (1234 . (1040 776)) (1235 . (1072 776))
 (1238 . (1045 774)) (1239 . (1077 774)) (1242 . (1240 776)) (1243 . (1241 776)) (1244 . (1046 776))
 (1245 . (1078 776)) (1246 . (1047 776)) (1247 . (1079 776)) (1250 . (1048 772)) (1251 . (1080 772))
 (1252 . (1048 776)) (1253 . (1080 776)) (1254 . (1054 776)) (1255 . (1086 776)) (1258 . (1256 776))
 (1259 . (1257 776)) (1260 . (1069 776)) (1261 . (1101 776)) (1262 . (1059 772)) (1263 . (1091 772))
 (1264 . (1059 776)) (1265 . (1091 776)) (1266 . (1059 779)) (1267 . (1091 779)) (1268 . (1063 776))
 (1269 . (1095 776)) (1272 . (1067 776)) (1273 . (1099 776)) (1570 . (1575 1619)) (1571 . (1575 1620))
 (1572 . (1608 1620)) (1573 . (1575 1621)) (1574 . (1610 1620)) (1728 . (1749 1620)) (1730 . (1729 1620))
 (1747 . (1746 1620)) (2345 . (2344 2364)) (2353 . (2352 2364)) (2356 . (2355 2364)) (2392 . (2325 2364))
 (2393 . (2326 2364)) (2394 . (2327 2364)) (2395 . (2332 2364)) (2396 . (2337 2364)) (2397 . (2338 2364))
 (2398 . (2347 2364)) (2399 . (2351 2364)) (2507 . (2503 2494)) (2508 . (2503 2519)) (2524 . (2465 2492))
 (2525 . (2466 2492)) (2527 . (2479 2492)) (2611 . (2610 2620)) (2614 . (2616 2620)) (2649 . (2582 2620))
 (2650 . (2583 2620)) (2651 . (2588 2620)) (2654 . (2603 2620)) (2888 . (2887 2902)) (2891 . (2887 2878))
 (2892 . (2887 2903)) (2908 . (2849 2876)) (2909 . (2850 2876)) (2964 . (2962 3031)) (3018 . (3014 3006))
 (3019 . (3015 3006)) (3020 . (3014 3031)) (3144 . (3142 3158)) (3264 . (3263 3285)) (3271 . (3270 3285))
 (3272 . (3270 3286)) (3274 . (3270 3266)) (3275 . (3274 3285)) (3402 . (3398 3390)) (3403 . (3399 3390))
 (3404 . (3398 3415)) (3546 . (3545 3530)) (3548 . (3545 3535)) (3549 . (3548 3530)) (3550 . (3545 3551))
 (3907 . (3906 4023)) (3917 . (3916 4023)) (3922 . (3921 4023)) (3927 . (3926 4023)) (3932 . (3931 4023))
 (3945 . (3904 4021)) (3955 . (3953 3954)) (3957 . (3953 3956)) (3958 . (4018 3968)) (3960 . (4019 3968))
 (3969 . (3953 3968)) (3987 . (3986 4023)) (3997 . (3996 4023)) (4002 . (4001 4023)) (4007 . (4006 4023))
 (4012 . (4011 4023)) (4025 . (3984 4021)) (4134 . (4133 4142)) (6918 . (6917 6965)) (6920 . (6919 6965))
 (6922 . (6921 6965)) (6924 . (6923 6965)) (6926 . (6925 6965)) (6930 . (6929 6965)) (6971 . (6970 6965))
 (6973 . (6972 6965)) (6976 . (6974 6965)) (6977 . (6975 6965)) (6979 . (6978 6965)) (7680 . (65 805))
 (7681 . (97 805)) (7682 . (66 775)) (7683 . (98 775)) (7684 . (66 803)) (7685 . (98 803))
 (7686 . (66 817)) (7687 . (98 817)) (7688 . (199 769)) (7689 . (231 769)) (7690 . (68 775))
 (7691 . (100 775)) (7692 . (68 803)) (7693 . (100 803)) (7694 . (68 817)) (7695 . (100 817))
 (7696 . (68 807)) (7697 . (100 807)) (7698 . (68 813)) (7699 . (100 813)) (7700 . (274 768))
 (7701 . (275 768)) (7702 . (274 769)) (7703 . (275 769)) (7704 . (69 813)) (7705 . (101 813))
 (7706 . (69 816)) (7707 . (101 816)) (7708 . (552 774)) (7709 . (553 774)) (7710 . (70 775))
 (7711 . (102 775)) (7712 . (71 772)) (7713 . (103 772)) (7714 . (72 775)) (7715 . (104 775))
 (7716 . (72 803)) (7717 . (104 803)) (7718 . (72 776)) (7719 . (104 776)) (7720 . (72 807))
 (7721 . (104 807)) (7722 . (72 814)) (7723 . (104 814)) (7724 . (73 816)) (7725 . (105 816))
 (7726 . (207 769)) (7727 . (239 769)) (7728 . (75 769)) (7729 . (107 769)) (7730 . (75 803))
 (7731 . (107 803)) (7732 . (75 817)) (7733 . (107 817)) (7734 . (76 803)) (7735 . (108 803))
 (7736 . (7734 772)) (7737 . (7735 772)) (7738 . (76 817)) (7739 . (108 817)) (7740 . (76 813))
 (7741 . (108 813)) (7742 . (77 769)) (7743 . (109 769)) (7744 . (77 775)) (7745 . (109 775))
 (7746 . (77 803)) (7747 . (109 803)) (7748 . (78 775)) (7749 . (110 775)) (7750 . (78 803))
 (7751 . (110 803)) (7752 . (78 817)) (7753 . (110 817)) (7754 . (78 813)) (7755 . (110 813))
 (7756 . (213 769)) (7757 . (245 769)) (7758 . (213 776)) (7759 . (245 776)) (7760 . (332 768))
 (7761 . (333 768)) (7762 . (332 769)) (7763 . (333 769)) (7764 . (80 769)) (7765 . (112 769))
 (7766 . (80 775)) (7767 . (112 775)) (7768 . (82 775)) (7769 . (114 775)) (7770 . (82 803))
 (7771 . (114 803)) (7772 . (7770 772)) (7773 . (7771 772)) (7774 . (82 817)) (7775 . (114 817))
 (7776 . (83 775)) (7777 . (115 775)) (7778 . (83 803)) (7779 . (115 803)) (7780 . (346 775))
 (7781 . (347 775)) (7782 . (352 775)) (7783 . (353 775)) (7784 . (7778 775)) (7785 . (7779 775))
 (7786 . (84 775)) (7787 . (116 775)) (7788 . (84 803)) (7789 . (116 803)) (7790 . (84 817))
 (7791 . (116 817)) (7792 . (84 813)) (7793 . (116 813)) (7794 . (85 804)) (7795 . (117 804))
 (7796 . (85 816)) (7797 . (117 816)) (7798 . (85 813)) (7799 . (117 813)) (7800 . (360 769))
 (7801 . (361 769)) (7802 . (362 776)) (7803 . (363 776)) (7804 . (86 771)) (7805 . (118 771))
 (7806 . (86 803)) (7807 . (118 803)) (7808 . (87 768)) (7809 . (119 768)) (7810 . (87 769))
 (7811 . (119 769)) (7812 . (87 776)) (7813 . (119 776)) (7814 . (87 775)) (7815 . (119 775))
 (7816 . (87 803)) (7817 . (119 803)) (7818 . (88 775)) (7819 . (120 775)) (7820 . (88 776))
 (7821 . (120 776)) (7822 . (89 775)) (7823 . (121 775)) (7824 . (90 770)) (7825 . (122 770))
 (7826 . (90 803)) (7827 . (122 803)) (7828 . (90 817)) (7829 . (122 817)) (7830 . (104 817))
 (7831 . (116 776)) (7832 . (119 778)) (7833 . (121 778)) (7835 . (383 775)) (7840 . (65 803))
 (7841 . (97 803)) (7842 . (65 777)) (7843 . (97 777)) (7844 . (194 769)) (7845 . (226 769))
 (7846 . (194 768)) (7847 . (226 768)) (7848 . (194 777)) (7849 . (226 777)) (7850 . (194 771))
 (7851 . (226 771)) (7852 . (7840 770)) (7853 . (7841 770)) (7854 . (258 769)) (7855 . (259 769))
 (7856 . (258 768)) (7857 . (259 768)) (7858 . (258 777)) (7859 . (259 777)) (7860 . (258 771))
 (7861 . (259 771)) (7862 . (7840 774)) (7863 . (7841 774)) (7864 . (69 803)) (7865 . (101 803))
 (7866 . (69 777)) (7867 . (101 777)) (7868 . (69 771)) (7869 . (101 771)) (7870 . (202 769))
 (7871 . (234 769)) (7872 . (202 768)) (7873 . (234 768)) (7874 . (202 777)) (7875 . (234 777))
 (7876 . (202 771)) (7877 . (234 771)) (7878 . (7864 770)) (7879 . (7865 770)) (7880 . (73 777))
 (7881 . (105 777)) (7882 . (73 803)) (7883 . (105 803)) (7884 . (79 803)) (7885 . (111 803))
 (7886 . (79 777)) (7887 . (111 777)) (7888 . (212 769)) (7889 . (244 769)) (7890 . (212 768))
 (7891 . (244 768)) (7892 . (212 777)) (7893 . (244 777)) (7894 . (212 771)) (7895 . (244 771))
 (7896 . (7884 770)) (7897 . (7885 770)) (7898 . (416 769)) (7899 . (417 769)) (7900 . (416 768))
 (7901 . (417 768)) (7902 . (416 777)) (7903 . (417 777)) (7904 . (416 771)) (7905 . (417 771))
 (7906 . (416 803)) (7907 . (417 803)) (7908 . (85 803)) (7909 . (117 803)) (7910 . (85 777))
 (7911 . (117 777)) (7912 . (431 769)) (7913 . (432 769)) (7914 . (431 768)) (7915 . (432 768))
 (7916 . (431 777)) (7917 . (432 777)) (7918 . (431 771)) (7919 . (432 771)) (7920 . (431 803))
 (7921 . (432 803)) (7922 . (89 768)) (7923 . (121 768)) (7924 . (89 803)) (7925 . (121 803))
 (7926 . (89 777)) (7927 . (121 777)) (7928 . (89 771)) (7929 . (121 771)) (7936 . (945 787))
 (7937 . (945 788)) (7938 . (7936 768)) (7939 . (7937 768)) (7940 . (7936 769)) (7941 . (7937 769))
 (7942 . (7936 834)) (7943 . (7937 834)) (7944 . (913 787)) (7945 . (913 788)) (7946 . (7944 768))
 (7947 . (7945 768)) (7948 . (7944 769)) (7949 . (7945 769)) (7950 . (7944 834)) (7951 . (7945 834))
 (7952 . (949 787)) (7953 . (949 788)) (7954 . (7952 768)) (7955 . (7953 768)) (7956 . (7952 769))
 (7957 . (7953 769)) (7960 . (917 787)) (7961 . (917 788)) (7962 . (7960 768)) (7963 . (7961 768))
 (7964 . (7960 769)) (7965 . (7961 769)) (7968 . (951 787)) (7969 . (951 788)) (7970 . (7968 768))
 (7971 . (7969 768)) (7972 . (7968 769)) (7973 . (7969 769)) (7974 . (7968 834)) (7975 . (7969 834))
 (7976 . (919 787)) (7977 . (919 788)) (7978 . (7976 768)) (7979 . (7977 768)) (7980 . (7976 769))
 (7981 . (7977 769)) (7982 . (7976 834)) (7983 . (7977 834)) (7984 . (953 787)) (7985 . (953 788))
 (7986 . (7984 768)) (7987 . (7985 768)) (7988 . (7984 769)) (7989 . (7985 769)) (7990 . (7984 834))
 (7991 . (7985 834)) (7992 . (921 787)) (7993 . (921 788)) (7994 . (7992 768)) (7995 . (7993 768))
 (7996 . (7992 769)) (7997 . (7993 769)) (7998 . (7992 834)) (7999 . (7993 834)) (8000 . (959 787))
 (8001 . (959 788)) (8002 . (8000 768)) (8003 . (8001 768)) (8004 . (8000 769)) (8005 . (8001 769))
 (8008 . (927 787)) (8009 . (927 788)) (8010 . (8008 768)) (8011 . (8009 768)) (8012 . (8008 769))
 (8013 . (8009 769)) (8016 . (965 787)) (8017 . (965 788)) (8018 . (8016 768)) (8019 . (8017 768))
 (8020 . (8016 769)) (8021 . (8017 769)) (8022 . (8016 834)) (8023 . (8017 834)) (8025 . (933 788))
 (8027 . (8025 768)) (8029 . (8025 769)) (8031 . (8025 834)) (8032 . (969 787)) (8033 . (969 788))
 (8034 . (8032 768)) (8035 . (8033 768)) (8036 . (8032 769)) (8037 . (8033 769)) (8038 . (8032 834))
 (8039 . (8033 834)) (8040 . (937 787)) (8041 . (937 788)) (8042 . (8040 768)) (8043 . (8041 768))
 (8044 . (8040 769)) (8045 . (8041 769)) (8046 . (8040 834)) (8047 . (8041 834)) (8048 . (945 768))
 (8049 . (940)) (8050 . (949 768)) (8051 . (941)) (8052 . (951 768)) (8053 . (942))
 (8054 . (953 768)) (8055 . (943)) (8056 . (959 768)) (8057 . (972)) (8058 . (965 768))
 (8059 . (973)) (8060 . (969 768)) (8061 . (974)) (8064 . (7936 837)) (8065 . (7937 837))
 (8066 . (7938 837)) (8067 . (7939 837)) (8068 . (7940 837)) (8069 . (7941 837)) (8070 . (7942 837))
 (8071 . (7943 837)) (8072 . (7944 837)) (8073 . (7945 837)) (8074 . (7946 837)) (8075 . (7947 837))
 (8076 . (7948 837)) (8077 . (7949 837)) (8078 . (7950 837)) (8079 . (7951 837)) (8080 . (7968 837))
 (8081 . (7969 837)) (8082 . (7970 837)) (8083 . (7971 837)) (8084 . (7972 837)) (8085 . (7973 837))
 (8086 . (7974 837)) (8087 . (7975 837)) (8088 . (7976 837)) (8089 . (7977 837)) (8090 . (7978 837))
 (8091 . (7979 837)) (8092 . (7980 837)) (8093 . (7981 837)) (8094 . (7982 837)) (8095 . (7983 837))
 (8096 . (8032 837)) (8097 . (8033 837)) (8098 . (8034 837)) (8099 . (8035 837)) (8100 . (8036 837))
 (8101 . (8037 837)) (8102 . (8038 837)) (8103 . (8039 837)) (8104 . (8040 837)) (8105 . (8041 837))
 (8106 . (8042 837)) (8107 . (8043 837)) (8108 . (8044 837)) (8109 . (8045 837)) (8110 . (8046 837))
 (8111 . (8047 837)) (8112 . (945 774)) (8113 . (945 772)) (8114 . (8048 837)) (8115 . (945 837))
 (8116 . (940 837)) (8118 . (945 834)) (8119 . (8118 837)) (8120 . (913 774)) (8121 . (913 772))
 (8122 . (913 768)) (8123 . (902)) (8124 . (913 837)) (8126 . (953)) (8129 . (168 834))
 (8130 . (8052 837)) (8131 . (951 837)) (8132 . (942 837)) (8134 . (951 834)) (8135 . (8134 837))
 (8136 . (917 768)) (8137 . (904)) (8138 . (919 768)) (8139 . (905)) (8140 . (919 837))
 (8141 . (8127 768)) (8142 . (8127 769)) (8143 . (8127 834)) (8144 . (953 774)) (8145 . (953 772))
 (8146 . (970 768)) (8147 . (912)) (8150 . (953 834)) (8151 . (970 834)) (8152 . (921 774))
 (8153 . (921 772)) (8154 . (921 768)) (8155 . (906)) (8157 . (8190 768)) (8158 . (8190 769))
 (8159 . (8190 834)) (8160 . (965 774)) (8161 . (965 772)) (8162 . (971 768)) (8163 . (944))
 (8164 . (961 787)) (8165 . (961 788)) (8166 . (965 834)) (8167 . (971 834)) (8168 . (933 774))
 (8169 . (933 772)) (8170 . (933 768)) (8171 . (910)) (8172 . (929 788)) (8173 . (168 768))
 (8174 . (901)) (8175 . (96)) (8178 . (8060 837)) (8179 . (969 837)) (8180 . (974 837))
 (8182 . (969 834)) (8183 . (8182 837)) (8184 . (927 768)) (8185 . (908)) (8186 . (937 768))
 (8187 . (911)) (8188 . (937 837)) (8189 . (180)) (8192 . (8194)) (8193 . (8195))
 (8486 . (937)) (8490 . (75)) (8491 . (197)) (8602 . (8592 824)) (8603 . (8594 824))
 (8622 . (8596 824)) (8653 . (8656 824)) (8654 . (8660 824)) (8655 . (8658 824)) (8708 . (8707 824))
 (8713 . (8712 824)) (8716 . (8715 824)) (8740 . (8739 824)) (8742 . (8741 824)) (8769 . (8764 824))
 (8772 . (8771 824)) (8775 . (8773 824)) (8777 . (8776 824)) (8800 . (61 824)) (8802 . (8801 824))
 (8813 . (8781 824)) (8814 . (60 824)) (8815 . (62 824)) (8816 . (8804 824)) (8817 . (8805 824))
 (8820 . (8818 824)) (8821 . (8819 824)) (8824 . (8822 824)) (8825 . (8823 824)) (8832 . (8826 824))
 (8833 . (8827 824)) (8836 . (8834 824)) (8837 . (8835 824)) (8840 . (8838 824)) (8841 . (8839 824))
 (8876 . (8866 824)) (8877 . (8872 824)) (8878 . (8873 824)) (8879 . (8875 824)) (8928 . (8828 824))
 (8929 . (8829 824)) (8930 . (8849 824)) (8931 . (8850 824)) (8938 . (8882 824)) (8939 . (8883 824))
 (8940 . (8884 824)) (8941 . (8885 824)) (9001 . (12296)) (9002 . (12297)) (10972 . (10973 824))
 (12364 . (12363 12441)) (12366 . (12365 12441)) (12368 . (12367 12441)) (12370 . (12369 12441)) (12372 . (12371 12441))
 (12374 . (12373 12441)) (12376 . (12375 12441)) (12378 . (12377 12441)) (12380 . (12379 12441)) (12382 . (12381 12441))
 (12384 . (12383 12441)) (12386 . (12385 12441)) (12389 . (12388 12441)) (12391 . (12390 12441)) (12393 . (12392 12441))
 (12400 . (12399 12441)) (12401 . (12399 12442)) (12403 . (12402 12441)) (12404 . (12402 12442)) (12406 . (12405 12441))
 (12407 . (12405 12442)) (12409 . (12408 12441)) (12410 . (12408 12442)) (12412 . (12411 12441)) (12413 . (12411 12442))
 (12436 . (12358 12441)) (12446 . (12445 12441)) (12460 . (12459 12441)) (12462 . (12461 12441)) (12464 . (12463 12441))
 (12466 . (12465 12441)) (12468 . (12467 12441)) (12470 . (12469 12441)) (12472 . (12471 12441)) (12474 . (12473 12441))
 (12476 . (12475 12441)) (12478 . (12477 12441)) (12480 . (12479 12441)) (12482 . (12481 12441)) (12485 . (12484 12441))
 (12487 . (12486 12441)) (12489 . (12488 12441)) (12496 . (12495 12441)) (12497 . (12495 12442)) (12499 . (12498 12441))
 (12500 . (12498 12442)) (12502 . (12501 12441)) (12503 . (12501 12442)) (12505 . (12504 12441)) (12506 . (12504 12442))
 (12508 . (12507 12441)) (12509 . (12507 12442)) (12532 . (12454 12441)) (12535 . (12527 12441)) (12536 . (12528 12441))
 (12537 . (12529 12441)) (12538 . (12530 12441)) (12542 . (12541 12441)) (63744 . (35912)) (63745 . (26356))
 (63746 . (36554)) (63747 . (36040)) (63748 . (28369)) (63749 . (20018)) (63750 . (21477))
 (63751 . (40860)) (63752 . (40860)) (63753 . (22865)) (63754 . (37329)) (63755 . (21895))
 (63756 . (22856)) (63757 . (25078)) (63758 . (30313)) (63759 . (32645)) (63760 . (34367))
 (63761 . (34746)) (63762 . (35064)) (63763 . (37007)) (63764 . (27138)) (63765 . (27931))
 (63766 . (28889)) (63767 . (29662)) (63768 . (33853)) (63769 . (37226)) (63770 . (39409))
 (63771 . (20098)) (63772 . (21365)) (63773 . (27396)) (63774 . (29211)) (63775 . (34349))
 (63776 . (40478)) (63777 . (23888)) (63778 . (28651)) (63779 . (34253)) (63780 . (35172))
 (63781 . (25289)) (63782 . (33240)) (63783 . (34847)) (63784 . (24266)) (63785 . (26391))
 (63786 . (28010)) (63787 . (29436)) (63788 . (37070)) (63789 . (20358)) (63790 . (20919))
 (63791 . (21214)) (63792 . (25796)) (63793 . (27347)) (63794 . (29200)) (63795 . (30439))
 (63796 . (32769)) (63797 . (34310)) (63798 . (34396)) (63799 . (36335)) (63800 . (38706))
 (63801 . (39791)) (63802 . (40442)) (63803 . (30860)) (63804 . (31103)) (63805 . (32160))
 (63806 . (33737)) (63807 . (37636)) (63808 . (40575)) (63809 . (35542)) (63810 . (22751))
 (63811 . (24324)) (63812 . (31840)) (63813 . (32894)) (63814 . (29282)) (63815 . (30922))
 (63816 . (36034)) (63817 . (38647)) (63818 . (22744)) (63819 . (23650)) (63820 . (27155))
 (63821 . (28122)) (63822 . (28431)) (63823 . (32047)) (63824 . (32311)) (63825 . (38475))
 (63826 . (21202)) (63827 . (32907)) (63828 . (20956)) (63829 . (20940)) (63830 . (31260))
 (63831 . (32190)) (63832 . (33777)) (63833 . (38517)) (63834 . (35712)) (63835 . (25295))
 (63836 . (27138)) (63837 . (35582)) (63838 . (20025)) (63839 . (23527)) (63840 . (24594))
 (63841 . (29575)) (63842 . (30064)) (63843 . (21271)) (63844 . (30971)) (63845 . (20415))
 (63846 . (24489)) (63847 . (19981)) (63848 . (27852)) (63849 . (25976)) (63850 . (32034))
 (63851 . (21443)) (63852 . (22622)) (63853 . (30465)) (63854 . (33865)) (63855 . (35498))
 (63856 . (27578)) (63857 . (36784)) (63858 . (27784)) (63859 . (25342)) (63860 . (33509))
 (63861 . (25504)) (63862 . (30053)) (63863 . (20142)) (63864 . (20841)) (63865 . (20937))
 (63866 . (26753)) (63867 . (31975)) (63868 . (33391)) (63869 . (35538)) (63870 . (37327))
 (63871 . (21237)) (63872 . (21570)) (63873 . (22899)) (63874 . (24300)) (63875 . (26053))
 (63876 . (28670)) (63877 . (31018)) (63878 . (38317)) (63879 . (39530)) (63880 . (40599))
 (63881 . (40654)) (63882 . (21147)) (63883 . (26310)) (63884 . (27511)) (63885 . (36706))
 (63886 . (24180)) (63887 . (24976)) (63888 . (25088)) (63889 . (25754)) (63890 . (28451))
 (63891 . (29001)) (63892 . (29833)) (63893 . (31178)) (63894 . (32244)) (63895 . (32879))
 (63896 . (36646)) (63897 . (34030)) (63898 . (36899)) (63899 . (37706)) (63900 . (21015))
 (63901 . (21155)) (63902 . (21693)) (63903 . (28872)) (63904 . (35010)) (63905 . (35498))
 (63906 . (24265)) (63907 . (24565)) (63908 . (25467)) (63909 . (27566)) (63910 . (31806))
 (63911 . (29557)) (63912 . (20196)) (63913 . (22265)) (63914 . (23527)) (63915 . (23994))
 (63916 . (24604)) (63917 . (29618)) (63918 . (29801)) (63919 . (32666)) (63920 . (32838))
 (63921 . (37428)) (63922 . (38646)) (63923 . (38728)) (63924 . (38936)) (63925 . (20363))
 (63926 . (31150)) (63927 . (37300)) (63928 . (38584)) (63929 . (24801)) (63930 . (20102))
 (63931 . (20698)) (63932 . (23534)) (63933 . (23615)) (63934 . (26009)) (63935 . (27138))
 (63936 . (29134)) (63937 . (30274)) (63938 . (34044)) (63939 . (36988)) (63940 . (40845))
 (63941 . (26248)) (63942 . (38446)) (63943 . (21129)) (63944 . (26491)) (63945 . (26611))
 (63946 . (27969)) (63947 . (28316)) (63948 . (29705)) (63949 . (30041)) (63950 . (30827))
 (63951 . (32016)) (63952 . (39006)) (63953 . (20845)) (63954 . (25134)) (63955 . (38520))
 (63956 . (20523)) (63957 . (23833)) (63958 . (28138)) (63959 . (36650)) (63960 . (24459))
 (63961 . (24900)) (63962 . (26647)) (63963 . (29575)) (63964 . (38534)) (63965 . (21033))
 (63966 . (21519)) (63967 . (23653)) (63968 . (26131)) (63969 . (26446)) (63970 . (26792))
 (63971 . (27877)) (63972 . (29702)) (63973 . (30178)) (63974 . (32633)) (63975 . (35023))
 (63976 . (35041)) (63977 . (37324)) (63978 . (38626)) (63979 . (21311)) (63980 . (28346))
 (63981 . (21533)) (63982 . (29136)) (63983 . (29848)) (63984 . (34298)) (63985 . (38563))
 (63986 . (40023)) (63987 . (40607)) (63988 . (26519)) (63989 . (28107)) (63990 . (33256))
 (63991 . (31435)) (63992 . (31520)) (63993 . (31890)) (63994 . (29376)) (63995 . (28825))
 (63996 . (35672)) (63997 . (20160)) (63998 . (33590)) (63999 . (21050)) (64000 . (20999))
 (64001 . (24230)) (64002 . (25299)) (64003 . (31958)) (64004 . (23429)) (64005 . (27934))
 (64006 . (26292)) (64007 . (36667)) (64008 . (34892)) (64009 . (38477)) (64010 . (35211))
 (64011 . (24275)) (64012 . (20800)) (64013 . (21952)) (64016 . (22618)) (64018 . (26228))
 (64021 . (20958)) (64022 . (29482)) (64023 . (30410)) (64024 . (31036)) (64025 . (31070))
 (64026 . (31077)) (64027 . (31119)) (64028 . (38742)) (64029 . (31934)) (64030 . (32701))
 (64032 . (34322)) (64034 . (35576)) (64037 . (36920)) (64038 . (37117)) (64042 . (39151))
 (64043 . (39164)) (64044 . (39208)) (64045 . (40372)) (64048 . (20398)) (64049 . (20711))
 (64050 . (20813)) (64051 . (21193)) (64052 . (21220)) (64053 . (21329)) (64054 . (21917))
 (64055 . (22022)) (64056 . (22120)) (64057 . (22592)) (64058 . (22696)) (64059 . (23652))
 (64060 . (23662)) (64061 . (24724)) (64062 . (24936)) (64063 . (24974)) (64064 . (25074))
 (64065 . (25935)) (64066 . (26082)) (64067 . (26257)) (64068 . (26757)) (64069 . (28023))
 (64070 . (28186)) (64071 . (28450)) (64072 . (29038)) (64073 . (29227)) (64074 . (29730))
 (64075 . (30865)) (64076 . (31038)) (64077 . (31049)) (64078 . (31048)) (64079 . (31056))
 (64080 . (31062)) (64081 . (31069)) (64082 . (31117)) (64083 . (31118)) (64084 . (31296))
 (64085 . (31361)) (64086 . (31680)) (64087 . (32244)) (64088 . (32265)) (64089 . (32321))
 (64090 . (32626)) (64091 . (32773)) (64092 . (33261)) (64093 . (33401)) (64094 . (33401))
 (64095 . (33879)) (64096 . (35088)) (64097 . (35222)) (64098 . (35585)) (64099 . (35641))
 (64100 . (36051)) (64101 . (36104)) (64102 . (36790)) (64103 . (36920)) (64104 . (38627))
 (64105 . (38911)) (64106 . (38971)) (64112 . (20006)) (64113 . (20917)) (64114 . (20840))
 (64115 . (20352)) (64116 . (20805)) (64117 . (20864)) (64118 . (21191)) (64119 . (21242))
 (64120 . (21917)) (64121 . (21845)) (64122 . (21913)) (64123 . (21986)) (64124 . (22618))
 (64125 . (22707)) (64126 . (22852)) (64127 . (22868)) (64128 . (23138)) (64129 . (23336))
 (64130 . (24274)) (64131 . (24281)) (64132 . (24425)) (64133 . (24493)) (64134 . (24792))
 (64135 . (24910)) (64136 . (24840)) (64137 . (24974)) (64138 . (24928)) (64139 . (25074))
 (64140 . (25140)) (64141 . (25540)) (64142 . (25628)) (64143 . (25682)) (64144 . (25942))
 (64145 . (26228)) (64146 . (26391)) (64147 . (26395)) (64148 . (26454)) (64149 . (27513))
 (64150 . (27578)) (64151 . (27969)) (64152 . (28379)) (64153 . (28363)) (64154 . (28450))
 (64155 . (28702)) (64156 . (29038)) (64157 . (30631)) (64158 . (29237)) (64159 . (29359))
 (64160 . (29482)) (64161 . (29809)) (64162 . (29958)) (64163 . (30011)) (64164 . (30237))
 (64165 . (30239)) (64166 . (30410)) (64167 . (30427)) (64168 . (30452)) (64169 . (30538))
 (64170 . (30528)) (64171 . (30924)) (64172 . (31409)) (64173 . (31680)) (64174 . (31867))
 (64175 . (32091)) (64176 . (32244)) (64177 . (32574)) (64178 . (32773)) (64179 . (33618))
 (64180 . (33775)) (64181 . (34681)) (64182 . (35137)) (64183 . (35206)) (64184 . (35222))
 (64185 . (35519)) (64186 . (35576)) (64187 . (35531)) (64188 . (35585)) (64189 . (35582))
 (64190 . (35565)) (64191 . (35641)) (64192 . (35722)) (64193 . (36104)) (64194 . (36664))
 (64195 . (36978)) (64196 . (37273)) (64197 . (37494)) (64198 . (38524)) (64199 . (38627))
 (64200 . (38742)) (64201 . (38875)) (64202 . (38911)) (64203 . (38923)) (64204 . (38971))
 (64205 . (39698)) (64206 . (40860)) (64207 . (141386)) (64208 . (141380)) (64209 . (144341))
 (64210 . (15261)) (64211 . (16408)) (64212 . (16441)) (64213 . (152137)) (64214 . (154832))
 (64215 . (163539)) (64216 . (40771)) (64217 . (40846)) (64285 . (1497 1460)) (64287 . (1522 1463))
 (64298 . (1513 1473)) (64299 . (1513 1474)) (64300 . (64329 1473)) (64301 . (64329 1474)) (64302 . (1488 1463))
 (64303 . (1488 1464)) (64304 . (1488 1468)) (64305 . (1489 1468)) (64306 . (1490 1468)) (64307 . (1491 1468))
 (64308 . (1492 1468)) (64309 . (1493 1468)) (64310 . (1494 1468)) (64312 . (1496 1468)) (64313 . (1497 1468))
 (64314 . (1498 1468)) (64315 . (1499 1468)) (64316 . (1500 1468)) (64318 . (1502 1468)) (64320 . (1504 1468))
 (64321 . (1505 1468)) (64323 . (1507 1468)) (64324 . (1508 1468)) (64326 . (1510 1468)) (64327 . (1511 1468))
 (64328 . (1512 1468)) (64329 . (1513 1468)) (64330 . (1514 1468)) (64331 . (1493 1465)) (64332 . (1489 1471))
 (64333 . (1499 1471)) (64334 . (1508 1471)) (119134 . (119127 119141)) (119135 . (119128 119141)) (119136 . (119135 119150))
 (119137 . (119135 119151)) (119138 . (119135 119152)) (119139 . (119135 119153)) (119140 . (119135 119154)) (119227 . (119225 119141))
 (119228 . (119226 119141)) (119229 . (119227 119150)) (119230 . (119228 119150)) (119231 . (119227 119151)) (119232 . (119228 119151))
 (194560 . (20029)) (194561 . (20024)) (194562 . (20033)) (194563 . (131362)) (194564 . (20320))
 (194565 . (20398)) (194566 . (20411)) (194567 . (20482)) (194568 . (20602)) (194569 . (20633))
 (194570 . (20711)) (194571 . (20687)) (194572 . (13470)) (194573 . (132666)) (194574 . (20813))
 (194575 . (20820)) (194576 . (20836)) (194577 . (20855)) (194578 . (132380)) (194579 . (13497))
 (194580 . (20839)) (194581 . (20877)) (194582 . (132427)) (194583 . (20887)) (194584 . (20900))
 (194585 . (20172)) (194586 . (20908)) (194587 . (20917)) (194588 . (168415)) (194589 . (20981))
 (194590 . (20995)) (194591 . (13535)) (194592 . (21051)) (194593 . (21062)) (194594 . (21106))
 (194595 . (21111)) (194596 . (13589)) (194597 . (21191)) (194598 . (21193)) (194599 . (21220))
 (194600 . (21242)) (194601 . (21253)) (194602 . (21254)) (194603 . (21271)) (194604 . (21321))
 (194605 . (21329)) (194606 . (21338)) (194607 . (21363)) (194608 . (21373)) (194609 . (21375))
 (194610 . (21375)) (194611 . (21375)) (194612 . (133676)) (194613 . (28784)) (194614 . (21450))
 (194615 . (21471)) (194616 . (133987)) (194617 . (21483)) (194618 . (21489)) (194619 . (21510))
 (194620 . (21662)) (194621 . (21560)) (194622 . (21576)) (194623 . (21608)) (194624 . (21666))
 (194625 . (21750)) (194626 . (21776)) (194627 . (21843)) (194628 . (21859)) (194629 . (21892))
 (194630 . (21892)) (194631 . (21913)) (194632 . (21931)) (194633 . (21939)) (194634 . (21954))
 (194635 . (22294)) (194636 . (22022)) (194637 . (22295)) (194638 . (22097)) (194639 . (22132))
 (194640 . (20999)) (194641 . (22766)) (194642 . (22478)) (194643 . (22516)) (194644 . (22541))
 (194645 . (22411)) (194646 . (22578)) (194647 . (22577)) (194648 . (22700)) (194649 . (136420))
 (194650 . (22770)) (194651 . (22775)) (194652 . (22790)) (194653 . (22810)) (194654 . (22818))
 (194655 . (22882)) (194656 . (136872)) (194657 . (136938)) (194658 . (23020)) (194659 . (23067))
 (194660 . (23079)) (194661 . (23000)) (194662 . (23142)) (194663 . (14062)) (194664 . (14076))
 (194665 . (23304)) (194666 . (23358)) (194667 . (23358)) (194668 . (137672)) (194669 . (23491))
 (194670 . (23512)) (194671 . (23527)) (194672 . (23539)) (194673 . (138008)) (194674 . (23551))
 (194675 . (23558)) (194676 . (24403)) (194677 . (23586)) (194678 . (14209)) (194679 . (23648))
 (194680 . (23662)) (194681 . (23744)) (194682 . (23693)) (194683 . (138724)) (194684 . (23875))
 (194685 . (138726)) (194686 . (23918)) (194687 . (23915)) (194688 . (23932)) (194689 . (24033))
 (194690 . (24034)) (194691 . (14383)) (194692 . (24061)) (194693 . (24104)) (194694 . (24125))
 (194695 . (24169)) (194696 . (14434)) (194697 . (139651)) (194698 . (14460)) (194699 . (24240))
 (194700 . (24243)) (194701 . (24246)) (194702 . (24266)) (194703 . (172946)) (194704 . (24318))
 (194705 . (140081)) (194706 . (140081)) (194707 . (33281)) (194708 . (24354)) (194709 . (24354))
 (194710 . (14535)) (194711 . (144056)) (194712 . (156122)) (194713 . (24418)) (194714 . (24427))
 (194715 . (14563)) (194716 . (24474)) (194717 . (24525)) (194718 . (24535)) (194719 . (24569))
 (194720 . (24705)) (194721 . (14650)) (194722 . (14620)) (194723 . (24724)) (194724 . (141012))
 (194725 . (24775)) (194726 . (24904)) (194727 . (24908)) (194728 . (24910)) (194729 . (24908))
 (194730 . (24954)) (194731 . (24974)) (194732 . (25010)) (194733 . (24996)) (194734 . (25007))
 (194735 . (25054)) (194736 . (25074)) (194737 . (25078)) (194738 . (25104)) (194739 . (25115))
 (194740 . (25181)) (194741 . (25265)) (194742 . (25300)) (194743 . (25424)) (194744 . (142092))
 (194745 . (25405)) (194746 . (25340)) (194747 . (25448)) (194748 . (25475)) (194749 . (25572))
 (194750 . (142321)) (194751 . (25634)) (194752 . (25541)) (194753 . (25513)) (194754 . (14894))
 (194755 . (25705)) (194756 . (25726)) (194757 . (25757)) (194758 . (25719)) (194759 . (14956))
 (194760 . (25935)) (194761 . (25964)) (194762 . (143370)) (194763 . (26083)) (194764 . (26360))
 (194765 . (26185)) (194766 . (15129)) (194767 . (26257)) (194768 . (15112)) (194769 . (15076))
 (194770 . (20882)) (194771 . (20885)) (194772 . (26368)) (194773 . (26268)) (194774 . (32941))
 (194775 . (17369)) (194776 . (26391)) (194777 . (26395)) (194778 . (26401)) (194779 . (26462))
 (194780 . (26451)) (194781 . (144323)) (194782 . (15177)) (194783 . (26618)) (194784 . (26501))
 (194785 . (26706)) (194786 . (26757)) (194787 . (144493)) (194788 . (26766)) (194789 . (26655))
 (194790 . (26900)) (194791 . (15261)) (194792 . (26946)) (194793 . (27043)) (194794 . (27114))
 (194795 . (27304)) (194796 . (145059)) (194797 . (27355)) (194798 . (15384)) (194799 . (27425))
 (194800 . (145575)) (194801 . (27476)) (194802 . (15438)) (194803 . (27506)) (194804 . (27551))
 (194805 . (27578)) (194806 . (27579)) (194807 . (146061)) (194808 . (138507)) (194809 . (146170))
 (194810 . (27726)) (194811 . (146620)) (194812 . (27839)) (194813 . (27853)) (194814 . (27751))
 (194815 . (27926)) (194816 . (27966)) (194817 . (28023)) (194818 . (27969)) (194819 . (28009))
 (194820 . (28024)) (194821 . (28037)) (194822 . (146718)) (194823 . (27956)) (194824 . (28207))
 (194825 . (28270)) (194826 . (15667)) (194827 . (28363)) (194828 . (28359)) (194829 . (147153))
 (194830 . (28153)) (194831 . (28526)) (194832 . (147294)) (194833 . (147342)) (194834 . (28614))
 (194835 . (28729)) (194836 . (28702)) (194837 . (28699)) (194838 . (15766)) (194839 . (28746))
 (194840 . (28797)) (194841 . (28791)) (194842 . (28845)) (194843 . (132389)) (194844 . (28997))
 (194845 . (148067)) (194846 . (29084)) (194847 . (148395)) (194848 . (29224)) (194849 . (29237))
 (194850 . (29264)) (194851 . (149000)) (194852 . (29312)) (194853 . (29333)) (194854 . (149301))
 (194855 . (149524)) (194856 . (29562)) (194857 . (29579)) (194858 . (16044)) (194859 . (29605))
 (194860 . (16056)) (194861 . (16056)) (194862 . (29767)) (194863 . (29788)) (194864 . (29809))
 (194865 . (29829)) (194866 . (29898)) (194867 . (16155)) (194868 . (29988)) (194869 . (150582))
 (194870 . (30014)) (194871 . (150674)) (194872 . (30064)) (194873 . (139679)) (194874 . (30224))
 (194875 . (151457)) (194876 . (151480)) (194877 . (151620)) (194878 . (16380)) (194879 . (16392))
 (194880 . (30452)) (194881 . (151795)) (194882 . (151794)) (194883 . (151833)) (194884 . (151859))
 (194885 . (30494)) (194886 . (30495)) (194887 . (30495)) (194888 . (30538)) (194889 . (16441))
 (194890 . (30603)) (194891 . (16454)) (194892 . (16534)) (194893 . (152605)) (194894 . (30798))
 (194895 . (30860)) (194896 . (30924)) (194897 . (16611)) (194898 . (153126)) (194899 . (31062))
 (194900 . (153242)) (194901 . (153285)) (194902 . (31119)) (194903 . (31211)) (194904 . (16687))
 (194905 . (31296)) (194906 . (31306)) (194907 . (31311)) (194908 . (153980)) (194909 . (154279))
 (194910 . (154279)) (194911 . (31470)) (194912 . (16898)) (194913 . (154539)) (194914 . (31686))
 (194915 . (31689)) (194916 . (16935)) (194917 . (154752)) (194918 . (31954)) (194919 . (17056))
 (194920 . (31976)) (194921 . (31971)) (194922 . (32000)) (194923 . (155526)) (194924 . (32099))
 (194925 . (17153)) (194926 . (32199)) (194927 . (32258)) (194928 . (32325)) (194929 . (17204))
 (194930 . (156200)) (194931 . (156231)) (194932 . (17241)) (194933 . (156377)) (194934 . (32634))
 (194935 . (156478)) (194936 . (32661)) (194937 . (32762)) (194938 . (32773)) (194939 . (156890))
 (194940 . (156963)) (194941 . (32864)) (194942 . (157096)) (194943 . (32880)) (194944 . (144223))
 (194945 . (17365)) (194946 . (32946)) (194947 . (33027)) (194948 . (17419)) (194949 . (33086))
 (194950 . (23221)) (194951 . (157607)) (194952 . (157621)) (194953 . (144275)) (194954 . (144284))
 (194955 . (33281)) (194956 . (33284)) (194957 . (36766)) (194958 . (17515)) (194959 . (33425))
 (194960 . (33419)) (194961 . (33437)) (194962 . (21171)) (194963 . (33457)) (194964 . (33459))
 (194965 . (33469)) (194966 . (33510)) (194967 . (158524)) (194968 . (33509)) (194969 . (33565))
 (194970 . (33635)) (194971 . (33709)) (194972 . (33571)) (194973 . (33725)) (194974 . (33767))
 (194975 . (33879)) (194976 . (33619)) (194977 . (33738)) (194978 . (33740)) (194979 . (33756))
 (194980 . (158774)) (194981 . (159083)) (194982 . (158933)) (194983 . (17707)) (194984 . (34033))
 (194985 . (34035)) (194986 . (34070)) (194987 . (160714)) (194988 . (34148)) (194989 . (159532))
 (194990 . (17757)) (194991 . (17761)) (194992 . (159665)) (194993 . (159954)) (194994 . (17771))
 (194995 . (34384)) (194996 . (34396)) (194997 . (34407)) (194998 . (34409)) (194999 . (34473))
 (195000 . (34440)) (195001 . (34574)) (195002 . (34530)) (195003 . (34681)) (195004 . (34600))
 (195005 . (34667)) (195006 . (34694)) (195007 . (17879)) (195008 . (34785)) (195009 . (34817))
 (195010 . (17913)) (195011 . (34912)) (195012 . (34915)) (195013 . (161383)) (195014 . (35031))
 (195015 . (35038)) (195016 . (17973)) (195017 . (35066)) (195018 . (13499)) (195019 . (161966))
 (195020 . (162150)) (195021 . (18110)) (195022 . (18119)) (195023 . (35488)) (195024 . (35565))
 (195025 . (35722)) (195026 . (35925)) (195027 . (162984)) (195028 . (36011)) (195029 . (36033))
 (195030 . (36123)) (195031 . (36215)) (195032 . (163631)) (195033 . (133124)) (195034 . (36299))
 (195035 . (36284)) (195036 . (36336)) (195037 . (133342)) (195038 . (36564)) (195039 . (36664))
 (195040 . (165330)) (195041 . (165357)) (195042 . (37012)) (195043 . (37105)) (195044 . (37137))
 (195045 . (165678)) (195046 . (37147)) (195047 . (37432)) (195048 . (37591)) (195049 . (37592))
 (195050 . (37500)) (195051 . (37881)) (195052 . (37909)) (195053 . (166906)) (195054 . (38283))
 (195055 . (18837)) (195056 . (38327)) (195057 . (167287)) (195058 . (18918)) (195059 . (38595))
 (195060 . (23986)) (195061 . (38691)) (195062 . (168261)) (195063 . (168474)) (195064 . (19054))
 (195065 . (19062)) (195066 . (38880)) (195067 . (168970)) (195068 . (19122)) (195069 . (169110))
 (195070 . (38923)) (195071 . (38923)) (195072 . (38953)) (195073 . (169398)) (195074 . (39138))
 (195075 . (19251)) (195076 . (39209)) (195077 . (39335)) (195078 . (39362)) (195079 . (39422))
 (195080 . (19406)) (195081 . (170800)) (195082 . (39698)) (195083 . (40000)) (195084 . (40189))
 (195085 . (19662)) (195086 . (19693)) (195087 . (40295)) (195088 . (172238)) (195089 . (19704))
 (195090 . (172293)) (195091 . (172558)) (195092 . (172689)) (195093 . (40635)) (195094 . (19798))
 (195095 . (40697)) (195096 . (40702)) (195097 . (40709)) (195098 . (40719)) (195099 . (40726))
 (195100 . (40763)) (195101 . (173568))))



(define foldcase-list '(
                        (65 . (97)) (66 . (98)) (67 . (99)) (68 . (100)) (69 . (101))
                        (70 . (102)) (71 . (103)) (72 . (104)) (73 . (105)) (74 . (106))
                        (75 . (107)) (76 . (108)) (77 . (109)) (78 . (110)) (79 . (111))
                        (80 . (112)) (81 . (113)) (82 . (114)) (83 . (115)) (84 . (116))
                        (85 . (117)) (86 . (118)) (87 . (119)) (88 . (120)) (89 . (121))
                        (90 . (122)) (181 . (956)) (192 . (224)) (193 . (225)) (194 . (226))
                        (195 . (227)) (196 . (228)) (197 . (229)) (198 . (230)) (199 . (231))
                        (200 . (232)) (201 . (233)) (202 . (234)) (203 . (235)) (204 . (236))
                        (205 . (237)) (206 . (238)) (207 . (239)) (208 . (240)) (209 . (241))
                        (210 . (242)) (211 . (243)) (212 . (244)) (213 . (245)) (214 . (246))
                        (216 . (248)) (217 . (249)) (218 . (250)) (219 . (251)) (220 . (252))
                        (221 . (253)) (222 . (254)) (223 . (115 115)) (256 . (257)) (258 . (259))
                        (260 . (261)) (262 . (263)) (264 . (265)) (266 . (267)) (268 . (269))
                        (270 . (271)) (272 . (273)) (274 . (275)) (276 . (277)) (278 . (279))
                        (280 . (281)) (282 . (283)) (284 . (285)) (286 . (287)) (288 . (289))
                        (290 . (291)) (292 . (293)) (294 . (295)) (296 . (297)) (298 . (299))
                        (300 . (301)) (302 . (303)) (304 . (105 775)) (306 . (307)) (308 . (309))
                        (310 . (311)) (313 . (314)) (315 . (316)) (317 . (318)) (319 . (320))
                        (321 . (322)) (323 . (324)) (325 . (326)) (327 . (328)) (329 . (700 110))
                        (330 . (331)) (332 . (333)) (334 . (335)) (336 . (337)) (338 . (339))
                        (340 . (341)) (342 . (343)) (344 . (345)) (346 . (347)) (348 . (349))
                        (350 . (351)) (352 . (353)) (354 . (355)) (356 . (357)) (358 . (359))
                        (360 . (361)) (362 . (363)) (364 . (365)) (366 . (367)) (368 . (369))
                        (370 . (371)) (372 . (373)) (374 . (375)) (376 . (255)) (377 . (378))
                        (379 . (380)) (381 . (382)) (383 . (115)) (385 . (595)) (386 . (387))
                        (388 . (389)) (390 . (596)) (391 . (392)) (393 . (598)) (394 . (599))
                        (395 . (396)) (398 . (477)) (399 . (601)) (400 . (603)) (401 . (402))
                        (403 . (608)) (404 . (611)) (406 . (617)) (407 . (616)) (408 . (409))
                        (412 . (623)) (413 . (626)) (415 . (629)) (416 . (417)) (418 . (419))
                        (420 . (421)) (422 . (640)) (423 . (424)) (425 . (643)) (428 . (429))
                        (430 . (648)) (431 . (432)) (433 . (650)) (434 . (651)) (435 . (436))
                        (437 . (438)) (439 . (658)) (440 . (441)) (444 . (445)) (452 . (454))
                        (453 . (454)) (455 . (457)) (456 . (457)) (458 . (460)) (459 . (460))
                        (461 . (462)) (463 . (464)) (465 . (466)) (467 . (468)) (469 . (470))
                        (471 . (472)) (473 . (474)) (475 . (476)) (478 . (479)) (480 . (481))
                        (482 . (483)) (484 . (485)) (486 . (487)) (488 . (489)) (490 . (491))
                        (492 . (493)) (494 . (495)) (496 . (106 780)) (497 . (499)) (498 . (499))
                        (500 . (501)) (502 . (405)) (503 . (447)) (504 . (505)) (506 . (507))
                        (508 . (509)) (510 . (511)) (512 . (513)) (514 . (515)) (516 . (517))
                        (518 . (519)) (520 . (521)) (522 . (523)) (524 . (525)) (526 . (527))
                        (528 . (529)) (530 . (531)) (532 . (533)) (534 . (535)) (536 . (537))
                        (538 . (539)) (540 . (541)) (542 . (543)) (544 . (414)) (546 . (547))
                        (548 . (549)) (550 . (551)) (552 . (553)) (554 . (555)) (556 . (557))
                        (558 . (559)) (560 . (561)) (562 . (563)) (570 . (11365)) (571 . (572))
                        (573 . (410)) (574 . (11366)) (577 . (578)) (579 . (384)) (580 . (649))
                        (581 . (652)) (582 . (583)) (584 . (585)) (586 . (587)) (588 . (589))
                        (590 . (591)) (837 . (953)) (880 . (881)) (882 . (883)) (886 . (887))
                        (902 . (940)) (904 . (941)) (905 . (942)) (906 . (943)) (908 . (972))
                        (910 . (973)) (911 . (974)) (912 . (953 776 769)) (913 . (945)) (914 . (946))
                        (915 . (947)) (916 . (948)) (917 . (949)) (918 . (950)) (919 . (951))
                        (920 . (952)) (921 . (953)) (922 . (954)) (923 . (955)) (924 . (956))
                        (925 . (957)) (926 . (958)) (927 . (959)) (928 . (960)) (929 . (961))
                        (931 . (963)) (932 . (964)) (933 . (965)) (934 . (966)) (935 . (967))
                        (936 . (968)) (937 . (969)) (938 . (970)) (939 . (971)) (944 . (965 776 769))
                        (962 . (963)) (975 . (983)) (976 . (946)) (977 . (952)) (981 . (966))
                        (982 . (960)) (984 . (985)) (986 . (987)) (988 . (989)) (990 . (991))
                        (992 . (993)) (994 . (995)) (996 . (997)) (998 . (999)) (1000 . (1001))
                        (1002 . (1003)) (1004 . (1005)) (1006 . (1007)) (1008 . (954)) (1009 . (961))
                        (1012 . (952)) (1013 . (949)) (1015 . (1016)) (1017 . (1010)) (1018 . (1019))
                        (1021 . (891)) (1022 . (892)) (1023 . (893)) (1024 . (1104)) (1025 . (1105))
                        (1026 . (1106)) (1027 . (1107)) (1028 . (1108)) (1029 . (1109)) (1030 . (1110))
                        (1031 . (1111)) (1032 . (1112)) (1033 . (1113)) (1034 . (1114)) (1035 . (1115))
                        (1036 . (1116)) (1037 . (1117)) (1038 . (1118)) (1039 . (1119)) (1040 . (1072))
                        (1041 . (1073)) (1042 . (1074)) (1043 . (1075)) (1044 . (1076)) (1045 . (1077))
                        (1046 . (1078)) (1047 . (1079)) (1048 . (1080)) (1049 . (1081)) (1050 . (1082))
                        (1051 . (1083)) (1052 . (1084)) (1053 . (1085)) (1054 . (1086)) (1055 . (1087))
                        (1056 . (1088)) (1057 . (1089)) (1058 . (1090)) (1059 . (1091)) (1060 . (1092))
                        (1061 . (1093)) (1062 . (1094)) (1063 . (1095)) (1064 . (1096)) (1065 . (1097))
                        (1066 . (1098)) (1067 . (1099)) (1068 . (1100)) (1069 . (1101)) (1070 . (1102))
                        (1071 . (1103)) (1120 . (1121)) (1122 . (1123)) (1124 . (1125)) (1126 . (1127))
                        (1128 . (1129)) (1130 . (1131)) (1132 . (1133)) (1134 . (1135)) (1136 . (1137))
                        (1138 . (1139)) (1140 . (1141)) (1142 . (1143)) (1144 . (1145)) (1146 . (1147))
                        (1148 . (1149)) (1150 . (1151)) (1152 . (1153)) (1162 . (1163)) (1164 . (1165))
                        (1166 . (1167)) (1168 . (1169)) (1170 . (1171)) (1172 . (1173)) (1174 . (1175))
                        (1176 . (1177)) (1178 . (1179)) (1180 . (1181)) (1182 . (1183)) (1184 . (1185))
                        (1186 . (1187)) (1188 . (1189)) (1190 . (1191)) (1192 . (1193)) (1194 . (1195))
                        (1196 . (1197)) (1198 . (1199)) (1200 . (1201)) (1202 . (1203)) (1204 . (1205))
                        (1206 . (1207)) (1208 . (1209)) (1210 . (1211)) (1212 . (1213)) (1214 . (1215))
                        (1216 . (1231)) (1217 . (1218)) (1219 . (1220)) (1221 . (1222)) (1223 . (1224))
                        (1225 . (1226)) (1227 . (1228)) (1229 . (1230)) (1232 . (1233)) (1234 . (1235))
                        (1236 . (1237)) (1238 . (1239)) (1240 . (1241)) (1242 . (1243)) (1244 . (1245))
                        (1246 . (1247)) (1248 . (1249)) (1250 . (1251)) (1252 . (1253)) (1254 . (1255))
                        (1256 . (1257)) (1258 . (1259)) (1260 . (1261)) (1262 . (1263)) (1264 . (1265))
                        (1266 . (1267)) (1268 . (1269)) (1270 . (1271)) (1272 . (1273)) (1274 . (1275))
                        (1276 . (1277)) (1278 . (1279)) (1280 . (1281)) (1282 . (1283)) (1284 . (1285))
                        (1286 . (1287)) (1288 . (1289)) (1290 . (1291)) (1292 . (1293)) (1294 . (1295))
                        (1296 . (1297)) (1298 . (1299)) (1300 . (1301)) (1302 . (1303)) (1304 . (1305))
                        (1306 . (1307)) (1308 . (1309)) (1310 . (1311)) (1312 . (1313)) (1314 . (1315))
                        (1329 . (1377)) (1330 . (1378)) (1331 . (1379)) (1332 . (1380)) (1333 . (1381))
                        (1334 . (1382)) (1335 . (1383)) (1336 . (1384)) (1337 . (1385)) (1338 . (1386))
                        (1339 . (1387)) (1340 . (1388)) (1341 . (1389)) (1342 . (1390)) (1343 . (1391))
                        (1344 . (1392)) (1345 . (1393)) (1346 . (1394)) (1347 . (1395)) (1348 . (1396))
                        (1349 . (1397)) (1350 . (1398)) (1351 . (1399)) (1352 . (1400)) (1353 . (1401))
                        (1354 . (1402)) (1355 . (1403)) (1356 . (1404)) (1357 . (1405)) (1358 . (1406))
                        (1359 . (1407)) (1360 . (1408)) (1361 . (1409)) (1362 . (1410)) (1363 . (1411))
                        (1364 . (1412)) (1365 . (1413)) (1366 . (1414)) (1415 . (1381 1410)) (4256 . (11520))
                        (4257 . (11521)) (4258 . (11522)) (4259 . (11523)) (4260 . (11524)) (4261 . (11525))
                        (4262 . (11526)) (4263 . (11527)) (4264 . (11528)) (4265 . (11529)) (4266 . (11530))
                        (4267 . (11531)) (4268 . (11532)) (4269 . (11533)) (4270 . (11534)) (4271 . (11535))
                        (4272 . (11536)) (4273 . (11537)) (4274 . (11538)) (4275 . (11539)) (4276 . (11540))
                        (4277 . (11541)) (4278 . (11542)) (4279 . (11543)) (4280 . (11544)) (4281 . (11545))
                        (4282 . (11546)) (4283 . (11547)) (4284 . (11548)) (4285 . (11549)) (4286 . (11550))
                        (4287 . (11551)) (4288 . (11552)) (4289 . (11553)) (4290 . (11554)) (4291 . (11555))
                        (4292 . (11556)) (4293 . (11557)) (7680 . (7681)) (7682 . (7683)) (7684 . (7685))
                        (7686 . (7687)) (7688 . (7689)) (7690 . (7691)) (7692 . (7693)) (7694 . (7695))
                        (7696 . (7697)) (7698 . (7699)) (7700 . (7701)) (7702 . (7703)) (7704 . (7705))
                        (7706 . (7707)) (7708 . (7709)) (7710 . (7711)) (7712 . (7713)) (7714 . (7715))
                        (7716 . (7717)) (7718 . (7719)) (7720 . (7721)) (7722 . (7723)) (7724 . (7725))
                        (7726 . (7727)) (7728 . (7729)) (7730 . (7731)) (7732 . (7733)) (7734 . (7735))
                        (7736 . (7737)) (7738 . (7739)) (7740 . (7741)) (7742 . (7743)) (7744 . (7745))
                        (7746 . (7747)) (7748 . (7749)) (7750 . (7751)) (7752 . (7753)) (7754 . (7755))
                        (7756 . (7757)) (7758 . (7759)) (7760 . (7761)) (7762 . (7763)) (7764 . (7765))
                        (7766 . (7767)) (7768 . (7769)) (7770 . (7771)) (7772 . (7773)) (7774 . (7775))
                        (7776 . (7777)) (7778 . (7779)) (7780 . (7781)) (7782 . (7783)) (7784 . (7785))
                        (7786 . (7787)) (7788 . (7789)) (7790 . (7791)) (7792 . (7793)) (7794 . (7795))
                        (7796 . (7797)) (7798 . (7799)) (7800 . (7801)) (7802 . (7803)) (7804 . (7805))
                        (7806 . (7807)) (7808 . (7809)) (7810 . (7811)) (7812 . (7813)) (7814 . (7815))
                        (7816 . (7817)) (7818 . (7819)) (7820 . (7821)) (7822 . (7823)) (7824 . (7825))
                        (7826 . (7827)) (7828 . (7829)) (7830 . (104 817)) (7831 . (116 776)) (7832 . (119 778))
                        (7833 . (121 778)) (7834 . (97 702)) (7835 . (7777)) (7838 . (115 115)) (7840 . (7841))
                        (7842 . (7843)) (7844 . (7845)) (7846 . (7847)) (7848 . (7849)) (7850 . (7851))
                        (7852 . (7853)) (7854 . (7855)) (7856 . (7857)) (7858 . (7859)) (7860 . (7861))
                        (7862 . (7863)) (7864 . (7865)) (7866 . (7867)) (7868 . (7869)) (7870 . (7871))
                        (7872 . (7873)) (7874 . (7875)) (7876 . (7877)) (7878 . (7879)) (7880 . (7881))
                        (7882 . (7883)) (7884 . (7885)) (7886 . (7887)) (7888 . (7889)) (7890 . (7891))
                        (7892 . (7893)) (7894 . (7895)) (7896 . (7897)) (7898 . (7899)) (7900 . (7901))
                        (7902 . (7903)) (7904 . (7905)) (7906 . (7907)) (7908 . (7909)) (7910 . (7911))
                        (7912 . (7913)) (7914 . (7915)) (7916 . (7917)) (7918 . (7919)) (7920 . (7921))
                        (7922 . (7923)) (7924 . (7925)) (7926 . (7927)) (7928 . (7929)) (7930 . (7931))
                        (7932 . (7933)) (7934 . (7935)) (7944 . (7936)) (7945 . (7937)) (7946 . (7938))
                        (7947 . (7939)) (7948 . (7940)) (7949 . (7941)) (7950 . (7942)) (7951 . (7943))
                        (7960 . (7952)) (7961 . (7953)) (7962 . (7954)) (7963 . (7955)) (7964 . (7956))
                        (7965 . (7957)) (7976 . (7968)) (7977 . (7969)) (7978 . (7970)) (7979 . (7971))
                        (7980 . (7972)) (7981 . (7973)) (7982 . (7974)) (7983 . (7975)) (7992 . (7984))
                        (7993 . (7985)) (7994 . (7986)) (7995 . (7987)) (7996 . (7988)) (7997 . (7989))
                        (7998 . (7990)) (7999 . (7991)) (8008 . (8000)) (8009 . (8001)) (8010 . (8002))
                        (8011 . (8003)) (8012 . (8004)) (8013 . (8005)) (8016 . (965 787)) (8018 . (965 787 768))
                        (8020 . (965 787 769)) (8022 . (965 787 834)) (8025 . (8017)) (8027 . (8019)) (8029 . (8021))
                        (8031 . (8023)) (8040 . (8032)) (8041 . (8033)) (8042 . (8034)) (8043 . (8035))
                        (8044 . (8036)) (8045 . (8037)) (8046 . (8038)) (8047 . (8039)) (8064 . (7936 953))
                        (8065 . (7937 953)) (8066 . (7938 953)) (8067 . (7939 953)) (8068 . (7940 953)) (8069 . (7941 953))
                        (8070 . (7942 953)) (8071 . (7943 953)) (8072 . (7936 953)) (8073 . (7937 953)) (8074 . (7938 953))
                        (8075 . (7939 953)) (8076 . (7940 953)) (8077 . (7941 953)) (8078 . (7942 953)) (8079 . (7943 953))
                        (8080 . (7968 953)) (8081 . (7969 953)) (8082 . (7970 953)) (8083 . (7971 953)) (8084 . (7972 953))
                        (8085 . (7973 953)) (8086 . (7974 953)) (8087 . (7975 953)) (8088 . (7968 953)) (8089 . (7969 953))
                        (8090 . (7970 953)) (8091 . (7971 953)) (8092 . (7972 953)) (8093 . (7973 953)) (8094 . (7974 953))
                        (8095 . (7975 953)) (8096 . (8032 953)) (8097 . (8033 953)) (8098 . (8034 953)) (8099 . (8035 953))
                        (8100 . (8036 953)) (8101 . (8037 953)) (8102 . (8038 953)) (8103 . (8039 953)) (8104 . (8032 953))
                        (8105 . (8033 953)) (8106 . (8034 953)) (8107 . (8035 953)) (8108 . (8036 953)) (8109 . (8037 953))
                        (8110 . (8038 953)) (8111 . (8039 953)) (8114 . (8048 953)) (8115 . (945 953)) (8116 . (940 953))
                        (8118 . (945 834)) (8119 . (945 834 953)) (8120 . (8112)) (8121 . (8113)) (8122 . (8048))
                        (8123 . (8049)) (8124 . (945 953)) (8126 . (953)) (8130 . (8052 953)) (8131 . (951 953))
                        (8132 . (942 953)) (8134 . (951 834)) (8135 . (951 834 953)) (8136 . (8050)) (8137 . (8051))
                        (8138 . (8052)) (8139 . (8053)) (8140 . (951 953)) (8146 . (953 776 768)) (8147 . (953 776 769))
                        (8150 . (953 834)) (8151 . (953 776 834)) (8152 . (8144)) (8153 . (8145)) (8154 . (8054))
                        (8155 . (8055)) (8162 . (965 776 768)) (8163 . (965 776 769)) (8164 . (961 787)) (8166 . (965 834))
                        (8167 . (965 776 834)) (8168 . (8160)) (8169 . (8161)) (8170 . (8058)) (8171 . (8059))
                        (8172 . (8165)) (8178 . (8060 953)) (8179 . (969 953)) (8180 . (974 953)) (8182 . (969 834))
                        (8183 . (969 834 953)) (8184 . (8056)) (8185 . (8057)) (8186 . (8060)) (8187 . (8061))
                        (8188 . (969 953)) (8486 . (969)) (8490 . (107)) (8491 . (229)) (8498 . (8526))
                        (8544 . (8560)) (8545 . (8561)) (8546 . (8562)) (8547 . (8563)) (8548 . (8564))
                        (8549 . (8565)) (8550 . (8566)) (8551 . (8567)) (8552 . (8568)) (8553 . (8569))
                        (8554 . (8570)) (8555 . (8571)) (8556 . (8572)) (8557 . (8573)) (8558 . (8574))
                        (8559 . (8575)) (8579 . (8580)) (9398 . (9424)) (9399 . (9425)) (9400 . (9426))
                        (9401 . (9427)) (9402 . (9428)) (9403 . (9429)) (9404 . (9430)) (9405 . (9431))
                        (9406 . (9432)) (9407 . (9433)) (9408 . (9434)) (9409 . (9435)) (9410 . (9436))
                        (9411 . (9437)) (9412 . (9438)) (9413 . (9439)) (9414 . (9440)) (9415 . (9441))
                        (9416 . (9442)) (9417 . (9443)) (9418 . (9444)) (9419 . (9445)) (9420 . (9446))
                        (9421 . (9447)) (9422 . (9448)) (9423 . (9449)) (11264 . (11312)) (11265 . (11313))
                        (11266 . (11314)) (11267 . (11315)) (11268 . (11316)) (11269 . (11317)) (11270 . (11318))
                        (11271 . (11319)) (11272 . (11320)) (11273 . (11321)) (11274 . (11322)) (11275 . (11323))
                        (11276 . (11324)) (11277 . (11325)) (11278 . (11326)) (11279 . (11327)) (11280 . (11328))
                        (11281 . (11329)) (11282 . (11330)) (11283 . (11331)) (11284 . (11332)) (11285 . (11333))
                        (11286 . (11334)) (11287 . (11335)) (11288 . (11336)) (11289 . (11337)) (11290 . (11338))
                        (11291 . (11339)) (11292 . (11340)) (11293 . (11341)) (11294 . (11342)) (11295 . (11343))
                        (11296 . (11344)) (11297 . (11345)) (11298 . (11346)) (11299 . (11347)) (11300 . (11348))
                        (11301 . (11349)) (11302 . (11350)) (11303 . (11351)) (11304 . (11352)) (11305 . (11353))
                        (11306 . (11354)) (11307 . (11355)) (11308 . (11356)) (11309 . (11357)) (11310 . (11358))
                        (11360 . (11361)) (11362 . (619)) (11363 . (7549)) (11364 . (637)) (11367 . (11368))
                        (11369 . (11370)) (11371 . (11372)) (11373 . (593)) (11374 . (625)) (11375 . (592))
                        (11378 . (11379)) (11381 . (11382)) (11392 . (11393)) (11394 . (11395)) (11396 . (11397))
                        (11398 . (11399)) (11400 . (11401)) (11402 . (11403)) (11404 . (11405)) (11406 . (11407))
                        (11408 . (11409)) (11410 . (11411)) (11412 . (11413)) (11414 . (11415)) (11416 . (11417))
                        (11418 . (11419)) (11420 . (11421)) (11422 . (11423)) (11424 . (11425)) (11426 . (11427))
                        (11428 . (11429)) (11430 . (11431)) (11432 . (11433)) (11434 . (11435)) (11436 . (11437))
                        (11438 . (11439)) (11440 . (11441)) (11442 . (11443)) (11444 . (11445)) (11446 . (11447))
                        (11448 . (11449)) (11450 . (11451)) (11452 . (11453)) (11454 . (11455)) (11456 . (11457))
                        (11458 . (11459)) (11460 . (11461)) (11462 . (11463)) (11464 . (11465)) (11466 . (11467))
                        (11468 . (11469)) (11470 . (11471)) (11472 . (11473)) (11474 . (11475)) (11476 . (11477))
                        (11478 . (11479)) (11480 . (11481)) (11482 . (11483)) (11484 . (11485)) (11486 . (11487))
                        (11488 . (11489)) (11490 . (11491)) (42560 . (42561)) (42562 . (42563)) (42564 . (42565))
                        (42566 . (42567)) (42568 . (42569)) (42570 . (42571)) (42572 . (42573)) (42574 . (42575))
                        (42576 . (42577)) (42578 . (42579)) (42580 . (42581)) (42582 . (42583)) (42584 . (42585))
                        (42586 . (42587)) (42588 . (42589)) (42590 . (42591)) (42594 . (42595)) (42596 . (42597))
                        (42598 . (42599)) (42600 . (42601)) (42602 . (42603)) (42604 . (42605)) (42624 . (42625))
                        (42626 . (42627)) (42628 . (42629)) (42630 . (42631)) (42632 . (42633)) (42634 . (42635))
                        (42636 . (42637)) (42638 . (42639)) (42640 . (42641)) (42642 . (42643)) (42644 . (42645))
                        (42646 . (42647)) (42786 . (42787)) (42788 . (42789)) (42790 . (42791)) (42792 . (42793))
                        (42794 . (42795)) (42796 . (42797)) (42798 . (42799)) (42802 . (42803)) (42804 . (42805))
                        (42806 . (42807)) (42808 . (42809)) (42810 . (42811)) (42812 . (42813)) (42814 . (42815))
                        (42816 . (42817)) (42818 . (42819)) (42820 . (42821)) (42822 . (42823)) (42824 . (42825))
                        (42826 . (42827)) (42828 . (42829)) (42830 . (42831)) (42832 . (42833)) (42834 . (42835))
                        (42836 . (42837)) (42838 . (42839)) (42840 . (42841)) (42842 . (42843)) (42844 . (42845))
                        (42846 . (42847)) (42848 . (42849)) (42850 . (42851)) (42852 . (42853)) (42854 . (42855))
                        (42856 . (42857)) (42858 . (42859)) (42860 . (42861)) (42862 . (42863)) (42873 . (42874))
                        (42875 . (42876)) (42877 . (7545)) (42878 . (42879)) (42880 . (42881)) (42882 . (42883))
                        (42884 . (42885)) (42886 . (42887)) (42891 . (42892)) (64256 . (102 102)) (64257 . (102 105))
                        (64258 . (102 108)) (64259 . (102 102 105)) (64260 . (102 102 108)) (64261 . (115 116)) (64262 . (115 116))
                        (64275 . (1396 1398)) (64276 . (1396 1381)) (64277 . (1396 1387)) (64278 . (1406 1398)) (64279 . (1396 1389))
                        (65313 . (65345)) (65314 . (65346)) (65315 . (65347)) (65316 . (65348)) (65317 . (65349))
                        (65318 . (65350)) (65319 . (65351)) (65320 . (65352)) (65321 . (65353)) (65322 . (65354))
                        (65323 . (65355)) (65324 . (65356)) (65325 . (65357)) (65326 . (65358)) (65327 . (65359))
                        (65328 . (65360)) (65329 . (65361)) (65330 . (65362)) (65331 . (65363)) (65332 . (65364))
                        (65333 . (65365)) (65334 . (65366)) (65335 . (65367)) (65336 . (65368)) (65337 . (65369))
                        (65338 . (65370)) (66560 . (66600)) (66561 . (66601)) (66562 . (66602)) (66563 . (66603))
                        (66564 . (66604)) (66565 . (66605)) (66566 . (66606)) (66567 . (66607)) (66568 . (66608))
                        (66569 . (66609)) (66570 . (66610)) (66571 . (66611)) (66572 . (66612)) (66573 . (66613))
                        (66574 . (66614)) (66575 . (66615)) (66576 . (66616)) (66577 . (66617)) (66578 . (66618))
                        (66579 . (66619)) (66580 . (66620)) (66581 . (66621)) (66582 . (66622)) (66583 . (66623))
                        (66584 . (66624)) (66585 . (66625)) (66586 . (66626)) (66587 . (66627)) (66588 . (66628))
                        (66589 . (66629)) (66590 . (66630)) (66591 . (66631)) (66592 . (66632)) (66593 . (66633))
                        (66594 . (66634)) (66595 . (66635)) (66596 . (66636)) (66597 . (66637)) (66598 . (66638))
                        (66599 . (66639))))

(define special-lowercase-list '(
                                 (223 . (223)) (304 . (105 775)) (64256 . (64256)) (64257 . (64257)) (64258 . (64258))
                                 (64259 . (64259)) (64260 . (64260)) (64261 . (64261)) (64262 . (64262)) (1415 . (1415))
                                 (64275 . (64275)) (64276 . (64276)) (64277 . (64277)) (64278 . (64278)) (64279 . (64279))
                                 (329 . (329)) (912 . (912)) (944 . (944)) (496 . (496)) (7830 . (7830))
                                 (7831 . (7831)) (7832 . (7832)) (7833 . (7833)) (7834 . (7834)) (8016 . (8016))
                                 (8018 . (8018)) (8020 . (8020)) (8022 . (8022)) (8118 . (8118)) (8134 . (8134))
                                 (8146 . (8146)) (8147 . (8147)) (8150 . (8150)) (8151 . (8151)) (8162 . (8162))
                                 (8163 . (8163)) (8164 . (8164)) (8166 . (8166)) (8167 . (8167)) (8182 . (8182))
                                 (837 . (837)) (8064 . (8064)) (8065 . (8065)) (8066 . (8066)) (8067 . (8067))
                                 (8068 . (8068)) (8069 . (8069)) (8070 . (8070)) (8071 . (8071)) (8072 . (8064))
                                 (8073 . (8065)) (8074 . (8066)) (8075 . (8067)) (8076 . (8068)) (8077 . (8069))
                                 (8078 . (8070)) (8079 . (8071)) (8080 . (8080)) (8081 . (8081)) (8082 . (8082))
                                 (8083 . (8083)) (8084 . (8084)) (8085 . (8085)) (8086 . (8086)) (8087 . (8087))
                                 (8088 . (8080)) (8089 . (8081)) (8090 . (8082)) (8091 . (8083)) (8092 . (8084))
                                 (8093 . (8085)) (8094 . (8086)) (8095 . (8087)) (8096 . (8096)) (8097 . (8097))
                                 (8098 . (8098)) (8099 . (8099)) (8100 . (8100)) (8101 . (8101)) (8102 . (8102))
                                 (8103 . (8103)) (8104 . (8096)) (8105 . (8097)) (8106 . (8098)) (8107 . (8099))
                                 (8108 . (8100)) (8109 . (8101)) (8110 . (8102)) (8111 . (8103)) (8115 . (8115))
                                 (8124 . (8115)) (8131 . (8131)) (8140 . (8131)) (8179 . (8179)) (8188 . (8179))
                                 (8114 . (8114)) (8116 . (8116)) (8130 . (8130)) (8132 . (8132)) (8178 . (8178))
                                 (8180 . (8180)) (8119 . (8119)) (8135 . (8135)) (8183 . (8183)) (931 . (963))
                                 (963 . (963)) (962 . (962))))

(define special-uppercase-list '(
                                 (223 . (83 115)) (304 . (304)) (64256 . (70 102)) (64257 . (70 105)) (64258 . (70 108))
                                 (64259 . (70 102 105)) (64260 . (70 102 108)) (64261 . (83 116)) (64262 . (83 116)) (1415 . (1333 1410))
                                 (64275 . (1348 1398)) (64276 . (1348 1381)) (64277 . (1348 1387)) (64278 . (1358 1398)) (64279 . (1348 1389))
                                 (329 . (700 78)) (912 . (921 776 769)) (944 . (933 776 769)) (496 . (74 780)) (7830 . (72 817))
                                 (7831 . (84 776)) (7832 . (87 778)) (7833 . (89 778)) (7834 . (65 702)) (8016 . (933 787))
                                 (8018 . (933 787 768)) (8020 . (933 787 769)) (8022 . (933 787 834)) (8118 . (913 834)) (8134 . (919 834))
                                 (8146 . (921 776 768)) (8147 . (921 776 769)) (8150 . (921 834)) (8151 . (921 776 834)) (8162 . (933 776 768))
                                 (8163 . (933 776 769)) (8164 . (929 787)) (8166 . (933 834)) (8167 . (933 776 834)) (8182 . (937 834))
                                 (837 . (837)) (8064 . (8072)) (8065 . (8073)) (8066 . (8074)) (8067 . (8075))
                                 (8068 . (8076)) (8069 . (8077)) (8070 . (8078)) (8071 . (8079)) (8072 . (8072))
                                 (8073 . (8073)) (8074 . (8074)) (8075 . (8075)) (8076 . (8076)) (8077 . (8077))
                                 (8078 . (8078)) (8079 . (8079)) (8080 . (8088)) (8081 . (8089)) (8082 . (8090))
                                 (8083 . (8091)) (8084 . (8092)) (8085 . (8093)) (8086 . (8094)) (8087 . (8095))
                                 (8088 . (8088)) (8089 . (8089)) (8090 . (8090)) (8091 . (8091)) (8092 . (8092))
                                 (8093 . (8093)) (8094 . (8094)) (8095 . (8095)) (8096 . (8104)) (8097 . (8105))
                                 (8098 . (8106)) (8099 . (8107)) (8100 . (8108)) (8101 . (8109)) (8102 . (8110))
                                 (8103 . (8111)) (8104 . (8104)) (8105 . (8105)) (8106 . (8106)) (8107 . (8107))
                                 (8108 . (8108)) (8109 . (8109)) (8110 . (8110)) (8111 . (8111)) (8115 . (8124))
                                 (8124 . (8124)) (8131 . (8140)) (8140 . (8140)) (8179 . (8188)) (8188 . (8188))
                                 (8114 . (8122 837)) (8116 . (902 837)) (8130 . (8138 837)) (8132 . (905 837)) (8178 . (8186 837))
                                 (8180 . (911 837)) (8119 . (913 834 837)) (8135 . (919 834 837)) (8183 . (937 834 837)) (931 . (931))
                                 (963 . (931)) (962 . (931))))




(define whitespace-property-list '( (9 . 13) 32 133 160 5760 6158 (8192 . 8202) 8232 8233 8239 8287 12288))

(define other-alphabetic-property-list '( 837 (1456 . 1469) 1471 (1473 . 1474) (1476 . 1477) 1479 (1552 . 1562) (1611 . 1623) (1625 . 1630) 1648 (1750 . 1756) (1761 . 1764) (1767 . 1768) 1773 1809 (1840 . 1855) (1958 . 1968) (2305 . 2306) 2307 (2366 . 2368) (2369 . 2376) (2377 . 2380) (2402 . 2403) 2433 (2434 . 2435) (2494 . 2496) (2497 . 2500) (2503 . 2504) (2507 . 2508) 2519 (2530 . 2531) (2561 . 2562) 2563 (2622 . 2624) (2625 . 2626) (2631 . 2632) (2635 . 2636) 2641 (2672 . 2673) 2677 (2689 . 2690) 2691 (2750 . 2752) (2753 . 2757) (2759 . 2760) 2761 (2763 . 2764) (2786 . 2787) 2817 (2818 . 2819) 2878 2879 2880 (2881 . 2884) (2887 . 2888) (2891 . 2892) 2902 2903 (2914 . 2915) 2946 (3006 . 3007) 3008 (3009 . 3010) (3014 . 3016) (3018 . 3020) 3031 (3073 . 3075) (3134 . 3136) (3137 . 3140) (3142 . 3144) (3146 . 3148) (3157 . 3158) (3170 . 3171) (3202 . 3203) 3262 3263 (3264 . 3268) 3270 (3271 . 3272) (3274 . 3275) 3276 (3285 . 3286) (3298 . 3299) (3330 . 3331) (3390 . 3392) (3393 . 3396) (3398 . 3400) (3402 . 3404) 3415 (3426 . 3427) (3458 . 3459) (3535 . 3537) (3538 . 3540) 3542 (3544 . 3551) (3570 . 3571) 3633 (3636 . 3642) 3661 3761 (3764 . 3769) (3771 . 3772) 3789 (3953 . 3966) 3967 (3968 . 3969) (3984 . 3991) (3993 . 4028) (4139 . 4140) (4141 . 4144) 4145 (4146 . 4150) 4152 (4155 . 4156) (4157 . 4158) (4182 . 4183) (4184 . 4185) (4190 . 4192) 4194 (4199 . 4200) (4209 . 4212) 4226 (4227 . 4228) (4229 . 4230) 4959 (5906 . 5907) (5938 . 5939) (5970 . 5971) (6002 . 6003) 6070 (6071 . 6077) (6078 . 6085) 6086 (6087 . 6088) 6313 (6432 . 6434) (6435 . 6438) (6439 . 6440) (6441 . 6443) (6448 . 6449) 6450 (6451 . 6456) (6576 . 6592) (6600 . 6601) (6679 . 6680) (6681 . 6683) (6912 . 6915) 6916 6965 (6966 . 6970) 6971 6972 (6973 . 6977) 6978 6979 (7040 . 7041) 7042 7073 (7074 . 7077) (7078 . 7079) (7080 . 7081) (7204 . 7211) (7212 . 7219) (7220 . 7221) (9398 . 9449) (11744 . 11775) (43043 . 43044) (43045 . 43046) 43047 (43136 . 43137) (43188 . 43203) (43302 . 43306) (43335 . 43345) 43346 (43561 . 43566) (43567 . 43568) (43569 . 43570) (43571 . 43572) (43573 . 43574) 43587 43596 43597 64286 (68097 . 68099) (68101 . 68102) (68108 . 68111)))

(define other-uppercase-property-list '( (8544 . 8559) (9398 . 9423)))
(define other-lowercase-property-list '( (688 . 696) (704 . 705) (736 . 740) 837 890 (7468 . 7521) 7544 (7579 . 7615) (8336 . 8340) (8560 . 8575) (9424 . 9449) 11389 42864))

(define general-category-alist '(
                                 (Zl . (8232))
                                 (Po . ((33 . 35) (37 . 39) 42 44 (46 . 47) (58 . 59) (63 . 64) 92 161 183 191 894 903 (1370 . 1375) 1417 1472 1475 1478 (1523 . 1524) (1545 . 1546) (1548 . 1549) 1563 (1566 . 1567) (1642 . 1645) 1748 (1792 . 1805) (2039 . 2041) (2404 . 2405) 2416 3572 3663 (3674 . 3675) (3844 . 3858) 3973 (4048 . 4052) (4170 . 4175) 4347 (4961 . 4968) (5741 . 5742) (5867 . 5869) (5941 . 5942) (6100 . 6102) (6104 . 6106) (6144 . 6149) (6151 . 6154) (6468 . 6469) (6622 . 6623) (6686 . 6687) (7002 . 7008) (7227 . 7231) (7294 . 7295) (8214 . 8215) (8224 . 8231) (8240 . 8248) (8251 . 8254) (8257 . 8259) (8263 . 8273) 8275 (8277 . 8286) (11513 . 11516) (11518 . 11519) (11776 . 11777) (11782 . 11784) 11787 (11790 . 11798) (11800 . 11801) 11803 (11806 . 11807) (11818 . 11822) 11824 (12289 . 12291) 12349 12539 (42509 . 42511) 42611 42622 (43124 . 43127) (43214 . 43215) (43310 . 43311) 43359 (43612 . 43615) (65040 . 65046) 65049 65072 (65093 . 65094) (65097 . 65100) (65104 . 65106) (65108 . 65111) (65119 . 65121) 65128 (65130 . 65131) (65281 . 65283) (65285 . 65287) 65290 65292 (65294 . 65295) (65306 . 65307) (65311 . 65312) 65340 65377 (65380 . 65381) (65792 . 65793) 66463 66512 67871 67903 (68176 . 68184) (74864 . 74867)))
                                 (Pc . (95 (8255 . 8256) 8276 (65075 . 65076) (65101 . 65103) 65343))
                                 (Lt . (453 456 459 498 (8072 . 8079) (8088 . 8095) (8104 . 8111) 8124 8140 8188))
                                 (Pi . (171 8216 (8219 . 8220) 8223 8249 11778 11780 11785 11788 11804 11808))
                                 (Cc . ((0 . 31) (127 . 159)))
                                 (Nd . ((48 . 57) (1632 . 1641) (1776 . 1785) (1984 . 1993) (2406 . 2415) (2534 . 2543) (2662 . 2671) (2790 . 2799) (2918 . 2927) (3046 . 3055) (3174 . 3183) (3302 . 3311) (3430 . 3439) (3664 . 3673) (3792 . 3801) (3872 . 3881) (4160 . 4169) (4240 . 4249) (6112 . 6121) (6160 . 6169) (6470 . 6479) (6608 . 6617) (6992 . 7001) (7088 . 7097) (7232 . 7241) (7248 . 7257) (42528 . 42537) (43216 . 43225) (43264 . 43273) (43600 . 43609) (65296 . 65305) (66720 . 66729) (120782 . 120831)))
                                 (Mn . ((768 . 879) (1155 . 1159) (1425 . 1469) 1471 (1473 . 1474) (1476 . 1477) 1479 (1552 . 1562) (1611 . 1630) 1648 (1750 . 1756) (1759 . 1764) (1767 . 1768) (1770 . 1773) 1809 (1840 . 1866) (1958 . 1968) (2027 . 2035) (2305 . 2306) 2364 (2369 . 2376) 2381 (2385 . 2388) (2402 . 2403) 2433 2492 (2497 . 2500) 2509 (2530 . 2531) (2561 . 2562) 2620 (2625 . 2626) (2631 . 2632) (2635 . 2637) 2641 (2672 . 2673) 2677 (2689 . 2690) 2748 (2753 . 2757) (2759 . 2760) 2765 (2786 . 2787) 2817 2876 2879 (2881 . 2884) 2893 2902 (2914 . 2915) 2946 3008 3021 (3134 . 3136) (3142 . 3144) (3146 . 3149) (3157 . 3158) (3170 . 3171) 3260 3263 3270 (3276 . 3277) (3298 . 3299) (3393 . 3396) 3405 (3426 . 3427) 3530 (3538 . 3540) 3542 3633 (3636 . 3642) (3655 . 3662) 3761 (3764 . 3769) (3771 . 3772) (3784 . 3789) (3864 . 3865) 3893 3895 3897 (3953 . 3966) (3968 . 3972) (3974 . 3975) (3984 . 3991) (3993 . 4028) 4038 (4141 . 4144) (4146 . 4151) (4153 . 4154) (4157 . 4158) (4184 . 4185) (4190 . 4192) (4209 . 4212) 4226 (4229 . 4230) 4237 4959 (5906 . 5908) (5938 . 5940) (5970 . 5971) (6002 . 6003) (6071 . 6077) 6086 (6089 . 6099) 6109 (6155 . 6157) 6313 (6432 . 6434) (6439 . 6440) 6450 (6457 . 6459) (6679 . 6680) (6912 . 6915) 6964 (6966 . 6970) 6972 6978 (7019 . 7027) (7040 . 7041) (7074 . 7077) (7080 . 7081) (7212 . 7219) (7222 . 7223) (7616 . 7654) (7678 . 7679) (8400 . 8412) 8417 (8421 . 8432) (11744 . 11775) (12330 . 12335) (12441 . 12442) 42607 (42620 . 42621) 43010 43014 43019 (43045 . 43046) 43204 (43302 . 43309) (43335 . 43345) (43561 . 43566) (43569 . 43570) (43573 . 43574) 43587 43596 64286 (65024 . 65039) (65056 . 65062) 66045 (68097 . 68099) (68101 . 68102) (68108 . 68111) (68152 . 68154) 68159 (119143 . 119145) (119163 . 119170) (119173 . 119179) (119210 . 119213) (119362 . 119364) (917760 . 917999)))
                                 (Me . ((1160 . 1161) 1758 (8413 . 8416) (8418 . 8420) (42608 . 42610)))
                                 (Sc . (36 (162 . 165) 1547 (2546 . 2547) 2801 3065 3647 6107 (8352 . 8373) 65020 65129 65284 (65504 . 65505) (65509 . 65510)))
                                 (Cs . (55296 (56191 . 56192) (56319 . 56320) 57343))
                                 (Cf . (173 (1536 . 1539) 1757 1807 (6068 . 6069) (8203 . 8207) (8234 . 8238) (8288 . 8292) (8298 . 8303) 65279 (65529 . 65531) (119155 . 119162) 917505 (917536 . 917631)))
                                 (So . ((166 . 167) 169 174 176 182 1154 (1550 . 1551) 1769 (1789 . 1790) 2038 2554 2928 (3059 . 3064) 3066 3199 (3313 . 3314) 3449 (3841 . 3843) (3859 . 3863) (3866 . 3871) 3892 3894 3896 (4030 . 4037) (4039 . 4044) (4046 . 4047) (4254 . 4255) 4960 (5008 . 5017) 6464 (6624 . 6655) (7009 . 7018) (7028 . 7036) (8448 . 8449) (8451 . 8454) (8456 . 8457) 8468 (8470 . 8472) (8478 . 8483) 8485 8487 8489 8494 (8506 . 8507) 8522 (8524 . 8525) 8527 (8597 . 8601) (8604 . 8607) (8609 . 8610) (8612 . 8613) (8615 . 8621) (8623 . 8653) (8656 . 8657) 8659 (8661 . 8691) (8960 . 8967) (8972 . 8991) (8994 . 9000) (9003 . 9083) (9085 . 9114) (9140 . 9179) (9186 . 9191) (9216 . 9254) (9280 . 9290) (9372 . 9449) (9472 . 9654) (9656 . 9664) (9666 . 9719) (9728 . 9838) (9840 . 9885) (9888 . 9916) (9920 . 9923) (9985 . 9988) (9990 . 9993) (9996 . 10023) (10025 . 10059) 10061 (10063 . 10066) 10070 (10072 . 10078) (10081 . 10087) 10132 (10136 . 10159) (10161 . 10174) (10240 . 10495) (11008 . 11055) (11077 . 11078) (11088 . 11092) (11493 . 11498) (11904 . 11929) (11931 . 12019) (12032 . 12245) (12272 . 12283) 12292 (12306 . 12307) 12320 (12342 . 12343) (12350 . 12351) (12688 . 12689) (12694 . 12703) (12736 . 12771) (12800 . 12830) (12842 . 12867) 12880 (12896 . 12927) (12938 . 12976) (12992 . 13054) (13056 . 13311) (19904 . 19967) (42128 . 42182) (43048 . 43051) 65021 65508 65512 (65517 . 65518) (65532 . 65533) 65794 (65847 . 65855) (65913 . 65929) (65936 . 65947) (66000 . 66044) (118784 . 119029) (119040 . 119078) (119081 . 119140) (119146 . 119148) (119171 . 119172) (119180 . 119209) (119214 . 119261) (119296 . 119361) 119365 (119552 . 119638) (126976 . 127019) (127024 . 127123)))
                                 (Zs . (32 160 5760 6158 (8192 . 8202) 8239 8287 12288))
                                 (Sm . (43 (60 . 62) 124 126 172 177 215 247 1014 (1542 . 1544) 8260 8274 (8314 . 8316) (8330 . 8332) (8512 . 8516) 8523 (8592 . 8596) (8602 . 8603) 8608 8611 8614 8622 (8654 . 8655) 8658 8660 (8692 . 8959) (8968 . 8971) (8992 . 8993) 9084 (9115 . 9139) (9180 . 9185) 9655 9665 (9720 . 9727) 9839 (10176 . 10180) (10183 . 10186) 10188 (10192 . 10213) (10224 . 10239) (10496 . 10626) (10649 . 10711) (10716 . 10747) (10750 . 11007) (11056 . 11076) (11079 . 11084) 64297 65122 (65124 . 65126) 65291 (65308 . 65310) 65372 65374 65506 (65513 . 65516) 120513 120539 120571 120597 120629 120655 120687 120713 120745 120771))
                                 (Mc . (2307 (2366 . 2368) (2377 . 2380) (2434 . 2435) (2494 . 2496) (2503 . 2504) (2507 . 2508) 2519 2563 (2622 . 2624) 2691 (2750 . 2752) 2761 (2763 . 2764) (2818 . 2819) 2878 2880 (2887 . 2888) (2891 . 2892) 2903 (3006 . 3007) (3009 . 3010) (3014 . 3016) (3018 . 3020) 3031 (3073 . 3075) (3137 . 3140) (3202 . 3203) 3262 (3264 . 3268) (3271 . 3272) (3274 . 3275) (3285 . 3286) (3330 . 3331) (3390 . 3392) (3398 . 3400) (3402 . 3404) 3415 (3458 . 3459) (3535 . 3537) (3544 . 3551) (3570 . 3571) (3902 . 3903) 3967 (4139 . 4140) 4145 4152 (4155 . 4156) (4182 . 4183) (4194 . 4196) (4199 . 4205) (4227 . 4228) (4231 . 4236) 4239 6070 (6078 . 6085) (6087 . 6088) (6435 . 6438) (6441 . 6443) (6448 . 6449) (6451 . 6456) (6576 . 6592) (6600 . 6601) (6681 . 6683) 6916 6965 6971 (6973 . 6977) (6979 . 6980) 7042 7073 (7078 . 7079) 7082 (7204 . 7211) (7220 . 7221) (43043 . 43044) 43047 (43136 . 43137) (43188 . 43203) (43346 . 43347) (43567 . 43568) (43571 . 43572) 43597 (119141 . 119142) (119149 . 119154)))
                                 (Sk . (94 96 168 175 180 184 (706 . 709) (722 . 735) (741 . 747) 749 (751 . 767) 885 (900 . 901) 8125 (8127 . 8129) (8141 . 8143) (8157 . 8159) (8173 . 8175) (8189 . 8190) (12443 . 12444) (42752 . 42774) (42784 . 42785) (42889 . 42890) 65342 65344 65507))
                                 (Lm . ((688 . 705) (710 . 721) (736 . 740) 748 750 884 890 1369 1600 (1765 . 1766) (2036 . 2037) 2042 2417 3654 3782 4348 6103 6211 (7288 . 7293) (7468 . 7521) 7544 (7579 . 7615) (8336 . 8340) 11389 11631 11823 12293 (12337 . 12341) 12347 (12445 . 12446) (12540 . 12542) 40981 42508 42623 (42775 . 42783) 42864 42888 65392 (65438 . 65439)))
                                 (Pe . (41 93 125 3899 3901 5788 8262 8318 8334 9002 10089 10091 10093 10095 10097 10099 10101 10182 10215 10217 10219 10221 10223 10628 10630 10632 10634 10636 10638 10640 10642 10644 10646 10648 10713 10715 10749 11811 11813 11815 11817 12297 12299 12301 12303 12305 12309 12311 12313 12315 (12318 . 12319) 64831 65048 65078 65080 65082 65084 65086 65088 65090 65092 65096 65114 65116 65118 65289 65341 65373 65376 65379))
                                 (Lo . (443 (448 . 451) 660 (1488 . 1514) (1520 . 1522) (1569 . 1599) (1601 . 1610) (1646 . 1647) (1649 . 1747) 1749 (1774 . 1775) (1786 . 1788) 1791 1808 (1810 . 1839) (1869 . 1957) 1969 (1994 . 2026) (2308 . 2361) 2365 2384 (2392 . 2401) 2418 (2427 . 2431) (2437 . 2444) (2447 . 2448) (2451 . 2472) (2474 . 2480) 2482 (2486 . 2489) 2493 2510 (2524 . 2525) (2527 . 2529) (2544 . 2545) (2565 . 2570) (2575 . 2576) (2579 . 2600) (2602 . 2608) (2610 . 2611) (2613 . 2614) (2616 . 2617) (2649 . 2652) 2654 (2674 . 2676) (2693 . 2701) (2703 . 2705) (2707 . 2728) (2730 . 2736) (2738 . 2739) (2741 . 2745) 2749 2768 (2784 . 2785) (2821 . 2828) (2831 . 2832) (2835 . 2856) (2858 . 2864) (2866 . 2867) (2869 . 2873) 2877 (2908 . 2909) (2911 . 2913) 2929 2947 (2949 . 2954) (2958 . 2960) (2962 . 2965) (2969 . 2970) 2972 (2974 . 2975) (2979 . 2980) (2984 . 2986) (2990 . 3001) 3024 (3077 . 3084) (3086 . 3088) (3090 . 3112) (3114 . 3123) (3125 . 3129) 3133 (3160 . 3161) (3168 . 3169) (3205 . 3212) (3214 . 3216) (3218 . 3240) (3242 . 3251) (3253 . 3257) 3261 3294 (3296 . 3297) (3333 . 3340) (3342 . 3344) (3346 . 3368) (3370 . 3385) 3389 (3424 . 3425) (3450 . 3455) (3461 . 3478) (3482 . 3505) (3507 . 3515) 3517 (3520 . 3526) (3585 . 3632) (3634 . 3635) (3648 . 3653) (3713 . 3714) 3716 (3719 . 3720) 3722 3725 (3732 . 3735) (3737 . 3743) (3745 . 3747) 3749 3751 (3754 . 3755) (3757 . 3760) (3762 . 3763) 3773 (3776 . 3780) (3804 . 3805) 3840 (3904 . 3911) (3913 . 3948) (3976 . 3979) (4096 . 4138) 4159 (4176 . 4181) (4186 . 4189) 4193 (4197 . 4198) (4206 . 4208) (4213 . 4225) 4238 (4304 . 4346) (4352 . 4441) (4447 . 4514) (4520 . 4601) (4608 . 4680) (4682 . 4685) (4688 . 4694) 4696 (4698 . 4701) (4704 . 4744) (4746 . 4749) (4752 . 4784) (4786 . 4789) (4792 . 4798) 4800 (4802 . 4805) (4808 . 4822) (4824 . 4880) (4882 . 4885) (4888 . 4954) (4992 . 5007) (5024 . 5108) (5121 . 5740) (5743 . 5750) (5761 . 5786) (5792 . 5866) (5888 . 5900) (5902 . 5905) (5920 . 5937) (5952 . 5969) (5984 . 5996) (5998 . 6000) (6016 . 6067) 6108 (6176 . 6210) (6212 . 6263) (6272 . 6312) 6314 (6400 . 6428) (6480 . 6509) (6512 . 6516) (6528 . 6569) (6593 . 6599) (6656 . 6678) (6917 . 6963) (6981 . 6987) (7043 . 7072) (7086 . 7087) (7168 . 7203) (7245 . 7247) (7258 . 7287) (8501 . 8504) (11568 . 11621) (11648 . 11670) (11680 . 11686) (11688 . 11694) (11696 . 11702) (11704 . 11710) (11712 . 11718) (11720 . 11726) (11728 . 11734) (11736 . 11742) 12294 12348 (12353 . 12438) 12447 (12449 . 12538) 12543 (12549 . 12589) (12593 . 12686) (12704 . 12727) (12784 . 12799) 13312 19893 19968 40899 (40960 . 40980) (40982 . 42124) (42240 . 42507) (42512 . 42527) (42538 . 42539) 42606 (43003 . 43009) (43011 . 43013) (43015 . 43018) (43020 . 43042) (43072 . 43123) (43138 . 43187) (43274 . 43301) (43312 . 43334) (43520 . 43560) (43584 . 43586) (43588 . 43595) 44032 55203 (63744 . 64045) (64048 . 64106) (64112 . 64217) 64285 (64287 . 64296) (64298 . 64310) (64312 . 64316) 64318 (64320 . 64321) (64323 . 64324) (64326 . 64433) (64467 . 64829) (64848 . 64911) (64914 . 64967) (65008 . 65019) (65136 . 65140) (65142 . 65276) (65382 . 65391) (65393 . 65437) (65440 . 65470) (65474 . 65479) (65482 . 65487) (65490 . 65495) (65498 . 65500) (65536 . 65547) (65549 . 65574) (65576 . 65594) (65596 . 65597) (65599 . 65613) (65616 . 65629) (65664 . 65786) (66176 . 66204) (66208 . 66256) (66304 . 66334) (66352 . 66368) (66370 . 66377) (66432 . 66461) (66464 . 66499) (66504 . 66511) (66640 . 66717) (67584 . 67589) 67592 (67594 . 67637) (67639 . 67640) 67644 67647 (67840 . 67861) (67872 . 67897) 68096 (68112 . 68115) (68117 . 68119) (68121 . 68147) (73728 . 74606) 131072 173782 (194560 . 195101)))
                                 (Pd . (45 1418 1470 6150 (8208 . 8213) 11799 11802 12316 12336 12448 (65073 . 65074) 65112 65123 65293))
                                 (Ll . ((97 . 122) 170 181 186 (223 . 246) (248 . 255) 257 259 261 263 265 267 269 271 273 275 277 279 281 283 285 287 289 291 293 295 297 299 301 303 305 307 309 (311 . 312) 314 316 318 320 322 324 326 (328 . 329) 331 333 335 337 339 341 343 345 347 349 351 353 355 357 359 361 363 365 367 369 371 373 375 378 380 (382 . 384) 387 389 392 (396 . 397) 402 405 (409 . 411) 414 417 419 421 424 (426 . 427) 429 432 436 438 (441 . 442) (445 . 447) 454 457 460 462 464 466 468 470 472 474 (476 . 477) 479 481 483 485 487 489 491 493 (495 . 496) 499 501 505 507 509 511 513 515 517 519 521 523 525 527 529 531 533 535 537 539 541 543 545 547 549 551 553 555 557 559 561 (563 . 569) 572 (575 . 576) 578 583 585 587 589 (591 . 659) (661 . 687) 881 883 887 (891 . 893) 912 (940 . 974) (976 . 977) (981 . 983) 985 987 989 991 993 995 997 999 1001 1003 1005 (1007 . 1011) 1013 1016 (1019 . 1020) (1072 . 1119) 1121 1123 1125 1127 1129 1131 1133 1135 1137 1139 1141 1143 1145 1147 1149 1151 1153 1163 1165 1167 1169 1171 1173 1175 1177 1179 1181 1183 1185 1187 1189 1191 1193 1195 1197 1199 1201 1203 1205 1207 1209 1211 1213 1215 1218 1220 1222 1224 1226 1228 (1230 . 1231) 1233 1235 1237 1239 1241 1243 1245 1247 1249 1251 1253 1255 1257 1259 1261 1263 1265 1267 1269 1271 1273 1275 1277 1279 1281 1283 1285 1287 1289 1291 1293 1295 1297 1299 1301 1303 1305 1307 1309 1311 1313 1315 (1377 . 1415) (7424 . 7467) (7522 . 7543) (7545 . 7578) 7681 7683 7685 7687 7689 7691 7693 7695 7697 7699 7701 7703 7705 7707 7709 7711 7713 7715 7717 7719 7721 7723 7725 7727 7729 7731 7733 7735 7737 7739 7741 7743 7745 7747 7749 7751 7753 7755 7757 7759 7761 7763 7765 7767 7769 7771 7773 7775 7777 7779 7781 7783 7785 7787 7789 7791 7793 7795 7797 7799 7801 7803 7805 7807 7809 7811 7813 7815 7817 7819 7821 7823 7825 7827 (7829 . 7837) 7839 7841 7843 7845 7847 7849 7851 7853 7855 7857 7859 7861 7863 7865 7867 7869 7871 7873 7875 7877 7879 7881 7883 7885 7887 7889 7891 7893 7895 7897 7899 7901 7903 7905 7907 7909 7911 7913 7915 7917 7919 7921 7923 7925 7927 7929 7931 7933 (7935 . 7943) (7952 . 7957) (7968 . 7975) (7984 . 7991) (8000 . 8005) (8016 . 8023) (8032 . 8039) (8048 . 8061) (8064 . 8071) (8080 . 8087) (8096 . 8103) (8112 . 8116) (8118 . 8119) 8126 (8130 . 8132) (8134 . 8135) (8144 . 8147) (8150 . 8151) (8160 . 8167) (8178 . 8180) (8182 . 8183) 8305 8319 8458 (8462 . 8463) 8467 8495 8500 8505 (8508 . 8509) (8518 . 8521) 8526 8580 (11312 . 11358) 11361 (11365 . 11366) 11368 11370 11372 11377 (11379 . 11380) (11382 . 11388) 11393 11395 11397 11399 11401 11403 11405 11407 11409 11411 11413 11415 11417 11419 11421 11423 11425 11427 11429 11431 11433 11435 11437 11439 11441 11443 11445 11447 11449 11451 11453 11455 11457 11459 11461 11463 11465 11467 11469 11471 11473 11475 11477 11479 11481 11483 11485 11487 11489 (11491 . 11492) (11520 . 11557) 42561 42563 42565 42567 42569 42571 42573 42575 42577 42579 42581 42583 42585 42587 42589 42591 42595 42597 42599 42601 42603 42605 42625 42627 42629 42631 42633 42635 42637 42639 42641 42643 42645 42647 42787 42789 42791 42793 42795 42797 (42799 . 42801) 42803 42805 42807 42809 42811 42813 42815 42817 42819 42821 42823 42825 42827 42829 42831 42833 42835 42837 42839 42841 42843 42845 42847 42849 42851 42853 42855 42857 42859 42861 42863 (42865 . 42872) 42874 42876 42879 42881 42883 42885 42887 42892 (64256 . 64262) (64275 . 64279) (65345 . 65370) (66600 . 66639) (119834 . 119859) (119886 . 119892) (119894 . 119911) (119938 . 119963) (119990 . 119993) 119995 (119997 . 120003) (120005 . 120015) (120042 . 120067) (120094 . 120119) (120146 . 120171) (120198 . 120223) (120250 . 120275) (120302 . 120327) (120354 . 120379) (120406 . 120431) (120458 . 120485) (120514 . 120538) (120540 . 120545) (120572 . 120596) (120598 . 120603) (120630 . 120654) (120656 . 120661) (120688 . 120712) (120714 . 120719) (120746 . 120770) (120772 . 120777) 120779))
                                 (No . ((178 . 179) 185 (188 . 190) (2548 . 2553) (3056 . 3058) (3192 . 3198) (3440 . 3445) (3882 . 3891) (4969 . 4988) (6128 . 6137) 8304 (8308 . 8313) (8320 . 8329) (8531 . 8543) (9312 . 9371) (9450 . 9471) (10102 . 10131) 11517 (12690 . 12693) (12832 . 12841) (12881 . 12895) (12928 . 12937) (12977 . 12991) (65799 . 65843) (65909 . 65912) 65930 (66336 . 66339) (67862 . 67865) (68160 . 68167) (119648 . 119665)))
                                 (Co . (57344 63743 983040 1048573 1048576 1114109))
                                 (Pf . (187 8217 8221 8250 11779 11781 11786 11789 11805 11809))
                                 (Lu . ((65 . 90) (192 . 214) (216 . 222) 256 258 260 262 264 266 268 270 272 274 276 278 280 282 284 286 288 290 292 294 296 298 300 302 304 306 308 310 313 315 317 319 321 323 325 327 330 332 334 336 338 340 342 344 346 348 350 352 354 356 358 360 362 364 366 368 370 372 374 (376 . 377) 379 381 (385 . 386) 388 (390 . 391) (393 . 395) (398 . 401) (403 . 404) (406 . 408) (412 . 413) (415 . 416) 418 420 (422 . 423) 425 428 (430 . 431) (433 . 435) 437 (439 . 440) 444 452 455 458 461 463 465 467 469 471 473 475 478 480 482 484 486 488 490 492 494 497 500 (502 . 504) 506 508 510 512 514 516 518 520 522 524 526 528 530 532 534 536 538 540 542 544 546 548 550 552 554 556 558 560 562 (570 . 571) (573 . 574) 577 (579 . 582) 584 586 588 590 880 882 886 902 (904 . 906) 908 (910 . 911) (913 . 929) (931 . 939) 975 (978 . 980) 984 986 988 990 992 994 996 998 1000 1002 1004 1006 1012 1015 (1017 . 1018) (1021 . 1071) 1120 1122 1124 1126 1128 1130 1132 1134 1136 1138 1140 1142 1144 1146 1148 1150 1152 1162 1164 1166 1168 1170 1172 1174 1176 1178 1180 1182 1184 1186 1188 1190 1192 1194 1196 1198 1200 1202 1204 1206 1208 1210 1212 1214 (1216 . 1217) 1219 1221 1223 1225 1227 1229 1232 1234 1236 1238 1240 1242 1244 1246 1248 1250 1252 1254 1256 1258 1260 1262 1264 1266 1268 1270 1272 1274 1276 1278 1280 1282 1284 1286 1288 1290 1292 1294 1296 1298 1300 1302 1304 1306 1308 1310 1312 1314 (1329 . 1366) (4256 . 4293) 7680 7682 7684 7686 7688 7690 7692 7694 7696 7698 7700 7702 7704 7706 7708 7710 7712 7714 7716 7718 7720 7722 7724 7726 7728 7730 7732 7734 7736 7738 7740 7742 7744 7746 7748 7750 7752 7754 7756 7758 7760 7762 7764 7766 7768 7770 7772 7774 7776 7778 7780 7782 7784 7786 7788 7790 7792 7794 7796 7798 7800 7802 7804 7806 7808 7810 7812 7814 7816 7818 7820 7822 7824 7826 7828 7838 7840 7842 7844 7846 7848 7850 7852 7854 7856 7858 7860 7862 7864 7866 7868 7870 7872 7874 7876 7878 7880 7882 7884 7886 7888 7890 7892 7894 7896 7898 7900 7902 7904 7906 7908 7910 7912 7914 7916 7918 7920 7922 7924 7926 7928 7930 7932 7934 (7944 . 7951) (7960 . 7965) (7976 . 7983) (7992 . 7999) (8008 . 8013) 8025 8027 8029 8031 (8040 . 8047) (8120 . 8123) (8136 . 8139) (8152 . 8155) (8168 . 8172) (8184 . 8187) 8450 8455 (8459 . 8461) (8464 . 8466) 8469 (8473 . 8477) 8484 8486 8488 (8490 . 8493) (8496 . 8499) (8510 . 8511) 8517 8579 (11264 . 11310) 11360 (11362 . 11364) 11367 11369 11371 (11373 . 11375) 11378 11381 11392 11394 11396 11398 11400 11402 11404 11406 11408 11410 11412 11414 11416 11418 11420 11422 11424 11426 11428 11430 11432 11434 11436 11438 11440 11442 11444 11446 11448 11450 11452 11454 11456 11458 11460 11462 11464 11466 11468 11470 11472 11474 11476 11478 11480 11482 11484 11486 11488 11490 42560 42562 42564 42566 42568 42570 42572 42574 42576 42578 42580 42582 42584 42586 42588 42590 42594 42596 42598 42600 42602 42604 42624 42626 42628 42630 42632 42634 42636 42638 42640 42642 42644 42646 42786 42788 42790 42792 42794 42796 42798 42802 42804 42806 42808 42810 42812 42814 42816 42818 42820 42822 42824 42826 42828 42830 42832 42834 42836 42838 42840 42842 42844 42846 42848 42850 42852 42854 42856 42858 42860 42862 42873 42875 (42877 . 42878) 42880 42882 42884 42886 42891 (65313 . 65338) (66560 . 66599) (119808 . 119833) (119860 . 119885) (119912 . 119937) 119964 (119966 . 119967) 119970 (119973 . 119974) (119977 . 119980) (119982 . 119989) (120016 . 120041) (120068 . 120069) (120071 . 120074) (120077 . 120084) (120086 . 120092) (120120 . 120121) (120123 . 120126) (120128 . 120132) 120134 (120138 . 120144) (120172 . 120197) (120224 . 120249) (120276 . 120301) (120328 . 120353) (120380 . 120405) (120432 . 120457) (120488 . 120512) (120546 . 120570) (120604 . 120628) (120662 . 120686) (120720 . 120744) 120778))
                                 (Zp . (8233))
                                 (Nl . ((5870 . 5872) (8544 . 8578) (8581 . 8584) 12295 (12321 . 12329) (12344 . 12346) (65856 . 65908) 66369 66378 (66513 . 66517) (74752 . 74850)))
                                 (Ps . (40 91 123 3898 3900 5787 8218 8222 8261 8317 8333 9001 10088 10090 10092 10094 10096 10098 10100 10181 10214 10216 10218 10220 10222 10627 10629 10631 10633 10635 10637 10639 10641 10643 10645 10647 10712 10714 10748 11810 11812 11814 11816 12296 12298 12300 12302 12304 12308 12310 12312 12314 12317 64830 65047 65077 65079 65081 65083 65085 65087 65089 65091 65095 65113 65115 65117 65288 65339 65371 65375 65378))
                                 ))

(define titlecase-alist '(
                          (97 . 65) (98 . 66) (99 . 67) (100 . 68) (101 . 69)
                          (102 . 70) (103 . 71) (104 . 72) (105 . 73) (106 . 74)
                          (107 . 75) (108 . 76) (109 . 77) (110 . 78) (111 . 79)
                          (112 . 80) (113 . 81) (114 . 82) (115 . 83) (116 . 84)
                          (117 . 85) (118 . 86) (119 . 87) (120 . 88) (121 . 89)
                          (122 . 90) (181 . 924) (224 . 192) (225 . 193) (226 . 194)
                          (227 . 195) (228 . 196) (229 . 197) (230 . 198) (231 . 199)
                          (232 . 200) (233 . 201) (234 . 202) (235 . 203) (236 . 204)
                          (237 . 205) (238 . 206) (239 . 207) (240 . 208) (241 . 209)
                          (242 . 210) (243 . 211) (244 . 212) (245 . 213) (246 . 214)
                          (248 . 216) (249 . 217) (250 . 218) (251 . 219) (252 . 220)
                          (253 . 221) (254 . 222) (255 . 376) (257 . 256) (259 . 258)
                          (261 . 260) (263 . 262) (265 . 264) (267 . 266) (269 . 268)
                          (271 . 270) (273 . 272) (275 . 274) (277 . 276) (279 . 278)
                          (281 . 280) (283 . 282) (285 . 284) (287 . 286) (289 . 288)
                          (291 . 290) (293 . 292) (295 . 294) (297 . 296) (299 . 298)
                          (301 . 300) (303 . 302) (305 . 73) (307 . 306) (309 . 308)
                          (311 . 310) (314 . 313) (316 . 315) (318 . 317) (320 . 319)
                          (322 . 321) (324 . 323) (326 . 325) (328 . 327) (331 . 330)
                          (333 . 332) (335 . 334) (337 . 336) (339 . 338) (341 . 340)
                          (343 . 342) (345 . 344) (347 . 346) (349 . 348) (351 . 350)
                          (353 . 352) (355 . 354) (357 . 356) (359 . 358) (361 . 360)
                          (363 . 362) (365 . 364) (367 . 366) (369 . 368) (371 . 370)
                          (373 . 372) (375 . 374) (378 . 377) (380 . 379) (382 . 381)
                          (383 . 83) (384 . 579) (387 . 386) (389 . 388) (392 . 391)
                          (396 . 395) (402 . 401) (405 . 502) (409 . 408) (410 . 573)
                          (414 . 544) (417 . 416) (419 . 418) (421 . 420) (424 . 423)
                          (429 . 428) (432 . 431) (436 . 435) (438 . 437) (441 . 440)
                          (445 . 444) (447 . 503) (452 . 453) (453 . 453) (454 . 453)
                          (455 . 456) (456 . 456) (457 . 456) (458 . 459) (459 . 459)
                          (460 . 459) (462 . 461) (464 . 463) (466 . 465) (468 . 467)
                          (470 . 469) (472 . 471) (474 . 473) (476 . 475) (477 . 398)
                          (479 . 478) (481 . 480) (483 . 482) (485 . 484) (487 . 486)
                          (489 . 488) (491 . 490) (493 . 492) (495 . 494) (497 . 498)
                          (498 . 498) (499 . 498) (501 . 500) (505 . 504) (507 . 506)
                          (509 . 508) (511 . 510) (513 . 512) (515 . 514) (517 . 516)
                          (519 . 518) (521 . 520) (523 . 522) (525 . 524) (527 . 526)
                          (529 . 528) (531 . 530) (533 . 532) (535 . 534) (537 . 536)
                          (539 . 538) (541 . 540) (543 . 542) (547 . 546) (549 . 548)
                          (551 . 550) (553 . 552) (555 . 554) (557 . 556) (559 . 558)
                          (561 . 560) (563 . 562) (572 . 571) (578 . 577) (583 . 582)
                          (585 . 584) (587 . 586) (589 . 588) (591 . 590) (592 . 11375)
                          (593 . 11373) (595 . 385) (596 . 390) (598 . 393) (599 . 394)
                          (601 . 399) (603 . 400) (608 . 403) (611 . 404) (616 . 407)
                          (617 . 406) (619 . 11362) (623 . 412) (625 . 11374) (626 . 413)
                          (629 . 415) (637 . 11364) (640 . 422) (643 . 425) (648 . 430)
                          (649 . 580) (650 . 433) (651 . 434) (652 . 581) (658 . 439)
                          (837 . 921) (881 . 880) (883 . 882) (887 . 886) (891 . 1021)
                          (892 . 1022) (893 . 1023) (940 . 902) (941 . 904) (942 . 905)
                          (943 . 906) (945 . 913) (946 . 914) (947 . 915) (948 . 916)
                          (949 . 917) (950 . 918) (951 . 919) (952 . 920) (953 . 921)
                          (954 . 922) (955 . 923) (956 . 924) (957 . 925) (958 . 926)
                          (959 . 927) (960 . 928) (961 . 929) (962 . 931) (963 . 931)
                          (964 . 932) (965 . 933) (966 . 934) (967 . 935) (968 . 936)
                          (969 . 937) (970 . 938) (971 . 939) (972 . 908) (973 . 910)
                          (974 . 911) (976 . 914) (977 . 920) (981 . 934) (982 . 928)
                          (983 . 975) (985 . 984) (987 . 986) (989 . 988) (991 . 990)
                          (993 . 992) (995 . 994) (997 . 996) (999 . 998) (1001 . 1000)
                          (1003 . 1002) (1005 . 1004) (1007 . 1006) (1008 . 922) (1009 . 929)
                          (1010 . 1017) (1013 . 917) (1016 . 1015) (1019 . 1018) (1072 . 1040)
                          (1073 . 1041) (1074 . 1042) (1075 . 1043) (1076 . 1044) (1077 . 1045)
                          (1078 . 1046) (1079 . 1047) (1080 . 1048) (1081 . 1049) (1082 . 1050)
                          (1083 . 1051) (1084 . 1052) (1085 . 1053) (1086 . 1054) (1087 . 1055)
                          (1088 . 1056) (1089 . 1057) (1090 . 1058) (1091 . 1059) (1092 . 1060)
                          (1093 . 1061) (1094 . 1062) (1095 . 1063) (1096 . 1064) (1097 . 1065)
                          (1098 . 1066) (1099 . 1067) (1100 . 1068) (1101 . 1069) (1102 . 1070)
                          (1103 . 1071) (1104 . 1024) (1105 . 1025) (1106 . 1026) (1107 . 1027)
                          (1108 . 1028) (1109 . 1029) (1110 . 1030) (1111 . 1031) (1112 . 1032)
                          (1113 . 1033) (1114 . 1034) (1115 . 1035) (1116 . 1036) (1117 . 1037)
                          (1118 . 1038) (1119 . 1039) (1121 . 1120) (1123 . 1122) (1125 . 1124)
                          (1127 . 1126) (1129 . 1128) (1131 . 1130) (1133 . 1132) (1135 . 1134)
                          (1137 . 1136) (1139 . 1138) (1141 . 1140) (1143 . 1142) (1145 . 1144)
                          (1147 . 1146) (1149 . 1148) (1151 . 1150) (1153 . 1152) (1163 . 1162)
                          (1165 . 1164) (1167 . 1166) (1169 . 1168) (1171 . 1170) (1173 . 1172)
                          (1175 . 1174) (1177 . 1176) (1179 . 1178) (1181 . 1180) (1183 . 1182)
                          (1185 . 1184) (1187 . 1186) (1189 . 1188) (1191 . 1190) (1193 . 1192)
                          (1195 . 1194) (1197 . 1196) (1199 . 1198) (1201 . 1200) (1203 . 1202)
                          (1205 . 1204) (1207 . 1206) (1209 . 1208) (1211 . 1210) (1213 . 1212)
                          (1215 . 1214) (1218 . 1217) (1220 . 1219) (1222 . 1221) (1224 . 1223)
                          (1226 . 1225) (1228 . 1227) (1230 . 1229) (1231 . 1216) (1233 . 1232)
                          (1235 . 1234) (1237 . 1236) (1239 . 1238) (1241 . 1240) (1243 . 1242)
                          (1245 . 1244) (1247 . 1246) (1249 . 1248) (1251 . 1250) (1253 . 1252)
                          (1255 . 1254) (1257 . 1256) (1259 . 1258) (1261 . 1260) (1263 . 1262)
                          (1265 . 1264) (1267 . 1266) (1269 . 1268) (1271 . 1270) (1273 . 1272)
                          (1275 . 1274) (1277 . 1276) (1279 . 1278) (1281 . 1280) (1283 . 1282)
                          (1285 . 1284) (1287 . 1286) (1289 . 1288) (1291 . 1290) (1293 . 1292)
                          (1295 . 1294) (1297 . 1296) (1299 . 1298) (1301 . 1300) (1303 . 1302)
                          (1305 . 1304) (1307 . 1306) (1309 . 1308) (1311 . 1310) (1313 . 1312)
                          (1315 . 1314) (1377 . 1329) (1378 . 1330) (1379 . 1331) (1380 . 1332)
                          (1381 . 1333) (1382 . 1334) (1383 . 1335) (1384 . 1336) (1385 . 1337)
                          (1386 . 1338) (1387 . 1339) (1388 . 1340) (1389 . 1341) (1390 . 1342)
                          (1391 . 1343) (1392 . 1344) (1393 . 1345) (1394 . 1346) (1395 . 1347)
                          (1396 . 1348) (1397 . 1349) (1398 . 1350) (1399 . 1351) (1400 . 1352)
                          (1401 . 1353) (1402 . 1354) (1403 . 1355) (1404 . 1356) (1405 . 1357)
                          (1406 . 1358) (1407 . 1359) (1408 . 1360) (1409 . 1361) (1410 . 1362)
                          (1411 . 1363) (1412 . 1364) (1413 . 1365) (1414 . 1366) (7545 . 42877)
                          (7549 . 11363) (7681 . 7680) (7683 . 7682) (7685 . 7684) (7687 . 7686)
                          (7689 . 7688) (7691 . 7690) (7693 . 7692) (7695 . 7694) (7697 . 7696)
                          (7699 . 7698) (7701 . 7700) (7703 . 7702) (7705 . 7704) (7707 . 7706)
                          (7709 . 7708) (7711 . 7710) (7713 . 7712) (7715 . 7714) (7717 . 7716)
                          (7719 . 7718) (7721 . 7720) (7723 . 7722) (7725 . 7724) (7727 . 7726)
                          (7729 . 7728) (7731 . 7730) (7733 . 7732) (7735 . 7734) (7737 . 7736)
                          (7739 . 7738) (7741 . 7740) (7743 . 7742) (7745 . 7744) (7747 . 7746)
                          (7749 . 7748) (7751 . 7750) (7753 . 7752) (7755 . 7754) (7757 . 7756)
                          (7759 . 7758) (7761 . 7760) (7763 . 7762) (7765 . 7764) (7767 . 7766)
                          (7769 . 7768) (7771 . 7770) (7773 . 7772) (7775 . 7774) (7777 . 7776)
                          (7779 . 7778) (7781 . 7780) (7783 . 7782) (7785 . 7784) (7787 . 7786)
                          (7789 . 7788) (7791 . 7790) (7793 . 7792) (7795 . 7794) (7797 . 7796)
                          (7799 . 7798) (7801 . 7800) (7803 . 7802) (7805 . 7804) (7807 . 7806)
                          (7809 . 7808) (7811 . 7810) (7813 . 7812) (7815 . 7814) (7817 . 7816)
                          (7819 . 7818) (7821 . 7820) (7823 . 7822) (7825 . 7824) (7827 . 7826)
                          (7829 . 7828) (7835 . 7776) (7841 . 7840) (7843 . 7842) (7845 . 7844)
                          (7847 . 7846) (7849 . 7848) (7851 . 7850) (7853 . 7852) (7855 . 7854)
                          (7857 . 7856) (7859 . 7858) (7861 . 7860) (7863 . 7862) (7865 . 7864)
                          (7867 . 7866) (7869 . 7868) (7871 . 7870) (7873 . 7872) (7875 . 7874)
                          (7877 . 7876) (7879 . 7878) (7881 . 7880) (7883 . 7882) (7885 . 7884)
                          (7887 . 7886) (7889 . 7888) (7891 . 7890) (7893 . 7892) (7895 . 7894)
                          (7897 . 7896) (7899 . 7898) (7901 . 7900) (7903 . 7902) (7905 . 7904)
                          (7907 . 7906) (7909 . 7908) (7911 . 7910) (7913 . 7912) (7915 . 7914)
                          (7917 . 7916) (7919 . 7918) (7921 . 7920) (7923 . 7922) (7925 . 7924)
                          (7927 . 7926) (7929 . 7928) (7931 . 7930) (7933 . 7932) (7935 . 7934)
                          (7936 . 7944) (7937 . 7945) (7938 . 7946) (7939 . 7947) (7940 . 7948)
                          (7941 . 7949) (7942 . 7950) (7943 . 7951) (7952 . 7960) (7953 . 7961)
                          (7954 . 7962) (7955 . 7963) (7956 . 7964) (7957 . 7965) (7968 . 7976)
                          (7969 . 7977) (7970 . 7978) (7971 . 7979) (7972 . 7980) (7973 . 7981)
                          (7974 . 7982) (7975 . 7983) (7984 . 7992) (7985 . 7993) (7986 . 7994)
                          (7987 . 7995) (7988 . 7996) (7989 . 7997) (7990 . 7998) (7991 . 7999)
                          (8000 . 8008) (8001 . 8009) (8002 . 8010) (8003 . 8011) (8004 . 8012)
                          (8005 . 8013) (8017 . 8025) (8019 . 8027) (8021 . 8029) (8023 . 8031)
                          (8032 . 8040) (8033 . 8041) (8034 . 8042) (8035 . 8043) (8036 . 8044)
                          (8037 . 8045) (8038 . 8046) (8039 . 8047) (8048 . 8122) (8049 . 8123)
                          (8050 . 8136) (8051 . 8137) (8052 . 8138) (8053 . 8139) (8054 . 8154)
                          (8055 . 8155) (8056 . 8184) (8057 . 8185) (8058 . 8170) (8059 . 8171)
                          (8060 . 8186) (8061 . 8187) (8064 . 8072) (8065 . 8073) (8066 . 8074)
                          (8067 . 8075) (8068 . 8076) (8069 . 8077) (8070 . 8078) (8071 . 8079)
                          (8080 . 8088) (8081 . 8089) (8082 . 8090) (8083 . 8091) (8084 . 8092)
                          (8085 . 8093) (8086 . 8094) (8087 . 8095) (8096 . 8104) (8097 . 8105)
                          (8098 . 8106) (8099 . 8107) (8100 . 8108) (8101 . 8109) (8102 . 8110)
                          (8103 . 8111) (8112 . 8120) (8113 . 8121) (8115 . 8124) (8126 . 921)
                          (8131 . 8140) (8144 . 8152) (8145 . 8153) (8160 . 8168) (8161 . 8169)
                          (8165 . 8172) (8179 . 8188) (8526 . 8498) (8560 . 8544) (8561 . 8545)
                          (8562 . 8546) (8563 . 8547) (8564 . 8548) (8565 . 8549) (8566 . 8550)
                          (8567 . 8551) (8568 . 8552) (8569 . 8553) (8570 . 8554) (8571 . 8555)
                          (8572 . 8556) (8573 . 8557) (8574 . 8558) (8575 . 8559) (8580 . 8579)
                          (9424 . 9398) (9425 . 9399) (9426 . 9400) (9427 . 9401) (9428 . 9402)
                          (9429 . 9403) (9430 . 9404) (9431 . 9405) (9432 . 9406) (9433 . 9407)
                          (9434 . 9408) (9435 . 9409) (9436 . 9410) (9437 . 9411) (9438 . 9412)
                          (9439 . 9413) (9440 . 9414) (9441 . 9415) (9442 . 9416) (9443 . 9417)
                          (9444 . 9418) (9445 . 9419) (9446 . 9420) (9447 . 9421) (9448 . 9422)
                          (9449 . 9423) (11312 . 11264) (11313 . 11265) (11314 . 11266) (11315 . 11267)
                          (11316 . 11268) (11317 . 11269) (11318 . 11270) (11319 . 11271) (11320 . 11272)
                          (11321 . 11273) (11322 . 11274) (11323 . 11275) (11324 . 11276) (11325 . 11277)
                          (11326 . 11278) (11327 . 11279) (11328 . 11280) (11329 . 11281) (11330 . 11282)
                          (11331 . 11283) (11332 . 11284) (11333 . 11285) (11334 . 11286) (11335 . 11287)
                          (11336 . 11288) (11337 . 11289) (11338 . 11290) (11339 . 11291) (11340 . 11292)
                          (11341 . 11293) (11342 . 11294) (11343 . 11295) (11344 . 11296) (11345 . 11297)
                          (11346 . 11298) (11347 . 11299) (11348 . 11300) (11349 . 11301) (11350 . 11302)
                          (11351 . 11303) (11352 . 11304) (11353 . 11305) (11354 . 11306) (11355 . 11307)
                          (11356 . 11308) (11357 . 11309) (11358 . 11310) (11361 . 11360) (11365 . 570)
                          (11366 . 574) (11368 . 11367) (11370 . 11369) (11372 . 11371) (11379 . 11378)
                          (11382 . 11381) (11393 . 11392) (11395 . 11394) (11397 . 11396) (11399 . 11398)
                          (11401 . 11400) (11403 . 11402) (11405 . 11404) (11407 . 11406) (11409 . 11408)
                          (11411 . 11410) (11413 . 11412) (11415 . 11414) (11417 . 11416) (11419 . 11418)
                          (11421 . 11420) (11423 . 11422) (11425 . 11424) (11427 . 11426) (11429 . 11428)
                          (11431 . 11430) (11433 . 11432) (11435 . 11434) (11437 . 11436) (11439 . 11438)
                          (11441 . 11440) (11443 . 11442) (11445 . 11444) (11447 . 11446) (11449 . 11448)
                          (11451 . 11450) (11453 . 11452) (11455 . 11454) (11457 . 11456) (11459 . 11458)
                          (11461 . 11460) (11463 . 11462) (11465 . 11464) (11467 . 11466) (11469 . 11468)
                          (11471 . 11470) (11473 . 11472) (11475 . 11474) (11477 . 11476) (11479 . 11478)
                          (11481 . 11480) (11483 . 11482) (11485 . 11484) (11487 . 11486) (11489 . 11488)
                          (11491 . 11490) (11520 . 4256) (11521 . 4257) (11522 . 4258) (11523 . 4259)
                          (11524 . 4260) (11525 . 4261) (11526 . 4262) (11527 . 4263) (11528 . 4264)
                          (11529 . 4265) (11530 . 4266) (11531 . 4267) (11532 . 4268) (11533 . 4269)
                          (11534 . 4270) (11535 . 4271) (11536 . 4272) (11537 . 4273) (11538 . 4274)
                          (11539 . 4275) (11540 . 4276) (11541 . 4277) (11542 . 4278) (11543 . 4279)
                          (11544 . 4280) (11545 . 4281) (11546 . 4282) (11547 . 4283) (11548 . 4284)
                          (11549 . 4285) (11550 . 4286) (11551 . 4287) (11552 . 4288) (11553 . 4289)
                          (11554 . 4290) (11555 . 4291) (11556 . 4292) (11557 . 4293) (42561 . 42560)
                          (42563 . 42562) (42565 . 42564) (42567 . 42566) (42569 . 42568) (42571 . 42570)
                          (42573 . 42572) (42575 . 42574) (42577 . 42576) (42579 . 42578) (42581 . 42580)
                          (42583 . 42582) (42585 . 42584) (42587 . 42586) (42589 . 42588) (42591 . 42590)
                          (42595 . 42594) (42597 . 42596) (42599 . 42598) (42601 . 42600) (42603 . 42602)
                          (42605 . 42604) (42625 . 42624) (42627 . 42626) (42629 . 42628) (42631 . 42630)
                          (42633 . 42632) (42635 . 42634) (42637 . 42636) (42639 . 42638) (42641 . 42640)
                          (42643 . 42642) (42645 . 42644) (42647 . 42646) (42787 . 42786) (42789 . 42788)
                          (42791 . 42790) (42793 . 42792) (42795 . 42794) (42797 . 42796) (42799 . 42798)
                          (42803 . 42802) (42805 . 42804) (42807 . 42806) (42809 . 42808) (42811 . 42810)
                          (42813 . 42812) (42815 . 42814) (42817 . 42816) (42819 . 42818) (42821 . 42820)
                          (42823 . 42822) (42825 . 42824) (42827 . 42826) (42829 . 42828) (42831 . 42830)
                          (42833 . 42832) (42835 . 42834) (42837 . 42836) (42839 . 42838) (42841 . 42840)
                          (42843 . 42842) (42845 . 42844) (42847 . 42846) (42849 . 42848) (42851 . 42850)
                          (42853 . 42852) (42855 . 42854) (42857 . 42856) (42859 . 42858) (42861 . 42860)
                          (42863 . 42862) (42874 . 42873) (42876 . 42875) (42879 . 42878) (42881 . 42880)
                          (42883 . 42882) (42885 . 42884) (42887 . 42886) (42892 . 42891) (65345 . 65313)
                          (65346 . 65314) (65347 . 65315) (65348 . 65316) (65349 . 65317) (65350 . 65318)
                          (65351 . 65319) (65352 . 65320) (65353 . 65321) (65354 . 65322) (65355 . 65323)
                          (65356 . 65324) (65357 . 65325) (65358 . 65326) (65359 . 65327) (65360 . 65328)
                          (65361 . 65329) (65362 . 65330) (65363 . 65331) (65364 . 65332) (65365 . 65333)
                          (65366 . 65334) (65367 . 65335) (65368 . 65336) (65369 . 65337) (65370 . 65338)
                          (66600 . 66560) (66601 . 66561) (66602 . 66562) (66603 . 66563) (66604 . 66564)
                          (66605 . 66565) (66606 . 66566) (66607 . 66567) (66608 . 66568) (66609 . 66569)
                          (66610 . 66570) (66611 . 66571) (66612 . 66572) (66613 . 66573) (66614 . 66574)
                          (66615 . 66575) (66616 . 66576) (66617 . 66577) (66618 . 66578) (66619 . 66579)
                          (66620 . 66580) (66621 . 66581) (66622 . 66582) (66623 . 66583) (66624 . 66584)
                          (66625 . 66585) (66626 . 66586) (66627 . 66587) (66628 . 66588) (66629 . 66589)
                          (66630 . 66590) (66631 . 66591) (66632 . 66592) (66633 . 66593) (66634 . 66594)
                          (66635 . 66595) (66636 . 66596) (66637 . 66597) (66638 . 66598) (66639 . 66599)))
(define downcase-alist '(
                         (65 . 97) (66 . 98) (67 . 99) (68 . 100) (69 . 101)
                         (70 . 102) (71 . 103) (72 . 104) (73 . 105) (74 . 106)
                         (75 . 107) (76 . 108) (77 . 109) (78 . 110) (79 . 111)
                         (80 . 112) (81 . 113) (82 . 114) (83 . 115) (84 . 116)
                         (85 . 117) (86 . 118) (87 . 119) (88 . 120) (89 . 121)
                         (90 . 122) (192 . 224) (193 . 225) (194 . 226) (195 . 227)
                         (196 . 228) (197 . 229) (198 . 230) (199 . 231) (200 . 232)
                         (201 . 233) (202 . 234) (203 . 235) (204 . 236) (205 . 237)
                         (206 . 238) (207 . 239) (208 . 240) (209 . 241) (210 . 242)
                         (211 . 243) (212 . 244) (213 . 245) (214 . 246) (216 . 248)
                         (217 . 249) (218 . 250) (219 . 251) (220 . 252) (221 . 253)
                         (222 . 254) (256 . 257) (258 . 259) (260 . 261) (262 . 263)
                         (264 . 265) (266 . 267) (268 . 269) (270 . 271) (272 . 273)
                         (274 . 275) (276 . 277) (278 . 279) (280 . 281) (282 . 283)
                         (284 . 285) (286 . 287) (288 . 289) (290 . 291) (292 . 293)
                         (294 . 295) (296 . 297) (298 . 299) (300 . 301) (302 . 303)
                         (304 . 105) (306 . 307) (308 . 309) (310 . 311) (313 . 314)
                         (315 . 316) (317 . 318) (319 . 320) (321 . 322) (323 . 324)
                         (325 . 326) (327 . 328) (330 . 331) (332 . 333) (334 . 335)
                         (336 . 337) (338 . 339) (340 . 341) (342 . 343) (344 . 345)
                         (346 . 347) (348 . 349) (350 . 351) (352 . 353) (354 . 355)
                         (356 . 357) (358 . 359) (360 . 361) (362 . 363) (364 . 365)
                         (366 . 367) (368 . 369) (370 . 371) (372 . 373) (374 . 375)
                         (376 . 255) (377 . 378) (379 . 380) (381 . 382) (385 . 595)
                         (386 . 387) (388 . 389) (390 . 596) (391 . 392) (393 . 598)
                         (394 . 599) (395 . 396) (398 . 477) (399 . 601) (400 . 603)
                         (401 . 402) (403 . 608) (404 . 611) (406 . 617) (407 . 616)
                         (408 . 409) (412 . 623) (413 . 626) (415 . 629) (416 . 417)
                         (418 . 419) (420 . 421) (422 . 640) (423 . 424) (425 . 643)
                         (428 . 429) (430 . 648) (431 . 432) (433 . 650) (434 . 651)
                         (435 . 436) (437 . 438) (439 . 658) (440 . 441) (444 . 445)
                         (452 . 454) (453 . 454) (455 . 457) (456 . 457) (458 . 460)
                         (459 . 460) (461 . 462) (463 . 464) (465 . 466) (467 . 468)
                         (469 . 470) (471 . 472) (473 . 474) (475 . 476) (478 . 479)
                         (480 . 481) (482 . 483) (484 . 485) (486 . 487) (488 . 489)
                         (490 . 491) (492 . 493) (494 . 495) (497 . 499) (498 . 499)
                         (500 . 501) (502 . 405) (503 . 447) (504 . 505) (506 . 507)
                         (508 . 509) (510 . 511) (512 . 513) (514 . 515) (516 . 517)
                         (518 . 519) (520 . 521) (522 . 523) (524 . 525) (526 . 527)
                         (528 . 529) (530 . 531) (532 . 533) (534 . 535) (536 . 537)
                         (538 . 539) (540 . 541) (542 . 543) (544 . 414) (546 . 547)
                         (548 . 549) (550 . 551) (552 . 553) (554 . 555) (556 . 557)
                         (558 . 559) (560 . 561) (562 . 563) (570 . 11365) (571 . 572)
                         (573 . 410) (574 . 11366) (577 . 578) (579 . 384) (580 . 649)
                         (581 . 652) (582 . 583) (584 . 585) (586 . 587) (588 . 589)
                         (590 . 591) (880 . 881) (882 . 883) (886 . 887) (902 . 940)
                         (904 . 941) (905 . 942) (906 . 943) (908 . 972) (910 . 973)
                         (911 . 974) (913 . 945) (914 . 946) (915 . 947) (916 . 948)
                         (917 . 949) (918 . 950) (919 . 951) (920 . 952) (921 . 953)
                         (922 . 954) (923 . 955) (924 . 956) (925 . 957) (926 . 958)
                         (927 . 959) (928 . 960) (929 . 961) (931 . 963) (932 . 964)
                         (933 . 965) (934 . 966) (935 . 967) (936 . 968) (937 . 969)
                         (938 . 970) (939 . 971) (975 . 983) (984 . 985) (986 . 987)
                         (988 . 989) (990 . 991) (992 . 993) (994 . 995) (996 . 997)
                         (998 . 999) (1000 . 1001) (1002 . 1003) (1004 . 1005) (1006 . 1007)
                         (1012 . 952) (1015 . 1016) (1017 . 1010) (1018 . 1019) (1021 . 891)
                         (1022 . 892) (1023 . 893) (1024 . 1104) (1025 . 1105) (1026 . 1106)
                         (1027 . 1107) (1028 . 1108) (1029 . 1109) (1030 . 1110) (1031 . 1111)
                         (1032 . 1112) (1033 . 1113) (1034 . 1114) (1035 . 1115) (1036 . 1116)
                         (1037 . 1117) (1038 . 1118) (1039 . 1119) (1040 . 1072) (1041 . 1073)
                         (1042 . 1074) (1043 . 1075) (1044 . 1076) (1045 . 1077) (1046 . 1078)
                         (1047 . 1079) (1048 . 1080) (1049 . 1081) (1050 . 1082) (1051 . 1083)
                         (1052 . 1084) (1053 . 1085) (1054 . 1086) (1055 . 1087) (1056 . 1088)
                         (1057 . 1089) (1058 . 1090) (1059 . 1091) (1060 . 1092) (1061 . 1093)
                         (1062 . 1094) (1063 . 1095) (1064 . 1096) (1065 . 1097) (1066 . 1098)
                         (1067 . 1099) (1068 . 1100) (1069 . 1101) (1070 . 1102) (1071 . 1103)
                         (1120 . 1121) (1122 . 1123) (1124 . 1125) (1126 . 1127) (1128 . 1129)
                         (1130 . 1131) (1132 . 1133) (1134 . 1135) (1136 . 1137) (1138 . 1139)
                         (1140 . 1141) (1142 . 1143) (1144 . 1145) (1146 . 1147) (1148 . 1149)
                         (1150 . 1151) (1152 . 1153) (1162 . 1163) (1164 . 1165) (1166 . 1167)
                         (1168 . 1169) (1170 . 1171) (1172 . 1173) (1174 . 1175) (1176 . 1177)
                         (1178 . 1179) (1180 . 1181) (1182 . 1183) (1184 . 1185) (1186 . 1187)
                         (1188 . 1189) (1190 . 1191) (1192 . 1193) (1194 . 1195) (1196 . 1197)
                         (1198 . 1199) (1200 . 1201) (1202 . 1203) (1204 . 1205) (1206 . 1207)
                         (1208 . 1209) (1210 . 1211) (1212 . 1213) (1214 . 1215) (1216 . 1231)
                         (1217 . 1218) (1219 . 1220) (1221 . 1222) (1223 . 1224) (1225 . 1226)
                         (1227 . 1228) (1229 . 1230) (1232 . 1233) (1234 . 1235) (1236 . 1237)
                         (1238 . 1239) (1240 . 1241) (1242 . 1243) (1244 . 1245) (1246 . 1247)
                         (1248 . 1249) (1250 . 1251) (1252 . 1253) (1254 . 1255) (1256 . 1257)
                         (1258 . 1259) (1260 . 1261) (1262 . 1263) (1264 . 1265) (1266 . 1267)
                         (1268 . 1269) (1270 . 1271) (1272 . 1273) (1274 . 1275) (1276 . 1277)
                         (1278 . 1279) (1280 . 1281) (1282 . 1283) (1284 . 1285) (1286 . 1287)
                         (1288 . 1289) (1290 . 1291) (1292 . 1293) (1294 . 1295) (1296 . 1297)
                         (1298 . 1299) (1300 . 1301) (1302 . 1303) (1304 . 1305) (1306 . 1307)
                         (1308 . 1309) (1310 . 1311) (1312 . 1313) (1314 . 1315) (1329 . 1377)
                         (1330 . 1378) (1331 . 1379) (1332 . 1380) (1333 . 1381) (1334 . 1382)
                         (1335 . 1383) (1336 . 1384) (1337 . 1385) (1338 . 1386) (1339 . 1387)
                         (1340 . 1388) (1341 . 1389) (1342 . 1390) (1343 . 1391) (1344 . 1392)
                         (1345 . 1393) (1346 . 1394) (1347 . 1395) (1348 . 1396) (1349 . 1397)
                         (1350 . 1398) (1351 . 1399) (1352 . 1400) (1353 . 1401) (1354 . 1402)
                         (1355 . 1403) (1356 . 1404) (1357 . 1405) (1358 . 1406) (1359 . 1407)
                         (1360 . 1408) (1361 . 1409) (1362 . 1410) (1363 . 1411) (1364 . 1412)
                         (1365 . 1413) (1366 . 1414) (4256 . 11520) (4257 . 11521) (4258 . 11522)
                         (4259 . 11523) (4260 . 11524) (4261 . 11525) (4262 . 11526) (4263 . 11527)
                         (4264 . 11528) (4265 . 11529) (4266 . 11530) (4267 . 11531) (4268 . 11532)
                         (4269 . 11533) (4270 . 11534) (4271 . 11535) (4272 . 11536) (4273 . 11537)
                         (4274 . 11538) (4275 . 11539) (4276 . 11540) (4277 . 11541) (4278 . 11542)
                         (4279 . 11543) (4280 . 11544) (4281 . 11545) (4282 . 11546) (4283 . 11547)
                         (4284 . 11548) (4285 . 11549) (4286 . 11550) (4287 . 11551) (4288 . 11552)
                         (4289 . 11553) (4290 . 11554) (4291 . 11555) (4292 . 11556) (4293 . 11557)
                         (7680 . 7681) (7682 . 7683) (7684 . 7685) (7686 . 7687) (7688 . 7689)
                         (7690 . 7691) (7692 . 7693) (7694 . 7695) (7696 . 7697) (7698 . 7699)
                         (7700 . 7701) (7702 . 7703) (7704 . 7705) (7706 . 7707) (7708 . 7709)
                         (7710 . 7711) (7712 . 7713) (7714 . 7715) (7716 . 7717) (7718 . 7719)
                         (7720 . 7721) (7722 . 7723) (7724 . 7725) (7726 . 7727) (7728 . 7729)
                         (7730 . 7731) (7732 . 7733) (7734 . 7735) (7736 . 7737) (7738 . 7739)
                         (7740 . 7741) (7742 . 7743) (7744 . 7745) (7746 . 7747) (7748 . 7749)
                         (7750 . 7751) (7752 . 7753) (7754 . 7755) (7756 . 7757) (7758 . 7759)
                         (7760 . 7761) (7762 . 7763) (7764 . 7765) (7766 . 7767) (7768 . 7769)
                         (7770 . 7771) (7772 . 7773) (7774 . 7775) (7776 . 7777) (7778 . 7779)
                         (7780 . 7781) (7782 . 7783) (7784 . 7785) (7786 . 7787) (7788 . 7789)
                         (7790 . 7791) (7792 . 7793) (7794 . 7795) (7796 . 7797) (7798 . 7799)
                         (7800 . 7801) (7802 . 7803) (7804 . 7805) (7806 . 7807) (7808 . 7809)
                         (7810 . 7811) (7812 . 7813) (7814 . 7815) (7816 . 7817) (7818 . 7819)
                         (7820 . 7821) (7822 . 7823) (7824 . 7825) (7826 . 7827) (7828 . 7829)
                         (7838 . 223) (7840 . 7841) (7842 . 7843) (7844 . 7845) (7846 . 7847)
                         (7848 . 7849) (7850 . 7851) (7852 . 7853) (7854 . 7855) (7856 . 7857)
                         (7858 . 7859) (7860 . 7861) (7862 . 7863) (7864 . 7865) (7866 . 7867)
                         (7868 . 7869) (7870 . 7871) (7872 . 7873) (7874 . 7875) (7876 . 7877)
                         (7878 . 7879) (7880 . 7881) (7882 . 7883) (7884 . 7885) (7886 . 7887)
                         (7888 . 7889) (7890 . 7891) (7892 . 7893) (7894 . 7895) (7896 . 7897)
                         (7898 . 7899) (7900 . 7901) (7902 . 7903) (7904 . 7905) (7906 . 7907)
                         (7908 . 7909) (7910 . 7911) (7912 . 7913) (7914 . 7915) (7916 . 7917)
                         (7918 . 7919) (7920 . 7921) (7922 . 7923) (7924 . 7925) (7926 . 7927)
                         (7928 . 7929) (7930 . 7931) (7932 . 7933) (7934 . 7935) (7944 . 7936)
                         (7945 . 7937) (7946 . 7938) (7947 . 7939) (7948 . 7940) (7949 . 7941)
                         (7950 . 7942) (7951 . 7943) (7960 . 7952) (7961 . 7953) (7962 . 7954)
                         (7963 . 7955) (7964 . 7956) (7965 . 7957) (7976 . 7968) (7977 . 7969)
                         (7978 . 7970) (7979 . 7971) (7980 . 7972) (7981 . 7973) (7982 . 7974)
                         (7983 . 7975) (7992 . 7984) (7993 . 7985) (7994 . 7986) (7995 . 7987)
                         (7996 . 7988) (7997 . 7989) (7998 . 7990) (7999 . 7991) (8008 . 8000)
                         (8009 . 8001) (8010 . 8002) (8011 . 8003) (8012 . 8004) (8013 . 8005)
                         (8025 . 8017) (8027 . 8019) (8029 . 8021) (8031 . 8023) (8040 . 8032)
                         (8041 . 8033) (8042 . 8034) (8043 . 8035) (8044 . 8036) (8045 . 8037)
                         (8046 . 8038) (8047 . 8039) (8072 . 8064) (8073 . 8065) (8074 . 8066)
                         (8075 . 8067) (8076 . 8068) (8077 . 8069) (8078 . 8070) (8079 . 8071)
                         (8088 . 8080) (8089 . 8081) (8090 . 8082) (8091 . 8083) (8092 . 8084)
                         (8093 . 8085) (8094 . 8086) (8095 . 8087) (8104 . 8096) (8105 . 8097)
                         (8106 . 8098) (8107 . 8099) (8108 . 8100) (8109 . 8101) (8110 . 8102)
                         (8111 . 8103) (8120 . 8112) (8121 . 8113) (8122 . 8048) (8123 . 8049)
                         (8124 . 8115) (8136 . 8050) (8137 . 8051) (8138 . 8052) (8139 . 8053)
                         (8140 . 8131) (8152 . 8144) (8153 . 8145) (8154 . 8054) (8155 . 8055)
                         (8168 . 8160) (8169 . 8161) (8170 . 8058) (8171 . 8059) (8172 . 8165)
                         (8184 . 8056) (8185 . 8057) (8186 . 8060) (8187 . 8061) (8188 . 8179)
                         (8486 . 969) (8490 . 107) (8491 . 229) (8498 . 8526) (8544 . 8560)
                         (8545 . 8561) (8546 . 8562) (8547 . 8563) (8548 . 8564) (8549 . 8565)
                         (8550 . 8566) (8551 . 8567) (8552 . 8568) (8553 . 8569) (8554 . 8570)
                         (8555 . 8571) (8556 . 8572) (8557 . 8573) (8558 . 8574) (8559 . 8575)
                         (8579 . 8580) (9398 . 9424) (9399 . 9425) (9400 . 9426) (9401 . 9427)
                         (9402 . 9428) (9403 . 9429) (9404 . 9430) (9405 . 9431) (9406 . 9432)
                         (9407 . 9433) (9408 . 9434) (9409 . 9435) (9410 . 9436) (9411 . 9437)
                         (9412 . 9438) (9413 . 9439) (9414 . 9440) (9415 . 9441) (9416 . 9442)
                         (9417 . 9443) (9418 . 9444) (9419 . 9445) (9420 . 9446) (9421 . 9447)
                         (9422 . 9448) (9423 . 9449) (11264 . 11312) (11265 . 11313) (11266 . 11314)
                         (11267 . 11315) (11268 . 11316) (11269 . 11317) (11270 . 11318) (11271 . 11319)
                         (11272 . 11320) (11273 . 11321) (11274 . 11322) (11275 . 11323) (11276 . 11324)
                         (11277 . 11325) (11278 . 11326) (11279 . 11327) (11280 . 11328) (11281 . 11329)
                         (11282 . 11330) (11283 . 11331) (11284 . 11332) (11285 . 11333) (11286 . 11334)
                         (11287 . 11335) (11288 . 11336) (11289 . 11337) (11290 . 11338) (11291 . 11339)
                         (11292 . 11340) (11293 . 11341) (11294 . 11342) (11295 . 11343) (11296 . 11344)
                         (11297 . 11345) (11298 . 11346) (11299 . 11347) (11300 . 11348) (11301 . 11349)
                         (11302 . 11350) (11303 . 11351) (11304 . 11352) (11305 . 11353) (11306 . 11354)
                         (11307 . 11355) (11308 . 11356) (11309 . 11357) (11310 . 11358) (11360 . 11361)
                         (11362 . 619) (11363 . 7549) (11364 . 637) (11367 . 11368) (11369 . 11370)
                         (11371 . 11372) (11373 . 593) (11374 . 625) (11375 . 592) (11378 . 11379)
                         (11381 . 11382) (11392 . 11393) (11394 . 11395) (11396 . 11397) (11398 . 11399)
                         (11400 . 11401) (11402 . 11403) (11404 . 11405) (11406 . 11407) (11408 . 11409)
                         (11410 . 11411) (11412 . 11413) (11414 . 11415) (11416 . 11417) (11418 . 11419)
                         (11420 . 11421) (11422 . 11423) (11424 . 11425) (11426 . 11427) (11428 . 11429)
                         (11430 . 11431) (11432 . 11433) (11434 . 11435) (11436 . 11437) (11438 . 11439)
                         (11440 . 11441) (11442 . 11443) (11444 . 11445) (11446 . 11447) (11448 . 11449)
                         (11450 . 11451) (11452 . 11453) (11454 . 11455) (11456 . 11457) (11458 . 11459)
                         (11460 . 11461) (11462 . 11463) (11464 . 11465) (11466 . 11467) (11468 . 11469)
                         (11470 . 11471) (11472 . 11473) (11474 . 11475) (11476 . 11477) (11478 . 11479)
                         (11480 . 11481) (11482 . 11483) (11484 . 11485) (11486 . 11487) (11488 . 11489)
                         (11490 . 11491) (42560 . 42561) (42562 . 42563) (42564 . 42565) (42566 . 42567)
                         (42568 . 42569) (42570 . 42571) (42572 . 42573) (42574 . 42575) (42576 . 42577)
                         (42578 . 42579) (42580 . 42581) (42582 . 42583) (42584 . 42585) (42586 . 42587)
                         (42588 . 42589) (42590 . 42591) (42594 . 42595) (42596 . 42597) (42598 . 42599)
                         (42600 . 42601) (42602 . 42603) (42604 . 42605) (42624 . 42625) (42626 . 42627)
                         (42628 . 42629) (42630 . 42631) (42632 . 42633) (42634 . 42635) (42636 . 42637)
                         (42638 . 42639) (42640 . 42641) (42642 . 42643) (42644 . 42645) (42646 . 42647)
                         (42786 . 42787) (42788 . 42789) (42790 . 42791) (42792 . 42793) (42794 . 42795)
                         (42796 . 42797) (42798 . 42799) (42802 . 42803) (42804 . 42805) (42806 . 42807)
                         (42808 . 42809) (42810 . 42811) (42812 . 42813) (42814 . 42815) (42816 . 42817)
                         (42818 . 42819) (42820 . 42821) (42822 . 42823) (42824 . 42825) (42826 . 42827)
                         (42828 . 42829) (42830 . 42831) (42832 . 42833) (42834 . 42835) (42836 . 42837)
                         (42838 . 42839) (42840 . 42841) (42842 . 42843) (42844 . 42845) (42846 . 42847)
                         (42848 . 42849) (42850 . 42851) (42852 . 42853) (42854 . 42855) (42856 . 42857)
                         (42858 . 42859) (42860 . 42861) (42862 . 42863) (42873 . 42874) (42875 . 42876)
                         (42877 . 7545) (42878 . 42879) (42880 . 42881) (42882 . 42883) (42884 . 42885)
                         (42886 . 42887) (42891 . 42892) (65313 . 65345) (65314 . 65346) (65315 . 65347)
                         (65316 . 65348) (65317 . 65349) (65318 . 65350) (65319 . 65351) (65320 . 65352)
                         (65321 . 65353) (65322 . 65354) (65323 . 65355) (65324 . 65356) (65325 . 65357)
                         (65326 . 65358) (65327 . 65359) (65328 . 65360) (65329 . 65361) (65330 . 65362)
                         (65331 . 65363) (65332 . 65364) (65333 . 65365) (65334 . 65366) (65335 . 65367)
                         (65336 . 65368) (65337 . 65369) (65338 . 65370) (66560 . 66600) (66561 . 66601)
                         (66562 . 66602) (66563 . 66603) (66564 . 66604) (66565 . 66605) (66566 . 66606)
                         (66567 . 66607) (66568 . 66608) (66569 . 66609) (66570 . 66610) (66571 . 66611)
                         (66572 . 66612) (66573 . 66613) (66574 . 66614) (66575 . 66615) (66576 . 66616)
                         (66577 . 66617) (66578 . 66618) (66579 . 66619) (66580 . 66620) (66581 . 66621)
                         (66582 . 66622) (66583 . 66623) (66584 . 66624) (66585 . 66625) (66586 . 66626)
                         (66587 . 66627) (66588 . 66628) (66589 . 66629) (66590 . 66630) (66591 . 66631)
                         (66592 . 66632) (66593 . 66633) (66594 . 66634) (66595 . 66635) (66596 . 66636)
                         (66597 . 66637) (66598 . 66638) (66599 . 66639)))
(define upcase-alist '(
                       (97 . 65) (98 . 66) (99 . 67) (100 . 68) (101 . 69)
                       (102 . 70) (103 . 71) (104 . 72) (105 . 73) (106 . 74)
                       (107 . 75) (108 . 76) (109 . 77) (110 . 78) (111 . 79)
                       (112 . 80) (113 . 81) (114 . 82) (115 . 83) (116 . 84)
                       (117 . 85) (118 . 86) (119 . 87) (120 . 88) (121 . 89)
                       (122 . 90) (181 . 924) (224 . 192) (225 . 193) (226 . 194)
                       (227 . 195) (228 . 196) (229 . 197) (230 . 198) (231 . 199)
                       (232 . 200) (233 . 201) (234 . 202) (235 . 203) (236 . 204)
                       (237 . 205) (238 . 206) (239 . 207) (240 . 208) (241 . 209)
                       (242 . 210) (243 . 211) (244 . 212) (245 . 213) (246 . 214)
                       (248 . 216) (249 . 217) (250 . 218) (251 . 219) (252 . 220)
                       (253 . 221) (254 . 222) (255 . 376) (257 . 256) (259 . 258)
                       (261 . 260) (263 . 262) (265 . 264) (267 . 266) (269 . 268)
                       (271 . 270) (273 . 272) (275 . 274) (277 . 276) (279 . 278)
                       (281 . 280) (283 . 282) (285 . 284) (287 . 286) (289 . 288)
                       (291 . 290) (293 . 292) (295 . 294) (297 . 296) (299 . 298)
                       (301 . 300) (303 . 302) (305 . 73) (307 . 306) (309 . 308)
                       (311 . 310) (314 . 313) (316 . 315) (318 . 317) (320 . 319)
                       (322 . 321) (324 . 323) (326 . 325) (328 . 327) (331 . 330)
                       (333 . 332) (335 . 334) (337 . 336) (339 . 338) (341 . 340)
                       (343 . 342) (345 . 344) (347 . 346) (349 . 348) (351 . 350)
                       (353 . 352) (355 . 354) (357 . 356) (359 . 358) (361 . 360)
                       (363 . 362) (365 . 364) (367 . 366) (369 . 368) (371 . 370)
                       (373 . 372) (375 . 374) (378 . 377) (380 . 379) (382 . 381)
                       (383 . 83) (384 . 579) (387 . 386) (389 . 388) (392 . 391)
                       (396 . 395) (402 . 401) (405 . 502) (409 . 408) (410 . 573)
                       (414 . 544) (417 . 416) (419 . 418) (421 . 420) (424 . 423)
                       (429 . 428) (432 . 431) (436 . 435) (438 . 437) (441 . 440)
                       (445 . 444) (447 . 503) (453 . 452) (454 . 452) (456 . 455)
                       (457 . 455) (459 . 458) (460 . 458) (462 . 461) (464 . 463)
                       (466 . 465) (468 . 467) (470 . 469) (472 . 471) (474 . 473)
                       (476 . 475) (477 . 398) (479 . 478) (481 . 480) (483 . 482)
                       (485 . 484) (487 . 486) (489 . 488) (491 . 490) (493 . 492)
                       (495 . 494) (498 . 497) (499 . 497) (501 . 500) (505 . 504)
                       (507 . 506) (509 . 508) (511 . 510) (513 . 512) (515 . 514)
                       (517 . 516) (519 . 518) (521 . 520) (523 . 522) (525 . 524)
                       (527 . 526) (529 . 528) (531 . 530) (533 . 532) (535 . 534)
                       (537 . 536) (539 . 538) (541 . 540) (543 . 542) (547 . 546)
                       (549 . 548) (551 . 550) (553 . 552) (555 . 554) (557 . 556)
                       (559 . 558) (561 . 560) (563 . 562) (572 . 571) (578 . 577)
                       (583 . 582) (585 . 584) (587 . 586) (589 . 588) (591 . 590)
                       (592 . 11375) (593 . 11373) (595 . 385) (596 . 390) (598 . 393)
                       (599 . 394) (601 . 399) (603 . 400) (608 . 403) (611 . 404)
                       (616 . 407) (617 . 406) (619 . 11362) (623 . 412) (625 . 11374)
                       (626 . 413) (629 . 415) (637 . 11364) (640 . 422) (643 . 425)
                       (648 . 430) (649 . 580) (650 . 433) (651 . 434) (652 . 581)
                       (658 . 439) (837 . 921) (881 . 880) (883 . 882) (887 . 886)
                       (891 . 1021) (892 . 1022) (893 . 1023) (940 . 902) (941 . 904)
                       (942 . 905) (943 . 906) (945 . 913) (946 . 914) (947 . 915)
                       (948 . 916) (949 . 917) (950 . 918) (951 . 919) (952 . 920)
                       (953 . 921) (954 . 922) (955 . 923) (956 . 924) (957 . 925)
                       (958 . 926) (959 . 927) (960 . 928) (961 . 929) (962 . 931)
                       (963 . 931) (964 . 932) (965 . 933) (966 . 934) (967 . 935)
                       (968 . 936) (969 . 937) (970 . 938) (971 . 939) (972 . 908)
                       (973 . 910) (974 . 911) (976 . 914) (977 . 920) (981 . 934)
                       (982 . 928) (983 . 975) (985 . 984) (987 . 986) (989 . 988)
                       (991 . 990) (993 . 992) (995 . 994) (997 . 996) (999 . 998)
                       (1001 . 1000) (1003 . 1002) (1005 . 1004) (1007 . 1006) (1008 . 922)
                       (1009 . 929) (1010 . 1017) (1013 . 917) (1016 . 1015) (1019 . 1018)
                       (1072 . 1040) (1073 . 1041) (1074 . 1042) (1075 . 1043) (1076 . 1044)
                       (1077 . 1045) (1078 . 1046) (1079 . 1047) (1080 . 1048) (1081 . 1049)
                       (1082 . 1050) (1083 . 1051) (1084 . 1052) (1085 . 1053) (1086 . 1054)
                       (1087 . 1055) (1088 . 1056) (1089 . 1057) (1090 . 1058) (1091 . 1059)
                       (1092 . 1060) (1093 . 1061) (1094 . 1062) (1095 . 1063) (1096 . 1064)
                       (1097 . 1065) (1098 . 1066) (1099 . 1067) (1100 . 1068) (1101 . 1069)
                       (1102 . 1070) (1103 . 1071) (1104 . 1024) (1105 . 1025) (1106 . 1026)
                       (1107 . 1027) (1108 . 1028) (1109 . 1029) (1110 . 1030) (1111 . 1031)
                       (1112 . 1032) (1113 . 1033) (1114 . 1034) (1115 . 1035) (1116 . 1036)
                       (1117 . 1037) (1118 . 1038) (1119 . 1039) (1121 . 1120) (1123 . 1122)
                       (1125 . 1124) (1127 . 1126) (1129 . 1128) (1131 . 1130) (1133 . 1132)
                       (1135 . 1134) (1137 . 1136) (1139 . 1138) (1141 . 1140) (1143 . 1142)
                       (1145 . 1144) (1147 . 1146) (1149 . 1148) (1151 . 1150) (1153 . 1152)
                       (1163 . 1162) (1165 . 1164) (1167 . 1166) (1169 . 1168) (1171 . 1170)
                       (1173 . 1172) (1175 . 1174) (1177 . 1176) (1179 . 1178) (1181 . 1180)
                       (1183 . 1182) (1185 . 1184) (1187 . 1186) (1189 . 1188) (1191 . 1190)
                       (1193 . 1192) (1195 . 1194) (1197 . 1196) (1199 . 1198) (1201 . 1200)
                       (1203 . 1202) (1205 . 1204) (1207 . 1206) (1209 . 1208) (1211 . 1210)
                       (1213 . 1212) (1215 . 1214) (1218 . 1217) (1220 . 1219) (1222 . 1221)
                       (1224 . 1223) (1226 . 1225) (1228 . 1227) (1230 . 1229) (1231 . 1216)
                       (1233 . 1232) (1235 . 1234) (1237 . 1236) (1239 . 1238) (1241 . 1240)
                       (1243 . 1242) (1245 . 1244) (1247 . 1246) (1249 . 1248) (1251 . 1250)
                       (1253 . 1252) (1255 . 1254) (1257 . 1256) (1259 . 1258) (1261 . 1260)
                       (1263 . 1262) (1265 . 1264) (1267 . 1266) (1269 . 1268) (1271 . 1270)
                       (1273 . 1272) (1275 . 1274) (1277 . 1276) (1279 . 1278) (1281 . 1280)
                       (1283 . 1282) (1285 . 1284) (1287 . 1286) (1289 . 1288) (1291 . 1290)
                       (1293 . 1292) (1295 . 1294) (1297 . 1296) (1299 . 1298) (1301 . 1300)
                       (1303 . 1302) (1305 . 1304) (1307 . 1306) (1309 . 1308) (1311 . 1310)
                       (1313 . 1312) (1315 . 1314) (1377 . 1329) (1378 . 1330) (1379 . 1331)
                       (1380 . 1332) (1381 . 1333) (1382 . 1334) (1383 . 1335) (1384 . 1336)
                       (1385 . 1337) (1386 . 1338) (1387 . 1339) (1388 . 1340) (1389 . 1341)
                       (1390 . 1342) (1391 . 1343) (1392 . 1344) (1393 . 1345) (1394 . 1346)
                       (1395 . 1347) (1396 . 1348) (1397 . 1349) (1398 . 1350) (1399 . 1351)
                       (1400 . 1352) (1401 . 1353) (1402 . 1354) (1403 . 1355) (1404 . 1356)
                       (1405 . 1357) (1406 . 1358) (1407 . 1359) (1408 . 1360) (1409 . 1361)
                       (1410 . 1362) (1411 . 1363) (1412 . 1364) (1413 . 1365) (1414 . 1366)
                       (7545 . 42877) (7549 . 11363) (7681 . 7680) (7683 . 7682) (7685 . 7684)
                       (7687 . 7686) (7689 . 7688) (7691 . 7690) (7693 . 7692) (7695 . 7694)
                       (7697 . 7696) (7699 . 7698) (7701 . 7700) (7703 . 7702) (7705 . 7704)
                       (7707 . 7706) (7709 . 7708) (7711 . 7710) (7713 . 7712) (7715 . 7714)
                       (7717 . 7716) (7719 . 7718) (7721 . 7720) (7723 . 7722) (7725 . 7724)
                       (7727 . 7726) (7729 . 7728) (7731 . 7730) (7733 . 7732) (7735 . 7734)
                       (7737 . 7736) (7739 . 7738) (7741 . 7740) (7743 . 7742) (7745 . 7744)
                       (7747 . 7746) (7749 . 7748) (7751 . 7750) (7753 . 7752) (7755 . 7754)
                       (7757 . 7756) (7759 . 7758) (7761 . 7760) (7763 . 7762) (7765 . 7764)
                       (7767 . 7766) (7769 . 7768) (7771 . 7770) (7773 . 7772) (7775 . 7774)
                       (7777 . 7776) (7779 . 7778) (7781 . 7780) (7783 . 7782) (7785 . 7784)
                       (7787 . 7786) (7789 . 7788) (7791 . 7790) (7793 . 7792) (7795 . 7794)
                       (7797 . 7796) (7799 . 7798) (7801 . 7800) (7803 . 7802) (7805 . 7804)
                       (7807 . 7806) (7809 . 7808) (7811 . 7810) (7813 . 7812) (7815 . 7814)
                       (7817 . 7816) (7819 . 7818) (7821 . 7820) (7823 . 7822) (7825 . 7824)
                       (7827 . 7826) (7829 . 7828) (7835 . 7776) (7841 . 7840) (7843 . 7842)
                       (7845 . 7844) (7847 . 7846) (7849 . 7848) (7851 . 7850) (7853 . 7852)
                       (7855 . 7854) (7857 . 7856) (7859 . 7858) (7861 . 7860) (7863 . 7862)
                       (7865 . 7864) (7867 . 7866) (7869 . 7868) (7871 . 7870) (7873 . 7872)
                       (7875 . 7874) (7877 . 7876) (7879 . 7878) (7881 . 7880) (7883 . 7882)
                       (7885 . 7884) (7887 . 7886) (7889 . 7888) (7891 . 7890) (7893 . 7892)
                       (7895 . 7894) (7897 . 7896) (7899 . 7898) (7901 . 7900) (7903 . 7902)
                       (7905 . 7904) (7907 . 7906) (7909 . 7908) (7911 . 7910) (7913 . 7912)
                       (7915 . 7914) (7917 . 7916) (7919 . 7918) (7921 . 7920) (7923 . 7922)
                       (7925 . 7924) (7927 . 7926) (7929 . 7928) (7931 . 7930) (7933 . 7932)
                       (7935 . 7934) (7936 . 7944) (7937 . 7945) (7938 . 7946) (7939 . 7947)
                       (7940 . 7948) (7941 . 7949) (7942 . 7950) (7943 . 7951) (7952 . 7960)
                       (7953 . 7961) (7954 . 7962) (7955 . 7963) (7956 . 7964) (7957 . 7965)
                       (7968 . 7976) (7969 . 7977) (7970 . 7978) (7971 . 7979) (7972 . 7980)
                       (7973 . 7981) (7974 . 7982) (7975 . 7983) (7984 . 7992) (7985 . 7993)
                       (7986 . 7994) (7987 . 7995) (7988 . 7996) (7989 . 7997) (7990 . 7998)
                       (7991 . 7999) (8000 . 8008) (8001 . 8009) (8002 . 8010) (8003 . 8011)
                       (8004 . 8012) (8005 . 8013) (8017 . 8025) (8019 . 8027) (8021 . 8029)
                       (8023 . 8031) (8032 . 8040) (8033 . 8041) (8034 . 8042) (8035 . 8043)
                       (8036 . 8044) (8037 . 8045) (8038 . 8046) (8039 . 8047) (8048 . 8122)
                       (8049 . 8123) (8050 . 8136) (8051 . 8137) (8052 . 8138) (8053 . 8139)
                       (8054 . 8154) (8055 . 8155) (8056 . 8184) (8057 . 8185) (8058 . 8170)
                       (8059 . 8171) (8060 . 8186) (8061 . 8187) (8064 . 8072) (8065 . 8073)
                       (8066 . 8074) (8067 . 8075) (8068 . 8076) (8069 . 8077) (8070 . 8078)
                       (8071 . 8079) (8080 . 8088) (8081 . 8089) (8082 . 8090) (8083 . 8091)
                       (8084 . 8092) (8085 . 8093) (8086 . 8094) (8087 . 8095) (8096 . 8104)
                       (8097 . 8105) (8098 . 8106) (8099 . 8107) (8100 . 8108) (8101 . 8109)
                       (8102 . 8110) (8103 . 8111) (8112 . 8120) (8113 . 8121) (8115 . 8124)
                       (8126 . 921) (8131 . 8140) (8144 . 8152) (8145 . 8153) (8160 . 8168)
                       (8161 . 8169) (8165 . 8172) (8179 . 8188) (8526 . 8498) (8560 . 8544)
                       (8561 . 8545) (8562 . 8546) (8563 . 8547) (8564 . 8548) (8565 . 8549)
                       (8566 . 8550) (8567 . 8551) (8568 . 8552) (8569 . 8553) (8570 . 8554)
                       (8571 . 8555) (8572 . 8556) (8573 . 8557) (8574 . 8558) (8575 . 8559)
                       (8580 . 8579) (9424 . 9398) (9425 . 9399) (9426 . 9400) (9427 . 9401)
                       (9428 . 9402) (9429 . 9403) (9430 . 9404) (9431 . 9405) (9432 . 9406)
                       (9433 . 9407) (9434 . 9408) (9435 . 9409) (9436 . 9410) (9437 . 9411)
                       (9438 . 9412) (9439 . 9413) (9440 . 9414) (9441 . 9415) (9442 . 9416)
                       (9443 . 9417) (9444 . 9418) (9445 . 9419) (9446 . 9420) (9447 . 9421)
                       (9448 . 9422) (9449 . 9423) (11312 . 11264) (11313 . 11265) (11314 . 11266)
                       (11315 . 11267) (11316 . 11268) (11317 . 11269) (11318 . 11270) (11319 . 11271)
                       (11320 . 11272) (11321 . 11273) (11322 . 11274) (11323 . 11275) (11324 . 11276)
                       (11325 . 11277) (11326 . 11278) (11327 . 11279) (11328 . 11280) (11329 . 11281)
                       (11330 . 11282) (11331 . 11283) (11332 . 11284) (11333 . 11285) (11334 . 11286)
                       (11335 . 11287) (11336 . 11288) (11337 . 11289) (11338 . 11290) (11339 . 11291)
                       (11340 . 11292) (11341 . 11293) (11342 . 11294) (11343 . 11295) (11344 . 11296)
                       (11345 . 11297) (11346 . 11298) (11347 . 11299) (11348 . 11300) (11349 . 11301)
                       (11350 . 11302) (11351 . 11303) (11352 . 11304) (11353 . 11305) (11354 . 11306)
                       (11355 . 11307) (11356 . 11308) (11357 . 11309) (11358 . 11310) (11361 . 11360)
                       (11365 . 570) (11366 . 574) (11368 . 11367) (11370 . 11369) (11372 . 11371)
                       (11379 . 11378) (11382 . 11381) (11393 . 11392) (11395 . 11394) (11397 . 11396)
                       (11399 . 11398) (11401 . 11400) (11403 . 11402) (11405 . 11404) (11407 . 11406)
                       (11409 . 11408) (11411 . 11410) (11413 . 11412) (11415 . 11414) (11417 . 11416)
                       (11419 . 11418) (11421 . 11420) (11423 . 11422) (11425 . 11424) (11427 . 11426)
                       (11429 . 11428) (11431 . 11430) (11433 . 11432) (11435 . 11434) (11437 . 11436)
                       (11439 . 11438) (11441 . 11440) (11443 . 11442) (11445 . 11444) (11447 . 11446)
                       (11449 . 11448) (11451 . 11450) (11453 . 11452) (11455 . 11454) (11457 . 11456)
                       (11459 . 11458) (11461 . 11460) (11463 . 11462) (11465 . 11464) (11467 . 11466)
                       (11469 . 11468) (11471 . 11470) (11473 . 11472) (11475 . 11474) (11477 . 11476)
                       (11479 . 11478) (11481 . 11480) (11483 . 11482) (11485 . 11484) (11487 . 11486)
                       (11489 . 11488) (11491 . 11490) (11520 . 4256) (11521 . 4257) (11522 . 4258)
                       (11523 . 4259) (11524 . 4260) (11525 . 4261) (11526 . 4262) (11527 . 4263)
                       (11528 . 4264) (11529 . 4265) (11530 . 4266) (11531 . 4267) (11532 . 4268)
                       (11533 . 4269) (11534 . 4270) (11535 . 4271) (11536 . 4272) (11537 . 4273)
                       (11538 . 4274) (11539 . 4275) (11540 . 4276) (11541 . 4277) (11542 . 4278)
                       (11543 . 4279) (11544 . 4280) (11545 . 4281) (11546 . 4282) (11547 . 4283)
                       (11548 . 4284) (11549 . 4285) (11550 . 4286) (11551 . 4287) (11552 . 4288)
                       (11553 . 4289) (11554 . 4290) (11555 . 4291) (11556 . 4292) (11557 . 4293)
                       (42561 . 42560) (42563 . 42562) (42565 . 42564) (42567 . 42566) (42569 . 42568)
                       (42571 . 42570) (42573 . 42572) (42575 . 42574) (42577 . 42576) (42579 . 42578)
                       (42581 . 42580) (42583 . 42582) (42585 . 42584) (42587 . 42586) (42589 . 42588)
                       (42591 . 42590) (42595 . 42594) (42597 . 42596) (42599 . 42598) (42601 . 42600)
                       (42603 . 42602) (42605 . 42604) (42625 . 42624) (42627 . 42626) (42629 . 42628)
                       (42631 . 42630) (42633 . 42632) (42635 . 42634) (42637 . 42636) (42639 . 42638)
                       (42641 . 42640) (42643 . 42642) (42645 . 42644) (42647 . 42646) (42787 . 42786)
                       (42789 . 42788) (42791 . 42790) (42793 . 42792) (42795 . 42794) (42797 . 42796)
                       (42799 . 42798) (42803 . 42802) (42805 . 42804) (42807 . 42806) (42809 . 42808)
                       (42811 . 42810) (42813 . 42812) (42815 . 42814) (42817 . 42816) (42819 . 42818)
                       (42821 . 42820) (42823 . 42822) (42825 . 42824) (42827 . 42826) (42829 . 42828)
                       (42831 . 42830) (42833 . 42832) (42835 . 42834) (42837 . 42836) (42839 . 42838)
                       (42841 . 42840) (42843 . 42842) (42845 . 42844) (42847 . 42846) (42849 . 42848)
                       (42851 . 42850) (42853 . 42852) (42855 . 42854) (42857 . 42856) (42859 . 42858)
                       (42861 . 42860) (42863 . 42862) (42874 . 42873) (42876 . 42875) (42879 . 42878)
                       (42881 . 42880) (42883 . 42882) (42885 . 42884) (42887 . 42886) (42892 . 42891)
                       (65345 . 65313) (65346 . 65314) (65347 . 65315) (65348 . 65316) (65349 . 65317)
                       (65350 . 65318) (65351 . 65319) (65352 . 65320) (65353 . 65321) (65354 . 65322)
                       (65355 . 65323) (65356 . 65324) (65357 . 65325) (65358 . 65326) (65359 . 65327)
                       (65360 . 65328) (65361 . 65329) (65362 . 65330) (65363 . 65331) (65364 . 65332)
                       (65365 . 65333) (65366 . 65334) (65367 . 65335) (65368 . 65336) (65369 . 65337)
                       (65370 . 65338) (66600 . 66560) (66601 . 66561) (66602 . 66562) (66603 . 66563)
                       (66604 . 66564) (66605 . 66565) (66606 . 66566) (66607 . 66567) (66608 . 66568)
                       (66609 . 66569) (66610 . 66570) (66611 . 66571) (66612 . 66572) (66613 . 66573)
                       (66614 . 66574) (66615 . 66575) (66616 . 66576) (66617 . 66577) (66618 . 66578)
                       (66619 . 66579) (66620 . 66580) (66621 . 66581) (66622 . 66582) (66623 . 66583)
                       (66624 . 66584) (66625 . 66585) (66626 . 66586) (66627 . 66587) (66628 . 66588)
                       (66629 . 66589) (66630 . 66590) (66631 . 66591) (66632 . 66592) (66633 . 66593)
                       (66634 . 66594) (66635 . 66595) (66636 . 66596) (66637 . 66597) (66638 . 66598)
                       (66639 . 66599)))
(define upcase-hashtable #f)
(define downcase-hashtable #f)
(define titlecase-hashtable #f)
(define general-category-hashtable #f)
(define other-alphabetic-hashtable #f)
(define other-uppercase-hashtable #f)
(define other-lowercase-hashtable #f)
(define whitespace-hashtable #f)
(define special-uppercase-hashtable #f)
(define special-lowercase-hashtable #f)
(define foldcase-hashtable #f)
(define canonical-decompose-hashtable #f)
(define compatible-decompose-hashtable #f)
(define combination-class-hashtable #f)
(define compose-hashable #f)

(define (foldcase char)
  (unless foldcase-hashtable
    (set! foldcase-hashtable (alist->eq-hash-table foldcase-list)))
   (hashtable-ref foldcase-hashtable (char->integer char) #f))

(define (property-list->hashtable property-list)
  (let ([hashtable (make-eq-hashtable)])
    (for-each
     (lambda (data)
       (cond
        [(number? data)
         (hashtable-set! hashtable (integer->char data) #t)]
                                        ; (start . end)
        [(pair? data)
         (let loop ([start (car data)]
                    [end (cdr data)])
           (if (> start end)
               '()
               (begin (hashtable-set! hashtable (integer->char start) #t)
                      (loop (+ start 1) end))))]))
     property-list)
    hashtable))


(define (whitespace-proprety? char)
  (unless whitespace-hashtable
    (set! whitespace-hashtable (property-list->hashtable whitespace-property-list)))
  (hashtable-ref whitespace-hashtable char #f))

(define (other-alphabetic-property? char)
  (unless other-alphabetic-hashtable
    (set! other-alphabetic-hashtable (property-list->hashtable other-alphabetic-property-list)))
  (hashtable-ref other-alphabetic-hashtable char #f))

(define (other-uppercase-property? char)
  (unless other-uppercase-hashtable
    (set! other-uppercase-hashtable (property-list->hashtable other-uppercase-property-list)))
  (hashtable-ref other-uppercase-hashtable char #f))

(define (other-lowercase-property? char)
  (unless other-lowercase-hashtable
    (set! other-lowercase-hashtable (property-list->hashtable other-lowercase-property-list)))
  (hashtable-ref other-lowercase-hashtable char #f))

(define (char-whitespace? char)
  (whitespace-proprety? char))

(define (char-alphabetic? char)
  (case (char-general-category char)
    ((Lu Ll Lt Lm Lo Nl) #t)
    ((Mn Mc So)
     (other-alphabetic-property? char))
    (else #f)))

(define (char-numeric? char)
  (eq? (char-general-category char) 'Nd))

(define (char-upper-case? char)
  (case (char-general-category char)
    ((Lu) #t)
    ((Nl So)
     (other-uppercase-property? char))
    (else #f)))

(define (char-lower-case? char)
  (case (char-general-category char)
    ((Ll) #t)
    ((Lm Mn Nl So)
     (other-lowercase-property? char))
    (else #f)))

(define (char-title-case? char)
  (eq? (char-general-category char) 'Lt))

(define (char-upcase char)
  (unless upcase-hashtable
    (set! upcase-hashtable (alist->eq-hash-table upcase-alist)))
  (cond
   [(hashtable-ref upcase-hashtable (char->integer char)) => integer->char]
   [else char]))

(define (char-downcase char)
  (unless downcase-hashtable
    (set! downcase-hashtable (alist->eq-hash-table downcase-alist)))
  (cond
   [(hashtable-ref downcase-hashtable (char->integer char)) => integer->char]
   [else char]))

(define (char-titlecase char)
  (unless titlecase-hashtable
    (set! titlecase-hashtable (alist->eq-hash-table titlecase-alist)))
  (cond
   [(hashtable-ref titlecase-hashtable (char->integer char)) => integer->char]
   [else (char-upcase char)]))

(define (char-foldcase char)
  (cond
   [(or (char=? char #\x130)
        (char=? char #\x131))
    char]
   [else
    (char-downcase (char-upcase char))]))

(define (char-general-category char)
  (unless general-category-hashtable
    (let ([hashtable (make-eq-hashtable)])
      (for-each (lambda (category-set)
                  (for-each (lambda (data)
                              (cond
                               [(number? data)
                                (hashtable-set! hashtable (integer->char data) (car category-set))]
                                        ; (start . end)
                               [(pair? data)
                                (let loop ([start (car data)]
                                           [end (cdr data)])
                                  (if (> start end)
                                      '()
                                      (begin (hashtable-set! hashtable (integer->char start) (car category-set))
                                             (loop (+ start 1) end))))]))
                            (cdr category-set)))
                general-category-alist)
      (set! general-category-hashtable hashtable)))
  (hashtable-ref general-category-hashtable char 'Cn))


(define (char-ci=? . char-lst)
  (apply char=? (map char-titlecase char-lst)))

(define (char-ci<? . char-lst)
  (apply char<? (map char-titlecase char-lst)))

(define (char-ci>? . char-lst)
  (apply char>? (map char-titlecase char-lst)))

(define (char-ci<=? . char-lst)
  (apply char<=? (map char-titlecase char-lst)))

(define (char-ci>=? . char-lst)
  (apply char>=? (map char-titlecase char-lst)))

(define (special-uppercase char)
  (unless special-uppercase-hashtable
    (set! special-uppercase-hashtable (alist->eq-hash-table special-uppercase-list)))
   (hashtable-ref special-uppercase-hashtable (char->integer char) #f))

(define (special-lowercase char)
  (unless special-lowercase-hashtable
    (set! special-lowercase-hashtable (alist->eq-hash-table special-lowercase-list)))
   (hashtable-ref special-lowercase-hashtable (char->integer char) #f))

(define (string-downcase s)
  (let ([in (open-string-input-port s)])
    (let-values (((out get-string) (open-string-output-port)))
      (let ([expanded
             (let loop ([ch (read-char in)]
                        [prev-char #\space]
                        [next-char #\space])
               (cond
                [(eof-object? ch) (get-string)]
                ;; when final charcter of form is sigma.
                [(and (or (char-whitespace? next-char) (eof-object? next-char))
                      (not (char-whitespace? prev-char))
                      (or (char=? ch #\x03A3) (char=? ch #\x03C3)))
                 (display #\x03C2 out)
                 (loop (read-char in) ch (lookahead-char in))]
                [(special-lowercase ch)
                 => (lambda (lst)
                      (for-each (lambda (e) (display (char-downcase (integer->char e)) out)) lst)
                      (loop (read-char in) ch (lookahead-char in)))]
                [else
                 (display (char-downcase ch) out)
                 (loop (read-char in) ch (lookahead-char in))]))])
        (if (string=? s expanded) s expanded)))))

(define (string-upcase s)
  (let ([in (open-string-input-port s)])
    (let-values (((out get-string) (open-string-output-port)))
      (let ([expanded
             (let loop ([ch (read-char in)])
               (cond
                [(eof-object? ch) (get-string)]
                [(special-uppercase ch)
                 => (lambda (lst)
                      (for-each (lambda (e) (display (char-upcase (integer->char e)) out)) lst)
                      (loop (read-char in)))]
                [else
                 (display (char-upcase ch) out)
                 (loop (read-char in))]))])
        (if (string=? s expanded) s expanded)))))

(define (string-foldcase s)
  (let ([in (open-string-input-port s)])
    (let-values (((out get-string) (open-string-output-port)))
      (let ([expanded
             (let loop ([ch (read-char in)])
               (cond
                [(eof-object? ch) (get-string)]
                [(foldcase ch)
                 => (lambda (lst)
                      (for-each (lambda (e) (display (char-foldcase (integer->char e)) out)) lst)
                      (loop (read-char in)))]
                [else
                 (display (char-foldcase ch) out)
                 (loop (read-char in))]))])
        (if (string=? s expanded) s expanded)))))

;; from ypsilon scheme 0.9.5 by Yoshikatsu Fujita start
(define (string-titlecase s)
  (let ((input (open-string-input-port s)))
    (let-values (((output get-string) (open-string-output-port)))
      (letrec ((titlecase-first-char
                (lambda ()
                  (let loop ((ch (read-char input)))
                    (cond ((eof-object? ch)
                           (get-string))
                          (else
                           (case (char-general-category ch)
                             ((Ll Lu Lt)
                              (display (char-titlecase ch) output)
                              (downcase-subsequence))
                             (else
                              (display ch output)
                              (loop (read-char input)))))))))
               (downcase-subsequence
                (lambda ()
                  (let loop ((ch (read-char input)))
                    (cond ((eof-object? ch)
                           (get-string))
                          (else
                           (case (char-general-category ch)
                             ((Ll Lu Lt)
                              (display (char-downcase ch) output)
                              (loop (read-char input)))
                             ((Po Pf)
                              (case ch
                                ((#\x0027          ; MidLetter # Po       APOSTROPHE
                                  #\x003A          ; MidLetter # Po       COLON
                                  #\x00B7          ; MidLetter # Po       MIDDLE DOT
                                  #\x05F4          ; MidLetter # Po       HEBREW PUNCTUATION GERSHAYIM
                                  #\x2019          ; MidLetter # Pf       RIGHT SINGLE QUOTATION MARK
                                  #\x2027          ; MidLetter # Po       HYPHENATION POINT
                                  )
                                 (display ch output)
                                 (loop (read-char input)))
                                (else
                                 (display ch output)
                                 (titlecase-first-char))))
                             (else
                              (display ch output)
                              (titlecase-first-char)))))))))
        (let ((new (titlecase-first-char)))
          (if (string=? s new) s new))))))

(define (compose string)
  (define (pair-number->symbol a b)
    (string->symbol (format "x~d$~d" a b)))
  (define (try-compose a b)
    (hashtable-ref compose-hashable (pair-number->symbol (char->integer a) (char->integer b)) #f))
  (unless compose-hashable
    (let ([composition-exclusion-hashtable (make-eq-hashtable)])
      (for-each
       (lambda (x)
         (hashtable-set! composition-exclusion-hashtable x #t))
       composition-exclusion-list)
    (let ([hashtable (make-eq-hashtable)])
      (for-each
       (lambda (compose-set)
         (cond
          [(and (= (length (cdr compose-set)) 2)
                (not (hashtable-ref composition-exclusion-hashtable (cadr compose-set))))
           (hashtable-set! hashtable (apply pair-number->symbol (cdr compose-set)) (integer->char (car compose-set)))]
          [else
           '()
           ;; Ignore 1:1 mapping for Composition Exclusion.
           ]))
       canonical-decompose-list)
      (set! compose-hashable hashtable))))
  (let ([len (string-length string)])
    (let* ([first (string-ref string 0)]
           [first-class (if (zero? (char-combination-class first)) 0 256)])
      (let loop ([i 1]
                 [starter first]
                 [starter-class first-class]
                 [starter-pos 0]
                 [comp-pos 1])
      (cond ((>= i len)
             (substring string 0 comp-pos))
            (else
             (let* ((this (string-ref string i))
                    (this-class (char-combination-class this)))
               (cond ((and (or (= starter-class 0) (< starter-class this-class))
                           (try-compose starter this))
                      => (lambda (composit)
                           (string-set! string starter-pos composit)
                           (loop (+ i 1) composit (char-combination-class composit) starter-pos comp-pos)))
                     (else
                      (string-set! string comp-pos this)
                      (if (= this-class 0)
                          (loop (+ i 1) this this-class comp-pos (+ comp-pos 1))
                          (loop (+ i 1) starter this-class starter-pos (+ comp-pos 1))))))))))))
;; from ypsilon scheme 0.9.5 end

(define (string-ci=? . strings)
  (apply string=? (map string-foldcase strings)))

(define (string-ci<? . strings)
  (apply string<? (map string-foldcase strings)))

(define (string-ci>? . strings)
  (apply string>? (map string-foldcase strings)))

(define (string-ci<=? . strings)
  (apply string<=? (map string-foldcase strings)))

(define (string-ci>=? . strings)
  (apply string>=? (map string-foldcase strings)))

(define (canonical-decompose char)
  (unless canonical-decompose-hashtable
    (set! canonical-decompose-hashtable (alist->eq-hash-table canonical-decompose-list)))
  (hashtable-ref canonical-decompose-hashtable (char->integer char) #f))

(define (canonical-decompose-char char out)
  (cond [(canonical-decompose char)
         => (lambda (lst)
              (for-each (lambda(ch) (canonical-decompose-char (integer->char ch) out)) lst))]
        [else
         (display char out)]))

(define (compatible-decompose char)
  (unless compatible-decompose-hashtable
    (set! compatible-decompose-hashtable (alist->eq-hash-table compatible-decompose-list)))
  (hashtable-ref compatible-decompose-hashtable (char->integer char) #f))

(define (compatible-decompose-char char out)
  (cond [(compatible-decompose char)
         => (lambda (lst)
              (for-each (lambda(ch) (compatible-decompose-char (integer->char ch) out)) lst))]
        [(canonical-decompose char)
         => (lambda (lst)
              (for-each (lambda(ch) (compatible-decompose-char (integer->char ch) out)) lst))]
        [else
         (display char out)]))

(define (char-combination-class char)
  (unless combination-class-hashtable
    (let ([hashtable (make-eq-hashtable)])
      (for-each
       (lambda (class-set)
         (for-each
          (lambda (integer)
            (hashtable-set! hashtable integer (car class-set)))
          (cdr class-set)))
       combination-class-list)
      (set! combination-class-hashtable hashtable)))
  (hashtable-ref combination-class-hashtable (char->integer char) 0))

(define (canonical-sort string)
  (define (find-next-class-zero start len)
    (let loop ([index start])
      (cond
       [(= len index) index]
       [(zero? (char-combination-class (string-ref string index)))
        index]
       [else
        (loop (+ index 1))])))
  (let ([len (string-length string)])
    (let-values (((output get-string) (open-string-output-port)))
      (let loop ([index 0])
        (cond
         [(= index len) (get-string)]
         [else
          (display (string-ref string index) output)
          (let ([next (find-next-class-zero (+ index 1) len)])
            (when (> (- next index) 1)
              (for-each
               (lambda (char) (display char output))
               (string->list
                (string-stable-sort!
                 (lambda (x y)
                   (< (char-combination-class x) (char-combination-class y)))
                 (substring string (+ index 1) next)))))
            (loop next))])))))

(define (string-stable-sort! proc string)
  (let ([len (string-length string)])
    (let loop ([i 0])
      (cond
       [(= i (- len 1)) string]
       [else
        (let in-loop ([j (- len 1)])
          (cond
           [(= i j)
            (loop (+ i 1))]
           [else
            (when (proc (string-ref string j) (string-ref string (- j 1)))
              (let ([tmp (string-ref string j)])
                (string-set! string j (string-ref string (- j 1)))
                (string-set! string (- j 1) tmp)))
            (in-loop (- j 1))]))]))))

(define (string-normalize-nfd s)
  (let ([in (open-string-input-port s)])
    (let-values (((out get-string) (open-string-output-port)))
      (let ([expanded
             (let loop ([ch (read-char in)])
               (cond
                [(eof-object? ch) (canonical-sort (get-string))]
                [else
                 (canonical-decompose-char ch out)
                 (loop (read-char in))]))])
        (if (string=? s expanded) s expanded)))))

(define (string-normalize-nfkd s)
  (let ([in (open-string-input-port s)])
    (let-values (((out get-string) (open-string-output-port)))
      (let ([expanded
             (let loop ([ch (read-char in)])
               (cond
                [(eof-object? ch) (canonical-sort (get-string))]
                [else
                 (compatible-decompose-char ch out)
                 (loop (read-char in))]))])
        (if (string=? s expanded) s expanded)))))

  (define (string-normalize-nfc string)
    (compose
     (string-normalize-nfd string)))

  (define (string-normalize-nfkc string)
    (compose
     (string-normalize-nfkd string)))

(define (call-with-port p proc)
  (dynamic-wind
      (lambda () #t)
      (lambda () (proc p))
      (lambda () (close-port p))))

(define (file-newer? a b)
  (> (stat-mtime a) (stat-mtime b)))

(define fasl-write! fasl-write)
(define fasl-read! fasl-read)
