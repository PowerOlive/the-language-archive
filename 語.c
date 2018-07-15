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
#include "語.h"
#include "list.h"
typedef struct ValueV ValueV;
typedef enum {Cons, Null, Symbol, SymbolConst, Data, Collection, Just, Delay} ValueVType;
struct ValueV{
	size_t count; // 自動引用計數
	ValueVType type : 3;
	unsigned long mark : 5;
		// 0 => 非 mark-sweep
		// 其他 => 由GC確定
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
		Value just;
		struct {
			Value x;
			Value (*f)(Value);// f不被remove
		} delay;
	} value;
};
inline bool Value_exist_p(Value x){
	return x->count||x->mark;
}
extern void Value_hold(Value x){
	assert(Value_exist_p(x));
	x->count++;
}
void Value_ValueList_push_sub(Value x, ListPointer** xs){
	switch(x->type){
		case Cons:
			ListPointer_push(xs, x->value.cons.head);
			ListPointer_push(xs, x->value.cons.tail);
			break;
		case Null:break;
		case Symbol:break;
		case SymbolConst:break;
		case Data:
			ListPointer_push(xs, x->value.data.name);
			ListPointer_push(xs, x->value.data.list);
			break;
		case Collection:
			ListPointer_push(xs, x->value.collection);
			break;
		case Just:
			ListPointer_push(xs, x->value.just);
			break;
		case Delay:
			ListPointer_push(xs, x->value.delay.x);
			break;
		default:assert(false);
	}
}
void do_Value_unhold(ListPointer* xs){
	while(ListPointer_cons_p(xs)){
		Value x=assert_ListPointer_pop_m(xs);
		assert(x->count);
		x->count--;
		if(!Value_exist_p(x)){
			Value_ValueList_push_sub(x, &xs);
			memory_delete(x);
		}
	}
}
extern void Value_unhold(Value x){
	ListPointer* xs=ListPointer_null;
	ListPointer_push(&xs, x);
	do_Value_unhold(xs);
}

