//
//  Taxi.h
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/20.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#ifndef Taxi_h
#define Taxi_h

#include <stdio.h>
#include "Car.h"

struct Taxi;

typedef enum STATS {
    AVAILABLE,
    BUSY,
} STATS;

struct Taxi;
typedef struct Taxi *Taxi_Init_Type(struct Taxi *self);
typedef STATS Available_Type(struct Taxi *self);
typedef int Pick_Up_Type(struct Taxi *self);
typedef int Set_Off_Type(struct Taxi *self);

typedef struct Taxi_MTable {
    Car_MTable super;
    Taxi_Init_Type *init;
    Available_Type *available;
    Pick_Up_Type *pick_up;
    Set_Off_Type *set_off;
} Taxi_MTable;

Taxi_MTable *Get_Taxi_MTable();

typedef struct Taxi {
    Car super;
    void *private;
} Taxi;

#endif /* Taxi_h */
