(load "mk.scm")
(load "z3-driver.scm")
(load "sign-domain.scm")
(load "test-check.scm")

(test "1"
  (run* (q)
    (fresh (s b- b0 b+)
      (s/declare-bito b-)
      (s/declare-bito b0)
      (s/declare-bito b+)
      (s/declareo s)
      (s/has-nego  s b-)
      (s/has-zeroo s b0)
      (s/has-poso  s b+)
      (== q (list s b+ b0 b-))))
  ;; TODO: I think this would be faster
  ;;       if has-...o used conde?
  '((bitvec-101 #t #f #t)
    (bitvec-110 #t #t #f)
    (bitvec-111 #t #t #t)
    (bitvec-010 #f #t #f)
    (bitvec-011 #f #t #t)
    (bitvec-000 #f #f #f)
    (bitvec-001 #f #f #t)
    (bitvec-100 #t #f #f)))

(test "2"
  (run* (s)
    (s/declareo s)
    (s/uniono 'bitvec-110 'bitvec-011 s))
  '(bitvec-111))

(test "3"
  (run* (q)
    (s/declareo q)
    (s/membero 'bitvec-110 q))
  '(bitvec-010 bitvec-100))

(test "4"
  (run* (s)
    (fresh (n)
      (s/declareo s)
      (s/alphao 5 s)))
  '(bitvec-100))

(test "4z3"
  (run* (s)
    (fresh (n)
      (s/declareo s)
      (s/z3-alphao 5 s)))
  '(bitvec-100))

(test "5"
  (run* (s)
    (fresh (s1 s2)
      (s/declareo s)
      (s/declareo s1)
      (s/declareo s2)
      (s/alphao -5 s1)
      (s/alphao 5 s2)
      (s/plus-alphao s1 s2 s)))
  '(bitvec-111))

(test "6"
  (run* (s)
    (fresh (s1 s2)
      (s/declareo s)
      (s/declareo s1)
      (s/declareo s2)
      (s/alphao -5 s1)
      (s/alphao 5 s2)
      (s/pluso s1 s2 s)))
  '(bitvec-111 bitvec-111)) ;; TODO: why twice?

(test "7"
  (run* (s)
    (fresh (s1 s2)
      (s/declareo s)
      (s/declareo s1)
      (s/declareo s2)
      (s/alphao -5 s1)
      (s/alphao 5 s2)
      (s/plus-tableo s1 s2 s)))
  '(bitvec-111))

(test "7z3"
  (run* (s)
    (fresh (s1 s2)
      (s/declareo s)
      (s/declareo s1)
      (s/declareo s2)
      (s/z3-alphao -5 s1)
      (s/z3-alphao 5 s2)
      (s/z3-plus-tableo s1 s2 s)))
  '(bitvec-111))

(test "8"
  (run* (s)
    (fresh (s1 s2)
      (s/declareo s)
      (s/declareo s1)
      (s/declareo s2)
      (s/alphao -5 s1)
      (s/alphao 5 s2)
      (s/times-tableo s1 s2 s)))
  '(bitvec-001))

(test "8"
  (run* (s)
    (fresh (s1 s2)
      (s/declareo s)
      (s/declareo s1)
      (s/declareo s2)
      (s/z3-alphao -5 s1)
      (s/z3-alphao 5 s2)
      (s/z3-times-tableo s1 s2 s)))
  '(bitvec-001))

(test "9"
  (run* (s)
    (s/declareo s)
    (s/chas-nego  s)
    (s/chas-zeroo s)
    (s/chasnt-poso  s))
  '(bitvec-011))

(test "10"
  (run* (s)
    (s/declareo s)
    (s/has-nego  s #t)
    (s/has-zeroo s #t)
    (s/has-poso  s #f))
  '(bitvec-011))

(test "11"
  (run* (s)
    (fresh (s1 s2 s3)
      (== (list s1 s2 s3) s)
      (s/declareo s1)
      (s/declareo s2)
      (s/declareo s3)
      (s/z3-plus-tableo s1 s2 s3)))
  '((bitvec-000 bitvec-000 bitvec-000)
    (bitvec-101 bitvec-001 bitvec-111)
    (bitvec-010 bitvec-001 bitvec-001)
    (bitvec-001 bitvec-010 bitvec-001)
    (bitvec-011 bitvec-011 bitvec-011)
    (bitvec-001 bitvec-011 bitvec-001)
    (bitvec-011 bitvec-010 bitvec-011)
    (bitvec-011 bitvec-001 bitvec-001)
    (bitvec-001 bitvec-001 bitvec-001)
    (bitvec-010 bitvec-011 bitvec-011)
    (bitvec-000 bitvec-100 bitvec-000)
    (bitvec-000 bitvec-110 bitvec-000)
    (bitvec-000 bitvec-101 bitvec-000)
    (bitvec-000 bitvec-111 bitvec-000)
    (bitvec-111 bitvec-000 bitvec-000)
    (bitvec-101 bitvec-000 bitvec-000)
    (bitvec-110 bitvec-000 bitvec-000)
    (bitvec-100 bitvec-000 bitvec-000)
    (bitvec-011 bitvec-000 bitvec-000)
    (bitvec-010 bitvec-010 bitvec-010)
    (bitvec-000 bitvec-010 bitvec-000)
    (bitvec-001 bitvec-000 bitvec-000)
    (bitvec-010 bitvec-000 bitvec-000)
    (bitvec-000 bitvec-011 bitvec-000)
    (bitvec-000 bitvec-001 bitvec-000)
    (bitvec-111 bitvec-111 bitvec-111)
    (bitvec-101 bitvec-111 bitvec-111)
    (bitvec-110 bitvec-111 bitvec-111)
    (bitvec-100 bitvec-111 bitvec-111)
    (bitvec-111 bitvec-110 bitvec-111)
    (bitvec-110 bitvec-110 bitvec-110)
    (bitvec-101 bitvec-110 bitvec-111)
    (bitvec-100 bitvec-110 bitvec-100)
    (bitvec-011 bitvec-111 bitvec-111)
    (bitvec-011 bitvec-110 bitvec-111)
    (bitvec-001 bitvec-111 bitvec-111)
    (bitvec-001 bitvec-110 bitvec-111)
    (bitvec-010 bitvec-111 bitvec-111)
    (bitvec-010 bitvec-110 bitvec-110)
    (bitvec-111 bitvec-101 bitvec-111)
    (bitvec-011 bitvec-101 bitvec-111)
    (bitvec-010 bitvec-101 bitvec-101)
    (bitvec-110 bitvec-101 bitvec-111)
    (bitvec-101 bitvec-101 bitvec-111)
    (bitvec-100 bitvec-101 bitvec-111)
    (bitvec-001 bitvec-101 bitvec-111)
    (bitvec-100 bitvec-100 bitvec-100)
    (bitvec-010 bitvec-100 bitvec-100)
    (bitvec-111 bitvec-100 bitvec-111)
    (bitvec-110 bitvec-100 bitvec-100)
    (bitvec-011 bitvec-100 bitvec-111)
    (bitvec-101 bitvec-100 bitvec-111)
    (bitvec-001 bitvec-100 bitvec-111)
    (bitvec-111 bitvec-011 bitvec-111)
    (bitvec-110 bitvec-011 bitvec-111)
    (bitvec-100 bitvec-011 bitvec-111)
    (bitvec-110 bitvec-010 bitvec-110)
    (bitvec-100 bitvec-010 bitvec-100)
    (bitvec-110 bitvec-001 bitvec-111)
    (bitvec-100 bitvec-001 bitvec-111)
    (bitvec-111 bitvec-010 bitvec-111)
    (bitvec-111 bitvec-001 bitvec-111)
    (bitvec-101 bitvec-010 bitvec-101)
    (bitvec-101 bitvec-011 bitvec-111)))

(test "12"
  (run* (s)
    (fresh (s1 s2 s3)
      (== (list s1 s2 s3) s)
      (s/declareo s1)
      (s/declareo s2)
      (s/declareo s3)
      (s/z3-times-tableo s1 s2 s3)))
  '((bitvec-000 bitvec-000 bitvec-000)
    (bitvec-101 bitvec-001 bitvec-101)
    (bitvec-010 bitvec-010 bitvec-010)
    (bitvec-101 bitvec-101 bitvec-101)
    (bitvec-101 bitvec-110 bitvec-111)
    (bitvec-101 bitvec-100 bitvec-101)
    (bitvec-100 bitvec-100 bitvec-100)
    (bitvec-111 bitvec-110 bitvec-111)
    (bitvec-110 bitvec-110 bitvec-110)
    (bitvec-100 bitvec-110 bitvec-110)
    (bitvec-111 bitvec-100 bitvec-111)
    (bitvec-110 bitvec-100 bitvec-110)
    (bitvec-011 bitvec-100 bitvec-011)
    (bitvec-001 bitvec-100 bitvec-001)
    (bitvec-011 bitvec-110 bitvec-011)
    (bitvec-001 bitvec-110 bitvec-011)
    (bitvec-000 bitvec-100 bitvec-000)
    (bitvec-010 bitvec-110 bitvec-010)
    (bitvec-010 bitvec-100 bitvec-010)
    (bitvec-000 bitvec-110 bitvec-000)
    (bitvec-000 bitvec-101 bitvec-000)
    (bitvec-111 bitvec-111 bitvec-111)
    (bitvec-011 bitvec-111 bitvec-111)
    (bitvec-110 bitvec-111 bitvec-111)
    (bitvec-010 bitvec-111 bitvec-010)
    (bitvec-000 bitvec-111 bitvec-000)
    (bitvec-101 bitvec-111 bitvec-111)
    (bitvec-001 bitvec-111 bitvec-111)
    (bitvec-100 bitvec-111 bitvec-111)
    (bitvec-111 bitvec-101 bitvec-111)
    (bitvec-110 bitvec-101 bitvec-111)
    (bitvec-100 bitvec-101 bitvec-101)
    (bitvec-011 bitvec-101 bitvec-111)
    (bitvec-001 bitvec-101 bitvec-101)
    (bitvec-010 bitvec-101 bitvec-010)
    (bitvec-000 bitvec-010 bitvec-000)
    (bitvec-111 bitvec-010 bitvec-010)
    (bitvec-111 bitvec-011 bitvec-111)
    (bitvec-111 bitvec-000 bitvec-000)
    (bitvec-111 bitvec-001 bitvec-111)
    (bitvec-011 bitvec-010 bitvec-010)
    (bitvec-011 bitvec-011 bitvec-110)
    (bitvec-011 bitvec-000 bitvec-000)
    (bitvec-011 bitvec-001 bitvec-110)
    (bitvec-010 bitvec-000 bitvec-000)
    (bitvec-110 bitvec-001 bitvec-011)
    (bitvec-110 bitvec-000 bitvec-000)
    (bitvec-110 bitvec-011 bitvec-011)
    (bitvec-110 bitvec-010 bitvec-010)
    (bitvec-010 bitvec-001 bitvec-010)
    (bitvec-010 bitvec-011 bitvec-010)
    (bitvec-000 bitvec-001 bitvec-000)
    (bitvec-000 bitvec-011 bitvec-000)
    (bitvec-100 bitvec-000 bitvec-000)
    (bitvec-101 bitvec-011 bitvec-111)
    (bitvec-101 bitvec-010 bitvec-010)
    (bitvec-101 bitvec-000 bitvec-000)
    (bitvec-001 bitvec-011 bitvec-110)
    (bitvec-001 bitvec-001 bitvec-100)
    (bitvec-001 bitvec-010 bitvec-010)
    (bitvec-001 bitvec-000 bitvec-000)
    (bitvec-100 bitvec-010 bitvec-010)
    (bitvec-100 bitvec-001 bitvec-001)
    (bitvec-100 bitvec-011 bitvec-011)))

(test "13"
  (run 20 (q)
    (fresh (n s)
      (== (list n s) q)
      (s/declareo s)
      (s/z3-alphao n s)))
  '((0 bitvec-010)
    (-1 bitvec-001)
    (1 bitvec-100)
    (2 bitvec-100)
    (-2 bitvec-001)
    (3 bitvec-100)
    (4 bitvec-100)
    (5 bitvec-100)
    (-3 bitvec-001)
    (6 bitvec-100)
    (7 bitvec-100)
    (8 bitvec-100)
    (9 bitvec-100)
    (-4 bitvec-001)
    (10 bitvec-100)
    (11 bitvec-100)
    (12 bitvec-100)
    (13 bitvec-100)
    (14 bitvec-100)
    (15 bitvec-100)))

(test "14-non-declarative-a"
  (run 1 (q)
    (fresh (n s)
      (== (list n s) q)
      (s/declareo s)
      (s/z3-alphao n s)))
  '((0 bitvec-010)))

;;; Non-declarative behavior: ideally should still work, even if
;;; s/declareo comes after s/z3-alphao
(test "14-non-declarative-b"
  (run 1 (q)
    (fresh (n s)
      (== (list n s) q)
      (s/z3-alphao n s)
      (s/declareo s)))
  '())

