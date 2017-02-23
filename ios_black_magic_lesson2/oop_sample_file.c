//
//  oop_sample_file.c
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/22.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

// 该文件存放课件中用到的一些不成体系的举例，不保证可用


typedef struct ClassA {
    int property1;
    float property2;
} ClassA;

typedef struct Student {
    int age;
    float height;
    float weight;
    int level;
} Student;

typedef void Arrest(Student student);


typedef struct Police_Officer {
    Arrest *arrest;
} Police_Officer;

void arrest_student(Police_Officer police, Student student) {
    
}

void test() {
    ClassA instanceA = {
        .property1 = 1,
        .property2 = 1.5f
    };
    ClassA instanceB = {
        .property1 = 15,
        .property2 = 2.5f
    };
    
    
    Student a_student = {
        .age = 19
    };
    
    Police_Officer a_police_officer;
    a_police_officer.arrest(a_student);
    
    arrest_student(a_police_officer, a_student);
}

typedef int User;

// 方法存于全局空间

void police_arrest(Police_Officer *police, User *somebody);
void police_call_partner(Police_Officer *police, Police_Officer *another);
int police_level(Police_Officer *police);

// 方法存于实例
struct Police_Man;
struct Thief;

typedef void Arrest_Type(struct Police_Man *self, struct Thief *thief);
typedef void Call_Partner_Type(struct Police_Man *self, struct Police_Man *partner);

//typedef struct Police_Man {
//    Arrest_Type *arrest;
//    Call_Partner_Type *call_partner;
//    int police_id;
//} Police_Man;

// 方法存于类

typedef struct Police_Man_MTable {
    Arrest_Type *arrest;
    Call_Partner_Type *call_partner;
} Police_Man_MTable;

typedef struct Police_Man {
    Police_Man_MTable *mtable;
    int police_id;
} Police_Man;

Police_Man_MTable global_police_man_mtable;

// 封装性

void arrest_imp(struct Police_Man *self, struct Thief *thief) {
    printf("arrest a thief!\n");
}

void call_parnter_imp(struct Police_Man *self, struct Police_Man *partner) {
    printf("call another police man!\n");
}

Police_Man_MTable global_police_man_mtable = {
    .arrest = arrest_imp,
    .call_partner = call_parnter_imp
};

Police_Man *new_police_man() {
    Police_Man *new_obj = (Police_Man *)malloc(sizeof(Police_Man));
    new_obj->mtable = &global_police_man_mtable;
    static int auto_increase_id = 0;
    new_obj->police_id = ++auto_increase_id;
    return new_obj;
}

void test1() {
    Police_Man *police_man = NULL;
    struct Thief *thief = NULL;
    police_man->mtable->arrest(police_man, thief);
    int id = police_man->police_id;
    free(police_man);
}
// Thief.h

typedef void Dealloc_Type(struct Thief *self);
typedef int Tools_Count_Type(struct Thief *self);

typedef struct Thief_MTable {
    Dealloc_Type *dealloc;
    Tools_Count_Type *tools_count;
} Thief_MTable;

Thief_MTable global_thief_mtable;

typedef struct Thief {
    struct Thief_MTable *mtable;
    float money;
    void *private;
} Thief;

// Thief.c

typedef struct Thief_Private_Data {
    int tools_count;
} Thief_Private_Data;

typedef struct Thief_Private {
    struct Thief_MTable *mtable;
    float money;
    Thief_Private_Data *private;
} Thief_Private;

Thief *new_thief() {
    Thief_Private *new_obj = (Thief_Private *)malloc(sizeof(Thief_Private));
    new_obj->mtable = &global_thief_mtable;
    new_obj->private = (Thief_Private_Data *)malloc(sizeof(Thief_Private_Data));
    return (Thief *)new_obj;
}

void thief_dealloc(struct Thief_Private *self) {
    free(self->private);
    free(self);
}

int thief_tools_count(struct Thief_Private *self) {
    return self->private->tools_count;
}

void private_thief_method(struct Thief_Private *self) {
    printf("I have %d tools, it's a secret", self->private->tools_count);
}

Thief_MTable global_thief_mtable = {
    .dealloc = (Dealloc_Type *)thief_dealloc,
    .tools_count = (Tools_Count_Type *)thief_tools_count
};

// 继承性
struct Car;
typedef void Car_Dealloc_Type(struct Car *self);
typedef void Drive_Type(struct Car *self, int meter);
typedef int DriveTimes_Type(struct Car *self);
typedef const char *Color_Type(struct Car *self);

typedef struct Car_MTable {
    Car_Dealloc_Type *dealloc;
    Drive_Type *drive;
    DriveTimes_Type *drive_times;
    Color_Type *color;
} Car_MTable;

Car_MTable global_car_mtable;

typedef struct Car {
    Car_MTable *mtable;
    int total_meters;
    void *private;
} Car;

typedef struct Taxi *Taxi_Init_Type(struct Taxi *self);
typedef int Available_Type(struct Taxi *self);
typedef int Pick_Up_Type(struct Taxi *self);
typedef int Set_Off_Type(struct Taxi *self);

typedef struct Taxi_MTable {
    Car_MTable super;
    Taxi_Init_Type *init;
    Available_Type *available;
    Pick_Up_Type *pick_up;
    Set_Off_Type *set_off;
} Taxi_MTable;

Taxi_MTable global_taxi_mtable;
typedef struct Taxi {
    Car super;
    float change;
    void *private;
} Taxi;

void taxi_drive(Taxi *self, int meters) {
    global_car_mtable.drive((Car *)self, meters);
    self->change += meters;
}

Taxi *new_taxi() {
    Taxi *new_obj = (Taxi *)malloc(sizeof(Taxi));
    ((Car *)new_obj)->mtable = (Car_MTable *)&global_taxi_mtable;
    global_taxi_mtable.super.drive = (Drive_Type *)taxi_drive;
    return new_obj;
}

Car *new_car();

void test2() {
    Taxi *taxi = (Taxi *)malloc(sizeof(Taxi));
    ((Car *)taxi)->mtable->drive((Car *)taxi, 15);
    ((Taxi_MTable *)((Car *)taxi)->mtable)->pick_up(taxi);
}

void test3() {
    Taxi *taxi = new_taxi();
    Car *car = new_car();
    ((Car *)taxi)->mtable->drive((Car *)taxi, 15);
    car->mtable->drive(car, 17);
}
