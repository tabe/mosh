#!/usr/bin/env gosh
(use gauche.sequence)
(use srfi-1)
(use util.match)

(define (print-header)
  (print "// Do not edit this file generated by gen-insn.scm")
  (print "#ifndef __SCHEME_INSTRUCTION_H__")
  (print "#define __SCHEME_INSTRUCTION_H__")
  (print "")
  (print "#include \"scheme.h\"")
  (print "")
  (print "namespace scheme {")
  (print "")
  (print "class Instruction EXTEND_GC")
  (print "{")
  (print "public:")
)

(define (print-enum lst)
  (print "    enum {")
  (for-each-with-index (lambda (i l)
                         (print (format "        ~a = ~d," l (+ (ash i 5) 14)))) lst) ;; same as Object::makeInstruction2
  (print "    };"))

(define (print-to-string lst)
  (print "    static const ucs4char* toString(int val) {")
  (print "        switch(val) {")
  (for-each (lambda (insn)
              (format #t "        case ~a:\n" insn)
              (format #t "           return UC(\"~a\");\n"  insn)
              (format #t "           break;\n")
              )
            lst)
  (format #t "        default:\n")
  (format #t "           return UC(\"Unkown Instruction\");\n")
  (format #t "           break;\n")
  (print "        }")
  (print "        return UC(\"\");")
  (print "    }")
  (print "\n"))

(define (print-footer)
  (print "};")
  (print "}; // namespace scheme\n")
  (print "#endif // __SCHEME_INSTRUCTION_H__")
)

(define (main args)
  (print-header)
   (let1 lst
       (with-input-from-file (second args)
         (lambda ()
           (let loop ([obj (read)]
                      [ret '()])
             (if (eof-object? obj)
                 (reverse ret)
                 (match obj
                   [('define-insn name n)
                    (loop (read) (cons name ret))])))))
       (print-enum lst)
       (print-to-string lst))
  (print-footer)
  0
)
