;;    語
;;    Copyright (C) 2017-2018  Zaoqi

;;    This program is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU Affero General Public License as published
;;    by the Free Software Foundation, either version 3 of the License, or
;;    (at your option) any later version.

;;    This program is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU Affero General Public License for more details.

;;    You should have received a copy of the GNU Affero General Public License
;;    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#lang racket
{require (file "構.rkt")}
{define WIP (delay (error))}
{define (undelay x f)
  {cond
    [(promise? x)
     (if (promise-forced? x)
         (undelay (force x) f)
         (delay (undelay (force x) f)))]
    [else (f x)]}}

{define 境/空 集/定/空}

{define-syntax APP
  {syntax-rules ()
    [{_ e r () ()} r]
    [{_ e r ((p? x0) x ...) (v0 v ...)}
     (undelay v0
              {λ (x0)
                (if (p? x0)
                    {APP e r (x ...) (v ...)}
                    e)})]
    [{_ e r (x0 x ...) (v0 v ...)}
     {let ([x0 v0])
       {APP e r (x ...) (v ...)}}]}}
{define-syntax-rule {定/機%2 形 ...} ({定/機%1 形} ...)}
{define-for-syntax (定/機%0 stx)
  (map {λ (x) (syntax-protect #'t)} (syntax->list stx))}
{define-syntax-rule {引 名} (symbol→名 {quote 名})}
{define-syntax-rule {定 名 物}
  {set! 境/空 (集/定.增 境/空 {引 名} 物)}}
{define-syntax 定/機
  {λ (stx)
    {syntax-case stx ()
      [{_ (名 形 ...) 物} {syntax-case (map {λ (x) (datum->syntax #f (gensym))} (syntax->list #'(形 ...))) ()
                         [(x ...) (syntax-protect #'{定 名 (#%機-內
                                                          {λ (x ...)
                                                            {APP WIP 物 (形 ...) (x ...)}}
                                                          {quote (x ...)}
                                                          WIP)})]}]}}}
{define-syntax-rule {定/機* x ...}
  {begin {定/機 . x} ...}}

{define (非-誤？ 甲) (not (誤？ 甲))}

{定 空 空}
{定 集/定/空 集/定/空}
{定 陰 陰}
{定 陽 陽}
{定 引 WIP}
{定 定 WIP}
{定/機*
 [(等？ 甲 乙) (等？ 甲 乙)]
 
 [(首-尾？ 甲) (undelay 甲 首-尾？)]
 [(首-尾 首 尾) (首-尾 首 尾)]
 [(首-尾.首 (首-尾？ 首)) (首-尾.首 首)]
 [(首-尾.尾 (首-尾？ 首)) (首-尾.尾 首)]
 [(空？ 甲) (undelay 甲 空？)]

 [(文？ 甲) (undelay 甲 文？)]

 [(名/文？ 甲) (undelay 甲 名/文？)]
 [(名/文 列) (名/文 列)]
 [(名/文-1 (名/文？ 甲)) (名/文-1 甲)]
 [(名/構？ 甲) (undelay 甲 名/構？)]
 [(名/構 名 列) (名/構 名 列)]
 [(名/構.名 (名/構？ 甲)) (名/構.名 甲)]
 [(名/構.列 (名/構？ 甲)) (名/構.列 甲)]
 [(名？ 甲) (undelay 甲 名？)]

 [(映？ 甲) (undelay 甲 集/定？)]
 [(集/定.增 (集/定？ 映) ({λ (甲) (not (集/定.含？ 映 甲))} 名) 物) (集/定.增 映 名 物)]
 [(集/定.改 (集/定？ 映) ({λ (甲) (集/定.含？ 映 甲)} 名) 者) WIP]
 [(集/定.增-改 (集/定？ 映) 名 物) (集/定.增-改 名 物)]
 [(集/定.取 (集/定？ 映) 名) (集/定.取 映 名)]
 [(集/定.含？ (集/定？ 映) 名) (集/定.含？ 映 名)]
 [(集/定.删 (集/定？ 映) ({λ (甲) (集/定.含？ 映 甲)} 名)) (集/定.删 映 名)]
 [(集/定→列 (集/定？ 映)) (集/定→列 映)]

 [(機？ 甲) (undelay 甲 機？)]
 [(機 形 物) (機 形 物)]
 [(用 機 形) WIP]
 [(機.形 (機？ 機)) (機.形 機)]
 [(機.物 (機？ 機)) WIP]

 [(若 (boolean? 甲) 乙 丙) (if 甲 乙 丙)]

 [(式？ 甲) (undelay 甲 式？)]
 [(式 機) (式 機)]
 [(式-1 (式？ 甲)) (式-1 甲)]
 
 [(誤？ 甲) (undelay 甲 誤？)]
 [(誤 甲) (誤 甲)]
 [(誤-1 (誤？ 甲)) (誤-1 甲)]

 [(算 未算 境) WIP]

 [(構？ 甲) (undelay 甲 構？)]
 [(構 名 列) (構 名 列)]
 [(構.名 (構？ 甲)) (構.名 甲)]
 [(構.列 (構？ 甲)) (構.列 甲)]

 [(取 名) WIP]}
{定 境/空 境/空}

{define (算 物 境)
  (delay
    (undelay
     物
     {λ (物)
       {cond
         [(首-尾？ 物)
          {let ([首 (首-尾.首 物)] [尾 (首-尾.尾 物)])
            (if (等？ 首 {引 ！式})
                (undelay
                 尾
                 {λ (尾)
                   (if (首-尾？ 尾)
                       {let ([首 (首-尾.首 尾)] [尾 (首-尾.尾 尾)])
                         WIP
                         }
                       WIP)})
                (算/undelay*
                 尾
                 {λ (尾)
                   WIP}))}]
         [(名？ 物) ("映.取" 境 物 WIP)]
         [else 物]}}))}
{define 算/undelay* WIP}
