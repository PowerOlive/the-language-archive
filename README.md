語
==
    The Language: the best programming language
    Copyright (C) 2014-2018  Zaoqi <zaomir@outlook.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

化
--
[HTML](http://xn--2e3a.ml/)
# 語

zaoqi

```racket
 #lang lang package: [lang](https://pkgs.racket-lang.org/package/lang)
```

## 1. 形式

```racket
(#%式 式 甲 ...)
```

等價與使用`S化.用`和`S式->`。使用一個`:S式？式`。可以寫作`{式 甲 ...}`。

```racket
頂:S表 : :S表？
```

```racket
(#%頂 名)
```

頂層的物。

```racket
(化 形 ...)
```

等價與使用`S化.用`。

## 2. 物

### 2.1. 結構/值

#### 2.1.1. 結構/值 化

`(->S化 '<形> '((#%頂 <名>) . <形>))`

### 2.2. 述

```racket
(等？ 甲 乙) -> :<集_S陰_S陽>？
  甲 : (非 :S誤？)         
  乙 : (非 :S誤？)         
```

返回`甲`是否等於`乙`。

```racket
(算 :S物 :S表) -> :S物？
  :S物 : :S物？       
  :S表 : :S表？       
```

```racket
(取 :S名) -> :S物？
  :S名 : 名？     
```

獲取一個包

```racket
(或 甲 乙) -> :S物？
  甲 : :S物？     
  乙 : :S物？     
```

一般是`甲`，可以是`乙`。

```racket
!引 : :S式？ = (->S式 (->S化 '(:S表 :S物) ':S物))
```

#### 2.2.1. S陰-S陽

```racket
(:<集_S陰_S陽>？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)                
```

```racket
(:S陰？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
其:S陰 : :S陰？
```

```racket
(:S陽？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
其:S陽 : :S陽？
```

```racket
(<集_S陰_S陽>.若 :<集_S陰_S陽> 甲 乙) -> :S物？
  :<集_S陰_S陽> : :<集_S陰_S陽>？          
  甲 : :S物？                          
  乙 : :S物？                          
```

若`:<集_S陰_S陽>`是`其:S陽`，則返回`乙`，否則返回`丙`。

#### 2.2.2. 列

```racket
(:S列？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
(:S列/連？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)           
```

```racket
(->S列/連 首 尾) -> :S列/構？
  首 : :S物？            
  尾 : :S物？            
```

```racket
(S列/連.首 :S列/連) -> :S物？
  :S列/連 : :S列/連？      
```

```racket
(S列/連.尾 :S列/連) -> :S物？
  :S列/連 : :S列/連？      
```

```racket
(:S列/空？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)           
```

```racket
其:S列/空 : :S列/空？ = ()
```

#### 2.2.3. 名

```racket
(:S名？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
(:S名/文？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)           
```

```racket
(:S名/構？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)           
```

```racket
(->S名/構 :S名 :S列) -> :S名/構？
  :S名 : :S物？              
  :S列 : :S物？              
```

`:S名`一般是`:S名`。`:S列`一般是`:S列`。

```racket
(S名/S構.:S名 :S名/構) -> :S物？
  :S名/構 : :S名/構？         
```

```racket
(S名/S構.:S列 :S名/構) -> :S物？
  :S名/構 : :S名/構？         
```

#### 2.2.4. 表

```racket
(:S表？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
空:S表 : :S表？
```

```racket
(S表.增 :S表 名 :S物) -> :S表？
  :S表 : :S表？            
  名 : :S物？              
  :S物 : :S物？            
```

原來沒有，是增。

```racket
(S表.改 :S表 名 :S化) -> :S表？
  :S表 : :S表？            
  名 : :S物？              
  :S化 : (-> :S物？ :S物？)  
```

```racket
(S表.取 :S表 名) -> :S物？
  :S表 : :S表？        
  名 : :S物？          
```

```racket
(S表.含？ :S表 名) -> :<集_S陰_S陽>？
  :S表 : :S表？                
  名 : :S物？                  
```

```racket
(S表.删 :S表 名) -> :S表？
  :S表 : :S表？        
  名 : :S物？          
```

必須有，才能刪。

```racket
(S表->S列 :S表) -> (listof (list/c any/c any/c))
  :S表 : :S表？                                 
```

#### 2.2.5. 集

```racket
(:S集？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
空:S集 : :S集？
```

```racket
(S集.增 :S集 :S物) -> :S集？
  :S集 : :S集？          
  :S物 : :S物？          
```

原來沒有，是增。

```racket
(S集.含？ :S集 :S物) -> :<集_S陰_S陽>？
  :S集 : :S集？                  
  :S物 : :S物？                  
```

```racket
(S集.删 :S集 :S物) -> :S集？
  :S集 : :S集？          
  :S物 : :S物？          
```

必須有，才能刪。

```racket
(S集->S列 :S集) -> (listof any/c)
  :S集 : :S集？                  
```

#### 2.2.6. 化

```racket
(:S化？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
(->S化 形 :S物) -> :S化？
  形 : :S物？          
  :S物 : :S物？        
```

`形`類似Scheme，不是`:S列`的當成`symbol?`。

```racket
(S化.形 :S化) -> :S物？
  :S化 : :S化？      
```

```racket
(S化.:S物 :S化) -> :S物？
  :S化 : :S化？        
```

```racket
(S化.用 :S化 形) -> :S物？
  :S化 : :S化？        
  形 : :S物？          
```

如果`形`和`:S物`不能匹配，這個`:S誤`是`形`產生的。

#### 2.2.7. 式

```racket
(:S式？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
(->S式 :S化) -> :S式？
  :S化 : :S物？      
```

`化`一般是`(-> :S表？ :S物？ ... :S物？)`。

```racket
(S式-> :S式) -> :S物？
  :S式 : :S式？      
```

#### 2.2.8. 構

```racket
(:S構？ :S物) -> :<集_S陰_S陽>？
  :S物 : (非 :S誤？)         
```

```racket
(->S構 :S名 :S列) -> :S構？
  :S名 : :S物？          
  :S列 : :S物？          
```

`:S名`一般是`:S名`，`:S列`一般是`:S列`。

```racket
(S構.:S名 :S構) -> :S物？
  :S構 : :S構？        
```

```racket
(S構.:S列 :S構) -> :S物？
  :S構 : :S構？        
```

#### 2.2.9. 誤

```racket
(:S誤？ :S物) -> :<集_S陰_S陽>？
  :S物 : :S物？             
```

```racket
(->S誤 :S物) -> :S誤？
  :S物 : :S物？      
```

```racket
(S誤-> :S誤) -> :S物？
  :S誤 : :S誤？      
```

## 3. 誤

### 3.1. 無

替換：在進行0或更多次替換後，可以把沒有結果（需要無限的時間的）的任意個`:S物`替換爲`(->S誤 (->S構 {!引 誤/界/無}
<未定義>))`，`<未定義>`是任意的`:S物`。

實現應該儘量避免無限的運行下去。

實現應該儘量避免無用的替換。

### 3.2. 化

內置的任何`:S化`產生的`:S誤`是`(->S誤 (->S構 {!引 誤/界/化} ((->S化 '(:S列) ':S列) <:S名> <式>
<位:S名>)))`， `<:S名>`是它的名稱，`<式>`是它的參數，`<位:S名>`是產生`:S誤`的參數的名稱。

## 4. 類Racket語法

每個vector和symbol會被轉換爲一個`:S名`。

WIP
