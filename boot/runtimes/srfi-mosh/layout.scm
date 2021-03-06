(define layout '( ; specs here
  (load "compat-mosh-run.scm" "mosh-utils5.scm" "runtime.scm")
  (r6rs 
    (core primitives) (core with-syntax) (core syntax-rules)
    (core let) (core derived) (core identifier-syntax) (core quasisyntax) (core quasiquote)
    (core let-values)
    (rnrs base) (rnrs syntax-case) (rnrs control) (rnrs lists)
    (rnrs records procedural) (rnrs records inspection) (rnrs records syntactic)
    (rnrs conditions) 
    (rnrs io ports) (rnrs io simple) (rnrs unicode)
    (rnrs sorting) (rnrs hashtables) (rnrs arithmetic fixnums)
    (rnrs arithmetic flonums) (rnrs arithmetic bitwise) (rnrs programs)
    (rnrs files) (rnrs exceptions) (rnrs enums) (rnrs bytevectors) 
    (rnrs)
    (rnrs mutable-pairs)
    (rnrs mutable-strings) (rnrs eval) (rnrs r5rs) (rnrs load) (rnrs eval reflection)
    (r5rs) )
  (r6rs (mosh) (system) 
        (nmosh pathutils)
        (nmosh global-flags)
        (nmosh conditions) (nmosh condition-printer) (nmosh runlib) 
	(nmosh minidebug) 
	(nmosh startup)
        (nmosh gensym)
        (nrepl simple io)
	(nrepl simple) 
	)
  (r5rs "mosh-exceptions.scm" (rnrs) (nmosh conditions))
  (r5rs "expander.scm" (rnrs base))
  (load "init5.scm")
  (r6rs "init.ss")))
