//
//  Object.h
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/19.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#ifndef Object_h
#define Object_h

#include <stdio.h>
#include <stdlib.h>

struct Object;

typedef void Dealloc_Type(struct Object *self);
typedef struct Object *Init_Type(struct Object *self);

typedef struct Object_MTable {
    Init_Type *init;
    Dealloc_Type *dealloc;
} Object_MTable;

Object_MTable *Get_Object_MTable();

typedef struct Object {
    Object_MTable *mtable;
} Object;

/* 
 * 使用 NEW_INSTANCE(class, ...) 来创建一个对象
 */
#define NEW_INSTANCE(CLASS, ...) SUPER_CALL((CLASS *)malloc(sizeof(CLASS)), CLASS, init, ##__VA_ARGS__)

#define SUPER_INIT(CLASS, SUPER_CLASS, ...)              \
SUPER_CALL(self, SUPER_CLASS, init, ##__VA_ARGS__);      \
((Object *)self)->mtable = (Object_MTable *)Get_##CLASS##_MTable();

#define CALL(SELF, CLASS, METHOD, ...) ((CLASS##_MTable *)((Object *)SELF)->mtable)->METHOD((CLASS *)SELF, ##__VA_ARGS__)

#define SUPER_CALL(SELF, CLASS, METHOD, ...) Get_##CLASS##_MTable()->METHOD((CLASS *)SELF, ##__VA_ARGS__)

#define SUPER_CALL_DEF_AS(SELF, CLASS, DEF_CLASS, METHOD, ...) ((DEF_CLASS##_MTable *)Get_##CLASS##_MTable())->METHOD((DEF_CLASS *)SELF, ##__VA_ARGS__)


#endif /* Object_h */
