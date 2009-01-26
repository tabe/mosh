(import (rnrs)
        (dbi)
        (mosh)
        (mosh test)
        (clos core))

(let ([conn (guard (c (#t (display "mysql not supporeted\n") #f))
                      (dbi-connect "dbi:mysql:mysql:127.0.0.1:3306" "root" ""))])
  (when conn
    ;; conn is sub-class of <connection>
    (test/t (if (memq <connection> (class-direct-supers (class-of conn))) #t #f))

    (let ([query (dbi-prepare conn "select * from user where user = ?")])
      ;; query is <query> or sub-class of query
      (test/t (or (eq? (class-of query) <query>)
                  (if (memq <query> (class-direct-supers (class-of query))) #t #f)))

      (let ([result (dbi-execute query "root")])

        ;; result is <result> or sub-class of result
        (test/t (or (eq? (class-of result) <result>)
                    (if (memq <result> (class-direct-supers (class-of result))) #t #f)))

        (let ([getter (dbi-getter result)])
          (for-each
           (lambda (row)
             (test/t (string? (getter row "host")))
             (test/t (string? (getter row "User"))))
           (dbi-result->list result))
          (dbi-close conn))))))