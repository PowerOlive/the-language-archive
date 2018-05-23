#lang lazy
{require (file "cons.rkt")}

{define (子 甲 乙) (→名/構 '子 `(,甲 ，乙))}
{define (一 . xs) (→名/構 '一 xs)}

{define 物:類 (→類/或 "WIP")}

{define 類/列/連 (子 '類 (子 '列 '連))}

{define 類/集 (子 '類 '集)}
{define 集:類 (→構 類/集 `(,物:類))}

{define 類/或 (子 '類 '或)}
{define (→類/或 . xs) (→構 類/或 `(,(apply 集 xs)))}

{define 類/名/文 (子 '類 (子 '名 '文))}
{define 名/文:類 (→構 類/名/文 '())}
{define 類/:名/文 (子 '類 (一 名/文:類))}

{define 陰:類 (→構 (子 '類 '陰) '())}
{define 陽:類 (→構 (子 '類 '陽) '())}
{define 陰、陽:類 (→類/或 陰:類 陽:類)}
