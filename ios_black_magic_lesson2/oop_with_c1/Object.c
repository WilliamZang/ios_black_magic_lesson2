//
//  Object.c
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/19.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#include "Object.h"

Object *base_init(struct Object *self) {
    self->mtable = Get_Object_MTable();
    return self;
}

void base_dealloc(struct Object *self) {
    free(self);
}

Object_MTable *Get_Object_MTable() {
    static Object_MTable *mtable = NULL;
    if (NULL == mtable) {
        static Object_MTable static_mtable = {
            .init = base_init,
            .dealloc = base_dealloc
        };
        mtable = &static_mtable;
    }
    return mtable;
}





