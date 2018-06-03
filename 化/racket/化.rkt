#lang lazy
{require racket/dict srfi/9 racket/match}
{define-custom-hash-types hash-lazy equal?}

{define-syntax-rule {入 . xs} {λ . xs}}
{define-syntax-rule {define/memroize*/forever (f x ...) v}
  {define f
    {let ([h (make-mutable-hash-lazy)])
      {入 (x ...)
         (dict-ref! h `(,x ...) {入 () v})}}}}

{define-syntax-rule {define-rec is? (f a ...)}
  {define-record-type is?
    (f a ...)
    is?
    (a a) ...}}
;{define-syntax-rule {define-rec is? (f p ...)}
;  {begin
;    {define s (string->symbol (string-append "rec:" (symbol->string 'f)))}
;    {define (f p ...) `#(,s ,p ...)}
;    {define (is? x) (and (vector? x) (< 0 (vector-length x)) (eq? (vector-ref x 0) s))}
;    {define-rec%%hel is? 1 (p ...)}}}
;{define-syntax define-rec%%hel
;  {syntax-rules ()
;    [(_ is? n (p)) {define (p x) (if (is? x) (vector-ref x n) (error))}]
;    [(_ is? n (p . ps))
;     {begin
;       {define (p x) (if (is? x) (vector-ref x n) (error))}
;       {define n2 (+ n 1)}
;       {define-rec%%hel is? n2 ps}}]}}

{define 等? equal?}

{define :<S集_S陰_S陽>? boolean?}
{define (:S陰? :S物) (等? :S物 其:S陰)}
{define 其:S陰 #f}
{define (:S陽? :S物) (等? :S物 其:S陰)}
{define 其:S陽 #t}
{define <S集_S陰_S陽>.若 if}

{define (:S列? :S物) (or (:S列/連? :S物) (:S列/空? :S物))}
{define :S列/連? pair?}
{define ->S列/連 cons}
{define S列/連.首 car}
{define S列/連.尾 cdr}
{define :S列/空? null?}
{define 其:S列/空 '()}

{define (:S名? :S物) (or (:S名/文? :S物) (:S名/構? :S物))}
{define :S名/文? symbol?}
{define-rec :S名/構? (S名/構 S名/構.:S名 S名/構.:S列)}
;{define/memroize*/forever (→S名/構 :S名 :S列) (S名/構 :S名 :S列)}
{define ->S名/構 S名/構}

{define-rec :S表? (S表 S表->)}
;{define 空:S表 (S表 (make-immutable-hash-lazy))}
{define 空:S表 (S表 '())}
{define (S表.增 :S表 名 :S物) (S表 (dict-set (S表-> :S表) 名 :S物))}
{define (S表.改 :S表 名 :S化) (S表 (dict-update (S表-> :S表) 名 :S化))}
{define (S表.取 :S表 名) (dict-ref (S表-> :S表) 名)}
{define (S表.含？ :S表 名) (dict-has-key? (S表-> :S表) 名)}
{define (S表.删 :S表 名) (dict-remove (S表-> :S表) 名)}
{define (S表->S列 :S表) (map {入 (p) (list (car p) (cdr p))} (dict->list (S表-> :S表)))}

{define-rec :S集? (S集 S集->)}
{define 空:S集 (S集 空:S表)}
{define (S集.增 :S集 :S物) (S集 (S表.增 (S集-> :S集) :S物 #t))}
{define (S集.含？ :S集 :S物) (S表.含？ (S集-> :S集) :S物)}
{define (S集.删 :S集 :S物) (S集 (S表.删 (S集-> :S集) :S物))}
{define (S集->S列 :S集) (map S列/連.首 (S表->S列 (S集-> :S集)))}
{define (集 . xs)
  (if (null? xs)
      空:S集
      (S集.增 (apply 集 (cdr xs)) (car xs)))}

{define-rec :S化? (S化 #%S化.內 S化.形 S化.:S物)}
{define (->S化 形 :S物) (S化 #f 形 :S物)}

{define-rec :S式? (->S式 S式->)}
{define-rec :S構? (->S構 S構.:S名 S構.:S列)}
{define-rec :S誤? (->S誤 S誤->)}

{define symbol->S名
  ({入 ()
      {define (Q x) (string->symbol (list->string x))}
      {define pre
        {match-lambda
          ['() '()]
          [(list #\< 甲 ...) (read-list 甲 {入 (a r) (cons a (pre r))})]
          [(list (and (not #\>) 甲) 乙 ...) (->S列/連 甲 (pre 乙))]}}
      {define (read-list xs c)
        {match-lambda
          [(list (and (not #\>) (not #\<) (not #\_) 甲) ... #\_ 乙 ...) (%read-list {入 (xs) (->S名/構 (Q 甲) xs)} '() xs c)]}}
      {define (%read-list f as xs c)
        {match-lambda
          [(list #\< 甲 ...) (read-list 甲 {入 (a r) (%read-list f (append as (list a)) r c)})]
          [(list (and (not #\>) (not #\<) (not #\_) 甲) ... #\_ 乙 ...) (%read-list f (append as (list (Q 甲))) 乙 c)]
          [(list #\> 甲 ...) (c (f as) xs)]}}
      {define (pre%get n xs c)
        (<S集_S陰_S陽>.若 (等? n 0)
                      (c '() xs)
                      {match xs
                        [(list (and #\< 甲) 乙 ...) (pre%get (+ n 1) 乙 {入 (a r) (c (->S列/連 甲 a) r)})]
                        [(list (and #\> 甲) 乙 ...) (pre%get (- n 1) 乙 {入 (a r) (c (->S列/連 甲 a) r)})]
                        [(list 甲 乙 ...) (pre%get n 乙 {入 (a r) (c (cons 甲 a) r)})]})}
      {define symbol->S名 'WIP}
      symbol->S名
      })}
