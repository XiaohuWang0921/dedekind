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

(add-var-name "opn" (py "rat=>rat=>rat yprod rat"))
(add-var-name "loc" (py "rat=>rat=>boole"))

(add-program-constant "Inh" (py "(rat=>rat=>boole)=>rat=>rat=>rat=>boole"))
(add-computation-rules
 "Inh loc a b c" "a<b andb b<c andb[if(loc a b)(negb(loc a c))(loc c b)]")

(add-program-constant "OpenFor" (py "(rat=>rat=>rat yprod rat)=>(rat=>rat=>boole)=>rat=>rat=>boole"))
(add-computation-rules
 "OpenFor opn loc a b"
 "a<b impb lft(opn a b)<rht(opn a b)andb[if(loc a b)(loc lft(opn a b)rht(opn a b))(negb(loc lft(opn a b)rht(opn a b)))]")

(add-program-constant "DisjFor" (py "(rat=>rat=>boole)=>rat=>rat=>rat=>boole"))
(add-computation-rules
 "DisjFor loc a b c" "a<b impb b<c impb negb(loc a b)orb(loc b c)")
