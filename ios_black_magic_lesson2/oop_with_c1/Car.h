//
//  Car.h
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/19.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#ifndef Car_h
#define Car_h

#include <stdio.h>
#include "Object.h"

struct Car;
typedef struct Car * Car_Init_Type(struct Car *self, int old_total_meters);
typedef void Drive_Type(struct Car *self, int meter);
typedef int DriveTimes_Type(struct Car *self);
typedef const char *Color_Type(struct Car *self);

typedef struct Car_MTable {
    Object_MTable super;
    Car_Init_Type *init;
    Drive_Type *drive;
    DriveTimes_Type *drive_times;
    Color_Type *color;
} Car_MTable;

Car_MTable *Get_Car_MTable();

typedef struct Car {
    Object super;
    int total_meters;
    void *private;
} Car;

extern int Global_Car_Count;




#endif /* Car_h */
