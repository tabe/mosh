(import (rnrs)
        (mosh)
        (srfi :2)
        (mosh mysql)
        (mosh ffi)
        (mosh test))

(and-let* ([mysql (guard (c (#t #f)) (mysql-init))]
           [(not (pointer-null? (mysql-real-connect mysql "127.0.0.1" "root" "root" "mysql" 3306 NULL 0)))])
  (let ()
    (define (test/mysql-result result)
      (when (pointer-null? result)
        (assertion-violation 'mysql-store-result "failed"))
      (test-true (pointer? (mysql-fetch-lengths result)))
      (test-true (integer? (mysql-field-count mysql)))
      (test-true (integer? (mysql-num-fields result)))
      (test-true (integer? (mysql-row-seek result 0)))
      (test-true (integer? (mysql-row-tell result)))
      (let loop ([row (mysql-fetch-row result)])
        (cond
         [(pointer-null? row) '()]
         [else
          (loop (mysql-fetch-row result))]))
      (mysql-free-result result))
    (unless (pointer-null? (mysql-query mysql "select Host, User from user"))
      (assertion-violation 'mysql-query "failed"))

    (test-true (integer? (mysql-set-character-set mysql "utf8")))

    (test-true (integer? (mysql-select-db mysql "mysql")))
    (let* ([result (mysql-store-result mysql)])
      (when (pointer-null? result)
        (assertion-violation 'mysql-store-result "failed"))
      (mysql-num-rows result)
      (test-true (pointer? (mysql-fetch-lengths result)))
      (test-true (integer? (mysql-field-count mysql)))
      (test-true (integer? (mysql-set-server-option mysql 0)))
      (let loop ([row (mysql-fetch-row result)])
        (cond
         [(pointer-null? row) '()]
         [else
                                        ;      (mysql-row-ref row 0)
          (loop (mysql-fetch-row result))]))

      (let loop ([field (mysql-fetch-field result)])
        (cond
         [(pointer-null? field) '()]
         [else
          (test-true (string? (mysql-field-name field)))
          (loop (mysql-fetch-field result))]))
      (test-true (string? (mysql-field-name (mysql-fetch-field-direct result 1))))
      (test-true (string? (mysql-error mysql)))
      (mysql-data-seek result 1)
      (test-true (integer? (mysql-errno mysql)))
      (test-true (zero? (mysql-dump-debug-info mysql)))
      (test-true (string? (mysql-get-client-info)))
      (test-true (number? (mysql-affected-rows mysql)))
      (test-true (zero? (mysql-autocommit mysql 1)))
      (mysql-free-result result)
      (test-true (zero? (mysql-change-user mysql "root" "root" "information_schema")))
      (test-true (string? (mysql-character-set-name mysql)))
      (test-true (zero? (mysql-commit mysql)))
      (test-true (integer? (mysql-get-client-version)))
      (test-true (string? (mysql-get-host-info mysql)))
      (test-true (integer? (mysql-get-proto-info mysql)))
      (test-true (string? (mysql-get-server-info mysql)))
      (test-true (integer? (mysql-get-server-version mysql)))
      (test-true (pointer-null? (mysql-get-ssl-cipher mysql)))
      (let* ([from "abcd"]
             [len (string-length from)]
             [to-bv (make-bytevector (+ (* len 2) 1))])
        (mysql-hex-string to-bv from len)
        (test-true (equal? "61626364" (null-terminated-utf8->string to-bv))))
      (test-true (or (string? (mysql-info mysql)) (pointer? (mysql-info mysql))))
      (test-true (pointer? (mysql-insert-id mysql)))

      (test/mysql-result (mysql-list-dbs mysql NULL))
      (test/mysql-result (mysql-list-processes mysql))
      (test/mysql-result (mysql-list-tables mysql NULL))

      (test-true (zero? (mysql-more-results mysql)))
      (test-true (integer? (mysql-next-result mysql)))
      (test-true (zero? (mysql-options mysql 2 NULL)))
      (test-true (zero? (mysql-ping mysql)))
      (let* ([from "hoge"]
             [len (string-length from)]
             [to-bv (make-bytevector (+ (* len 2) 1))])
        (mysql-real-escape-string mysql to-bv from len)
        (test-true (string=? "hoge" (null-terminated-utf8->string to-bv))))
      (test-true (integer? (mysql-real-query mysql "select Host, User from user" 28)))
      (test-true (integer? (mysql-refresh mysql 0)))
      (mysql-reload mysql)
      (test-true (integer? (mysql-rollback mysql)))
      ;; This works, but don't do this in test.
      ;; (mysql-shutdwon mysql NULL)
      (test-true (string? (mysql-sqlstate mysql)))
      (test-true (zero? (mysql-ssl-set mysql "" "" "" "")))
      (test-true (string? (mysql-stat mysql)))
      (test-true (integer? (mysql-thread-id mysql)))
      (test-true (pointer-null? (mysql-use-result mysql)))
      (test-true (integer? (mysql-warning-count mysql)))
      (mysql-close mysql)
                                        ;  (mysql-library-end)
      '()))
  #f
  )

(test-results)
