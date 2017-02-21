//
//  Taxi.c
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/20.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#include "Taxi.h"

typedef struct Taxi_Private_Data {
    STATS available;
} Taxi_Private_Data;
typedef struct Taxi_Private {
    Car super;
    Taxi_Private_Data *private;
} Taxi_Private;

Taxi_Private *taxi_init(Taxi_Private *self) {
    SUPER_INIT(Taxi, Car, 0);
    self->private = (Taxi_Private_Data *)malloc(sizeof(Taxi_Private_Data));
    self->private->available = AVAILABLE;
    return self;
}

const char *taxi_color(Taxi_Private *self) {
    return "yellow";
}

STATS available(Taxi_Private *self) {
    return self->private->available;
}

int pick_up(Taxi_Private *self) {
    if (self->private->available == AVAILABLE) {
        self->private->available = BUSY;
        return 1;
    } else {
        return 0;
    }
}

int set_off(Taxi_Private *self) {
    if (self->private->available == BUSY) {
        self->private->available = AVAILABLE;
        return 1;
    } else {
        return 0;
    }
}

void taxi_dealloc(struct Taxi_Private *self) {
    free(self->private);
    SUPER_CALL_DEF_AS(self, Car, Object, dealloc);
}


Taxi_MTable *Get_Taxi_MTable() {
    static Taxi_MTable *mtable = NULL;
    if (NULL == mtable) {
        static Taxi_MTable static_mtable = {
            .init = (Taxi_Init_Type *)taxi_init,
            .available = (Available_Type *)available,
            .pick_up = (Pick_Up_Type *)pick_up,
            .set_off = (Set_Off_Type *)set_off
        };
        static_mtable.super = *Get_Car_MTable();
        mtable = &static_mtable;
        
        ((Car_MTable *)mtable)->color = (Color_Type *)taxi_color;
    }
    return mtable;
}







