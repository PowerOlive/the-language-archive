#lang racket
{require racket/dict srfi/9 racket/match (only-in lazy equal? [if lazy-if])}
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
{define <S集_S陰_S陽>.若 lazy-if}

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
{define 空:S表 (S表 (make-immutable-hash-lazy))}
;{define 空:S表 (S表 '())}
{define (S表.增 :S表 名 :S物) (S表 (dict-set (S表-> :S表) 名 :S物))}
{define (S表.改 :S表 名 :S化) (S表 (dict-update (S表-> :S表) 名 :S化))}
{define (S表.取 :S表 名) (dict-ref (S表-> :S表) 名)}
{define (S表.含? :S表 名) (dict-has-key? (S表-> :S表) 名)}
{define (S表.删 :S表 名) (dict-remove (S表-> :S表) 名)}
{define (S表->S列 :S表) (map {入 (p) (list (car p) (cdr p))} (dict->list (S表-> :S表)))}
{define (S列->S表 :S列) (S表 (apply dict-set* (S表-> 空:S表) (apply append :S列)))}
{define (S表.合 甲 乙) (S表 (apply dict-set* (S表-> 甲) (apply append (S表->S列 乙))))}

{define-rec :S集? (S集 S集->)}
{define 空:S集 (S集 空:S表)}
{define (S集.增 :S集 :S物) (S集 (S表.增 (S集-> :S集) :S物 #t))}
{define (S集.含? :S集 :S物) (S表.含? (S集-> :S集) :S物)}
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
      {define pre0
        {match-lambda
          [(list 甲 ... #\< #\< (and 乙 (not #\<) (not #\>)) ..1 #\> #\> 丙 ...) (pre0 (append 甲 (list (R 乙)) 丙))]
          [(list 甲 ... #\< (and 乙 (not #\<) (not #\>)) ..1 #\> 丙 ...) (pre0 (append 甲 (list (pre%list 乙)) 丙))]
          [(list (and 甲 (not #\<) (not #\>) (not #\_)) ..1) (R 甲)]
          }}
      {define pre%list
        {match-lambda
          [(list (and 甲 (not #\_)) ..1 #\_ 乙 ..1) (->S名/構 (R 甲) (pre%list% 乙))]
          [(list (and 甲 (not #\_)) ..1) (->S名/構 (R 甲) '())]}}
      {define pre%list%
        {match-lambda
          [(list (and 甲 (not #\_)) ..1 #\_ 乙 ..1) (cons (R 甲) (pre%list% 乙))]
          [(list (and 甲 (not #\_)) ..1) (list (R 甲))]}}

      {define :Stype? :S構?}
      {define (子 甲 乙) (->S名/構 '子 (list 甲 乙))}
      {define (一\二 類 物) (->S名/構 '一 (list 類 物))}
      {define (一\一 類) (->S名/構 '一 (list 類))}
      {define 其:S類 (->S構 (子 '類 '其) '())}
      {define 類/集 (子 '類 '集)}
      {define S集:S類* (->S構 類/集 `(,其:S類))}
      {define 類/<<:S集>> (子 '類 (一\一 (->S名/構 '類 (list S集:S類*))))}
      {define 類/陰 (子 '類 '陰)}
      {define 類/陽 (子 '類 '陽)}
      {define (->S集 . xs) (->S構 類/<<:S集>> `(,(apply 集 xs)))}
      {define boolean (->S集 類/陰 類/陽)}
      {define 類/化 (子 '類 '化)}
      {define (->S類/化 x y) (->S構 類/化 `(,x ,y))}
      {define 類/<<列/連>> (子 '類 (子 '列 '連))}
      {define (->S類/<<列/連>> x y) (->S構 類/<<列/連>> `(,x ,y))}
      {define S列/連:S類* (->S類/<<列/連>> 其:S類 其:S類)}
      {define S列/空:S類* (->S構 (子 '類 (子 '列 '空)) '())}
      {define S列:S類* (->S集 S列/連:S類* S列/空:S類*)}
      {define S名/構:S類* (->S構 (子 '類 (子 '名 '構)) `(,其:S類 ,其:S類))}
      {define S名/文:S類* (->S構 (子 '類 (子 '名 '文)) '())}
      {define S名:S類* (->S集 S名/構:S類* S名/文:S類*)}
      {define R
        {match-lambda
          [(list (? :S名? 甲)) 甲]
          [(list (? :Stype? 甲)) (->S名/構 '類 (list 甲))]
          ['WIP 'WIP]
          [(list 甲 ..1 #\. 乙 ..1 (or #\？ #\?)) (一\二 (R 乙) (->S類/化 (->S類/<<列/連>> (Rtype 甲) boolean)))]
          [(list 甲 ..1 #\. 乙 ..1) (一\二 (R 乙) (->S類/化 (->S類/<<列/連>> (Rtype 甲) 其:S類) 其:S類))]
          [(list #\: 乙 ..1) (一\一 (Rtype 乙))]
          [(list 甲 ..1 #\: 乙 ..1) (一\二 (R 甲) (Rtype 乙))]
          [(list #\S 甲 ..1) (->S名/構 '類 (list (Rtype (cons #\S 甲))))]
          ['WIP 'WIP]
          [甲 (string->symbol (list->string 甲))]}}
      {define Rtype
        {match-lambda
          [(list (? :Stype? 甲)) 甲]
          ['(#\S #\列) S列:S類*]
          ['(#\S #\列 #\/ #\連) S列/連:S類*]
          ['(#\S #\列 #\/ #\空) S列/空:S類*]
          ['(#\S #\名) S名:S類*]
          ['(#\S #\名 #\/ #\文) S名/文:S類*]
          ['(#\S #\名 #\/ #\構) S名/構:S類*]
          ['(#\S #\表) 'WIP]
          ['(#\S #\集) 'WIP]
          ['(#\S #\化) 'WIP]
          ['(#\S #\式) 'WIP]
          ['(#\S #\構) 'WIP]
          ['(#\S #\誤) 'WIP]
          [(list #\S 甲 ..1) ('WIP (R 甲))]}}
      {define (symbol->S名 s) (pre0 (string->list (symbol->string s)))}
      symbol->S名
      })}

{define 示
  ({入 ()
      {define xs '(甲 乙 丙 丁 戊 己 庚 辛 壬 癸 子 丑 寅 卯 辰 巳 午 未 申 酉 戌 亥)}
      {define (示 物) (%示 xs 空:S集 空:S表 物 {入 (名s 表s str) str})}
      {define (%示 名s old物s 表s 物 k) ; (k 名s 表s str)
        {define new物s (S集.增 old物s 物)}
        {define (R 名s 表s str)
          (if (S表.含? 表s 物)
              (k 名s (S表.删 表s 物) (string-append "周("(S表.取 表s 物)" "str")"))
              (k 名s 表s str))}
        {define (二 f1 f2 r)
          (%示 名s new物s 表s (f1 物)
               {入 (名s 表s str甲)
                  (%示 名s new物s 表s (f2 物)
                      {入 (名s 表s str乙)
                         (R 名s 表s (r str甲 str乙))})})}
        {define (一 f1 r)
          (%示 名s new物s 表s (f1 物)
               {入 (名s 表s str甲)
                  (R 名s 表s (r str甲))})}
        {define (表 名s 表s xs str)
          (if (null? xs)
              (R 名s 表s (string-append "表("str")"))
              (%示 名s new物s 表s (first (car xs))
                  {入 (名s 表s str甲)
                     (%示 名s new物s 表s (second (car xs))
                         {入 (名s 表s str乙)
                            (表 名s 表s (cdr xs) (string-append str(if (equal? str "") "(" " (")str甲" "str乙")"))})}))}
        {define (集 名s 表s xs str)
          (if (null? xs)
              (R 名s 表s (string-append "集("str")"))
              (%示 名s new物s 表s (car xs)
                  {入 (名s 表s str甲)
                     (集 名s 表s (cdr xs) (string-append str(if (equal? str "") "" " ")str甲))}))}
        {define (mk-list 名s 表s xs str)
          (if (null? xs)
              (R 名s 表s (string-append "("str")"))
              (%示 名s new物s 表s (car xs)
                  {入 (名s 表s str甲)
                     (mk-list 名s 表s (cdr xs) (string-append str(if (equal? str "") "" " ")str甲))}))}
        {cond
          [(S表.含? 表s 物) (string-append "周"(S表.取 表s 物))]
          [(S集.含? old物s 物)
           {let ([a (symbol->string (car 名s))])
             (k (cdr 名s) (S表.增 表s 物 a) (string-append "周"a))}]
          [(:S陰? 物) (k 名s 表s "陰")]
          [(:S陽? 物) (k 名s 表s "陽")]
          [(list? 物) (mk-list 名s 表s 物 "")]
          [(:S列/連? 物) (二 S列/連.首 S列/連.尾 {入 (甲 乙) (string-append "連("甲" "乙")")})]
          [(:S列/空? 物) (k 名s 表s "空")]
          [(:S名/文? 物) (k 名s 表s (string-append "文|"(symbol->string 物)"|"))]
          [(:S名/構? 物) (二 S名/構.:S名 S名/構.:S列 {入 (甲 乙) (string-append "名("甲" "乙")")})]
          [(:S表? 物) (表 名s 表s (S表->S列 物) "")]
          [(:S集? 物) (集 名s 表s (S集->S列 物) "")]
          [(:S化? 物) (二 S化.形 S化.:S物 {入 (甲 乙) (string-append "化("甲" "乙")")})]
          [(:S式? 物) (一 S式-> {入 (甲) (string-append "式("甲")")})]
          [(:S構? 物) (二 S構.:S名 S構.:S列 {入 (甲 乙) (string-append "構("甲" "乙")")})]
          [(:S誤? 物) (一 S誤-> {入 (甲) (string-append "誤("甲")")})]
          [else 'WIP]}
        }
      示
      })}
