#lang scribble/manual
@require[@for-label[racket]]

@title{語}
@author{zaoqi}

@defmodule[lang #:lang #:packages ("lang")]

@define-syntax-rule[(重名詞法 名 原) @define-syntax-rule[(名 . 參) (原 . 參)]]

@重名詞法[述機 defproc]
@重名詞法[語 racket]
@重名詞法[述 defform]
@重名詞法[述/子 defform/subs]
@重名詞法[述值 defthing]

@section{形式}
@述[(#%式 式 甲 ...)]{等價與使用@語[:機.用]和[WIP]。使用一個@語[引機？]@語[式]。可以寫作@語[{式 甲 ...}]。}
@述[(#%頂 名)]{頂層的物。}
@述[(機 形 ...)]{等價與使用@語[:機.用]。}

@section{物}
@述機[(等？ [甲 (非 :誤？)] [乙 (非 :誤？)]) :陰-陽？]{返回@語[甲]是否等於@語[乙]。}

@subsection{列}
@述機[(:列/構？ [:物 (非 :誤？)]) :陰-陽？]
@述機[(→:列/構 [首 :物？] [尾 :物？]) :列/構？]
@述機[(:列/構.首 [:物 :列/構？]) :物？]
@述機[(:列/構.尾 [:物 :列/構？]) :物？]
@述機[(:列/空？ [:物 (非 :誤？)]) :陰-陽？]
@述值[:列/空 列/空？ #:value ()]

@subsection{名}
@述機[(:名/文？ [:物 (非 :誤？)]) :陰-陽？]

@述機[(:名/構？ [:物 (非 :誤？)]) :陰-陽？]
@述機[(→:名/構 [名 :物？] [列 :物？]) :名/構？]{@語[名]一般是@語[:名]。@語[列]一般是@語[:列]。}
@述機[(:名/構.名 [物 :名/構？]) :物？]
@述機[(:名/構.列 [物 :名/構？]) :物？]

@subsection{集/定}
@述機[(:集/定？ [物 (非 :誤？)]) :陰-陽？]
@述值[空:集/定 :集/定？]
@述機[(:集/定.增 [物 :集/定？] [名 :物？] [甲 :物？]) :集/定？]{原來沒有，是增。}
@述機[(:集/定.改 [物 :集/定？] [名 :物？] [機 (-> :物？ :物？)]) :集/定？]
@述機[(:集/定.取 [物 :集/定？] [名 :物？]) :物？]
@述機[(:集/定.含？ [物 :集/定？] [名 :物？]) :陰-陽？]
@述機[(:集/定.删 [物 :集/定？] [名 :物？]) 映？]{必須有，才能刪。}
@述機[(:集/定→:列 [物 :集/定？]) (listof (list/c any/c any/c))]

@subsection{機}
@述機[(:機？ [物 (非 :誤？)]) :陰-陽？]
@述機[(→:機 [形 :物？] [物 :物？]) :機？]{@語[形]類似Scheme,不是@語[:列]的當成@racket[symbol?]。}
@述機[(:機.形 [物 :機？]) :物？]
@述機[(:機.物 [物 :機？]) 未算？]
@述機[(:機.用 [物 :機？] [形 :物？]) :物？]
WIP