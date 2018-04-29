# 語

zaoqi

```racket
 #lang lang package: [lang](https://pkgs.racket-lang.org/package/lang)
```

## 1. 形式

```racket
(#%式 式 甲 ...)
```

等價與使用`:機.用`和`→:式-1`。使用一個`引機？式`。可以寫作`{式 甲 ...}`。

```racket
(#%頂 名)
```

頂層的物。

```racket
(機 形 ...)
```

等價與使用`:機.用`。

## 2. 物

### 2.1. 結構/值

#### 2.1.1. 機

`(→:機 '<形> '((#%頂 <名>) . <形>))`

### 2.2. 述

```racket
(等？ 甲 乙) -> :陰-陽？
  甲 : (非 :誤？)    
  乙 : (非 :誤？)    
```

返回`甲`是否等於`乙`。

```racket
(算 物 集/定) -> :物？
  物 : :物？       
  集/定 : :集/定？   
```

```racket
(取 :名) -> :物？
  :名 : 名？    
```

獲取一個包

```racket
(或 甲 乙) -> :物？
  甲 : :物？     
  乙 : :物？     
```

一般是`甲`，可以是`乙`。

#### 2.2.1. 陰-陽

```racket
(:陰-陽？ :物) -> :陰-陽？
  :物 : (非 :誤？)     
```

```racket
陰:陰-陽 : :陰-陽？
```

```racket
陽:陰-陽 : :陰-陽？
```

```racket
(:陰陽.若 :物 甲 乙) -> :物？
  :物 : 陰-陽？          
  甲 : :物？            
  乙 : :物？            
```

若`陰陽`是`陽`，則返回`乙`，否則返回`丙`。

#### 2.2.2. 列

```racket
(:列/構？ :物) -> :陰-陽？
  :物 : (非 :誤？)     
```

```racket
(→:列/構 首 尾) -> :列/構？
  首 : :物？           
  尾 : :物？           
```

```racket
(:列/構.首 :物) -> :物？
  :物 : :列/構？      
```

```racket
(:列/構.尾 :物) -> :物？
  :物 : :列/構？      
```

```racket
(:列/空？ :物) -> :陰-陽？
  :物 : (非 :誤？)     
```

```racket
:列/空 : 列/空？ = ()
```

#### 2.2.3. 名

```racket
(:名/文？ :物) -> :陰-陽？
  :物 : (非 :誤？)     
```

```racket
(:名/構？ :物) -> :陰-陽？
  :物 : (非 :誤？)     
```

```racket
(→:名/構 :名 :列) -> :名/構？
  :名 : :物？            
  :列 : :物？            
```

`:名`一般是`:名`。`:列`一般是`:列`。

```racket
(:名/構.:名 :物) -> :物？
  :物 : :名/構？       
```

```racket
(:名/構.:列 :物) -> :物？
  :物 : :名/構？       
```

#### 2.2.4. 集/定

```racket
(:集/定？ :物) -> :陰-陽？
  :物 : (非 :誤？)     
```

```racket
空:集/定 : :集/定？
```

```racket
(:集/定.增 :物 名 甲) -> :集/定？
  :物 : :集/定？            
  名 : :物？               
  甲 : :物？               
```

原來沒有，是增。

```racket
(:集/定.改 :物 名 :機) -> :集/定？
  :物 : :集/定？             
  名 : :物？                
  :機 : (-> :物？ :物？)      
```

```racket
(:集/定.取 :物 名) -> :物？
  :物 : :集/定？        
  名 : :物？           
```

```racket
(:集/定.含？ :物 名) -> :陰-陽？
  :物 : :集/定？           
  名 : :物？              
```

```racket
(:集/定.删 :物 名) -> :集/定？
  :物 : :集/定？          
  名 : :物？             
```

必須有，才能刪。

```racket
(:集/定→:列 :物) -> (listof (list/c any/c any/c))
  :物 : :集/定？                                 
```

#### 2.2.5. 機

```racket
(:機？ :物) -> :陰-陽？
  :物 : (非 :誤？)   
```

```racket
(→:機 形 :物) -> :機？
  形 : :物？        
  :物 : :物？       
```

`形`類似Scheme,不是`:列`的當成`symbol?`。

```racket
(:機.形 :物) -> :物？
  :物 : :機？      
```

```racket
(:機.物 :物) -> :物？
  :物 : :機？      
```

```racket
(:機.用 :物 形) -> :物？
  :物 : :機？        
  形 : :物？         
```

如果`形`和`:物`不能匹配，這個`誤？`是`形`產生的。

#### 2.2.6. 式

```racket
(:式？ :物) -> :陰-陽？
  :物 : (非 :誤？)   
```

```racket
(→:式 :機) -> :式？
  :機 : :物？     
```

`機`一般是`(-> :集/定？ :物？ ... :物？)`。

```racket
(→:式-1 :物) -> :物？
  :物 : :式？       
```

#### 2.2.7. 構

```racket
(:構？ :物) -> :陰-陽？
  :物 : (非 :誤？)   
```

```racket
(->:構 :名 :列) -> :構？
  :名 : :物？         
  :列 : :物？         
```

`:名`一般是`:名`，`:列`一般是`:列`。

```racket
(:構.:名 :物) -> :物？
  :物 : :構？       
```

```racket
(:構.:列 :物) -> :物？
  :物 : :構？       
```

#### 2.2.8. 誤

```racket
(:誤？ :物) -> :陰-陽？
  :物 : :物？       
```

```racket
(→:誤 :物) -> :誤？
  :物 : :物？     
```

```racket
(→:誤-1 :物) -> :物？
  :物 : :誤？       
```

WIP