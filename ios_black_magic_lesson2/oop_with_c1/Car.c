//
//  Car.c
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/19.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#include "Car.h"

typedef struct Car_Private_Data {
    int times;
    float per_meter;
} Car_Private_Data;

typedef struct Car_Private {
    Object super;
    int total_meters;
    Car_Private_Data *private;
} Car_Private;

Car_Private *car_init(Car_Private *self, int old_total_meters) {
    SUPER_INIT(Car, Object);
    self->total_meters = old_total_meters;
    self->private = (Car_Private_Data *)malloc(sizeof(Car_Private_Data));
    self->private->times = 0;
    self->private->per_meter = 0.0f;
    ++Global_Car_Count;
    return self;
}

static void fix_per_meter(Car_Private *self) {
    self->private->per_meter = self->total_meters / (float)self->private->times;
}

void drive(struct Car_Private *self, int meter) {
    self->total_meters += meter;
    
    ++(self->private->times);
    fix_per_meter(self);
}

int drive_times(struct Car_Private *self) {
    return self->private->times;
}

const char *color(struct Car *self) {
    return "unknown";
}


void car_dealloc(struct Car_Private *self) {
    --Global_Car_Count;
    free(self->private);
    SUPER_CALL(self, Object, dealloc);
}

Car_MTable *Get_Car_MTable() {
    static Car_MTable *mtable = NULL;
    if (NULL == mtable) {
        static Car_MTable static_mtable = {
            .init = (Car_Init_Type *)car_init,
            .drive = (Drive_Type *)drive,
            .drive_times = (DriveTimes_Type *)drive_times,
            .color = color
        };
        static_mtable.super = *Get_Object_MTable();
        mtable = &static_mtable;
        
        ((Object_MTable *)mtable)->dealloc = (Dealloc_Type *)car_dealloc;
    }
    return mtable;
}

int Global_Car_Count = 0;

