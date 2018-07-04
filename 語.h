/*
    語: The Language
    Copyright (C) 2018  Zaoqi

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
*/
#include <stddef.h>
struct ValueV;
typedef struct ValueV* Value;
void countInc(Value);
void countDec(Value);
Value cons(Value, Value);
bool cons_p(Value);
Value null();
bool null_p(Value);
Value symbolCopy(size_t length, char* value);
bool symbol_p(Value);
Value data(Value name, Value list);
bool data_p(Value);
Value set(Value);
bool set_p(Value);
void assert_equal_optimize(Value, Value);
