/*
    語: The Language
    Copyright (C) 2018  Zaoqi

    This program is memory_free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the memory_free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
//WIP
#include "c.h"
#include "bool.h"
#include "eq.h"
#include "lang.h"
#include "list.h"
#include "lock.h"
typedef struct ValueV ValueV;
typedef enum {Cons, Null, Symbol, SymbolConst, Data, Collection, Just, Delay} ValueVType;
typedef enum {MarkNothing, // 不需要 mark-sweep
	Marked,
	NotMarked} Mark;
struct ValueV{
	lock lock;
	size_t count; // 自動引用計數
	ValueVType type : 3;
	// mark-sweep 當自動引用計數可能不能處理時使用
	Mark mark : 2;
	union {
		struct {
			Value head;
			Value tail;
		} cons;
		// null
		struct {
			size_t length;// 單位 byte
			char* value;
		} symbol;
		struct {
			Value name;
			Value list;
		} data;
		Value collection;
		// 禁止
		// lang = Haskell
		// let x = x in x
		Value just;
		struct {
			Value x;
			Value (*f)(Value);// f不被remove
		} delay;
	} value;};
inline bool unsafe_Value_exist_p(Value x){
	return x->count||x->mark;}
extern void Value_hold(Value x){lock_with_m(x->lock,{
	assert(unsafe_Value_exist_p(x));
	x->count++;})}
void unsafe_Value_List_push_sub(Value x, List** xs){
	switch(x->type){
		case Cons:
			List_push(xs, x->value.cons.head);
			List_push(xs, x->value.cons.tail);
			break;
		case Null:break;
		case Symbol:break;
		case SymbolConst:break;
		case Data:
			List_push(xs, x->value.data.name);
			List_push(xs, x->value.data.list);
			break;
		case Collection:
			List_push(xs, x->value.collection);
			break;
		case Just:
			List_push(xs, x->value.just);
			break;
		case Delay:
			List_push(xs, x->value.delay.x);
			break;
		default:assert(false);}}
void safe_do_Value_unhold(List* xs){
	while(List_cons_p(xs)){
		Value x=assert_List_pop_m(xs);
		assert_must_lock_do_m(x->lock);
		assert(x->count);
		x->count--;
		if(!unsafe_Value_exist_p(x)){
			unsafe_Value_List_push_sub(x, &xs);
			memory_delete(x);}
		else{
			assert_lock_unlock_do_m(x->lock);}}}
extern void Value_unhold(Value x){
	List* xs=List_null;
	List_push_m(xs, x);
	safe_do_Value_unhold(xs);}

lock marksweep_lock=lock_init;
List* marksweep_list=List_null;
extern void gcValue(){lock_with_m(marksweep_lock,{
	{List* marked=List_null;
		//標記根
		{List* xs=marksweep_list;
			while(List_cons_p(xs)){
				Value x=assert_List_head(xs);
				xs=assert_List_tail(xs);
				
				lock_with_m(x->lock,{
					assert(eq_p(x->mark, NotMarked));
					if(x->count){List_push_m(marked, x);}
					})}}
		//標記子，寫入mark
		while(List_cons_p(marked)){
			Value x=assert_List_pop_m(marked);
			unsafe_Value_List_push_sub(x, &marked);
			lock_with_m(x->lock, {x->mark=Marked;})}}
	//清除
	{List* new_marksweep_list=List_null;
		while(List_cons_p(marksweep_list)){
			Value x=assert_List_pop_m(marksweep_list);
			assert_must_lock_do_m(x->lock);
			switch(x->mark){
				case Marked:
					x->mark=NotMarked;
					List_push_m(new_marksweep_list, x);
					assert_lock_unlock_do_m(x->lock);
					break;
				case NotMarked:
					memory_delete(x);
					break;
				default:assert(false);}}}})}

//WIP

