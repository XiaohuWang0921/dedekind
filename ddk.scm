(set! COMMENT-FLAG #f)
(libload "nat.scm")
(libload "list.scm")
(libload "pos.scm")
(libload "int.scm")
(libload "rat.scm")
(set! COMMENT-FLAG #t)

(add-alg "ddk" (list "DDConstr" "rat=>rat=>rat=>(rat=>rat=>rat yprod rat)=>(rat=>rat=>boole)=>ddk"))
(add-totality "ddk")
(add-eqp "ddk")
(add-eqpnc "ddk")

(add-var-name "round" (py "rat=>rat=>rat yprod rat"))
(add-var-name "locate" (py "rat=>rat=>boole"))

(add-program-constant "Inh" (py "(rat=>rat=>boole)=>rat=>rat=>rat=>boole"))
(add-computation-rules
 "Inh locate a b c" "a<b andb b<c andb[if(locate a c)(negb(locate a b))(locate b c)]")

(add-program-constant "RndFor" (py "(rat=>rat=>rat yprod rat)=>(rat=>rat=>boole)=>rat=>rat=>boole"))
(add-computation-rules
 "RndFor round locate a b"
 "a<b impb lft(round a b)<rht(round a b)andb[if(locate a b)(locate lft(round a b)rht(round a b))(negb(locate lft(round a b)rht(round a b)))]")

(add-program-constant "DisjFor" (py "(rat=>rat=>boole)=>rat=>rat=>rat=>boole"))
(add-computation-rules
 "DisjFor locate a b c" "a<b impb b<c impb negb(locate a b)orb(locate b c)")

(add-program-constant "PP" (py "ddk=>rat"))
(add-program-constant "QQ" (py "ddk=>rat"))
(add-program-constant "RR" (py "ddk=>rat"))
(add-program-constant "Rnd" (py "ddk=>rat=>rat=>rat yprod rat") t-deg-zero 'const 1)
(add-program-constant "Loc" (py "ddk=>rat=>rat=>boole") t-deg-zero 'const 1)

(add-token
 "pp"
 'postfix-op
 (lambda (x)
   (mk-term-in-app-form
    (make-term-in-const-form (pconst-name-to-pconst "PP"))
    x)))

(add-display
 (py "rat")
 (lambda (x)
   (let ((op (term-in-app-form-to-final-op x))
	 (args (term-in-app-form-to-args x)))
     (if (and (term-in-const-form? op)
	      (string=? "PP"
			(const-to-name (term-in-const-form-to-const op)))
	      (= 1 (length args)))
	 (let ((arg (car args)))
	   (list
	    'postfix-op "pp"
	    (term-to-token-tree arg)))
	 #f))))

(add-token
 "qq"
 'postfix-op
 (lambda (x)
   (mk-term-in-app-form
    (make-term-in-const-form (pconst-name-to-pconst "QQ"))
    x)))

(add-display
 (py "rat")
 (lambda (x)
   (let ((op (term-in-app-form-to-final-op x))
	 (args (term-in-app-form-to-args x)))
     (if (and (term-in-const-form? op)
	      (string=? "QQ"
			(const-to-name (term-in-const-form-to-const op)))
	      (= 1 (length args)))
	 (let ((arg (car args)))
	   (list
	    'postfix-op "qq"
	    (term-to-token-tree arg)))
	 #f))))

(add-token
 "rr"
 'postfix-op
 (lambda (x)
   (mk-term-in-app-form
    (make-term-in-const-form (pconst-name-to-pconst "RR"))
    x)))

(add-display
 (py "rat")
 (lambda (x)
   (let ((op (term-in-app-form-to-final-op x))
	 (args (term-in-app-form-to-args x)))
     (if (and (term-in-const-form? op)
	      (string=? "RR"
			(const-to-name (term-in-const-form-to-const op)))
	      (= 1 (length args)))
	 (let ((arg (car args)))
	   (list
	    'postfix-op "rr"
	    (term-to-token-tree arg)))
	 #f))))

(add-token
 "rnd"
 'postfix-op
 (lambda (x)
   (mk-term-in-app-form
    (make-term-in-const-form (pconst-name-to-pconst "Rnd"))
    x)))

(add-display
 (py "rat=>rat=>rat yprod rat")
 (lambda (x)
   (let ((op (term-in-app-form-to-final-op x))
	 (args (term-in-app-form-to-args x)))
     (if (and (term-in-const-form? op)
	      (string=? "Rnd"
			(const-to-name (term-in-const-form-to-const op)))
	      (= 1 (length args)))
	 (let ((arg (car args)))
	   (list
	    'postfix-op "rnd"
	    (term-to-token-tree arg)))
	 #f))))

(add-token
 "loc"
 'postfix-op
 (lambda (x)
   (mk-term-in-app-form
    (make-term-in-const-form (pconst-name-to-pconst "Loc"))
    x)))

(add-display
 (py "rat=>rat=>boole")
 (lambda (x)
   (let ((op (term-in-app-form-to-final-op x))
	 (args (term-in-app-form-to-args x)))
     (if (and (term-in-const-form? op)
	      (string=? "Loc"
			(const-to-name (term-in-const-form-to-const op)))
	      (= 1 (length args)))
	 (let ((arg (car args)))
	   (list
	    'postfix-op "loc"
	    (term-to-token-tree arg)))
	 #f))))

(add-computation-rules "(DDConstr a b c round locate)pp" "a")
(add-computation-rules "(DDConstr a b c round locate)qq" "b")
(add-computation-rules "(DDConstr a b c round locate)rr" "c")
(add-computation-rules "(DDConstr a b c round locate)rnd" "round")
(add-computation-rules "(DDConstr a b c round locate)loc" "locate")
