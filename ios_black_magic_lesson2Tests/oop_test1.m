//
//  oop_test1.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/20.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>


#include "Car.h"
#include "Taxi.h"

SpecBegin(car_test)

describe(@"car_test", ^{
    it(@"should create a car with old_total_meters", ^{
        Car *car = NEW_INSTANCE(Car, 15);
        expect(car->total_meters).to.equal(15);
        CALL(car, Object, dealloc);
    });
    
    it(@"should can drive and meter is grown up", ^{
        Car *car = NEW_INSTANCE(Car, 15);
        CALL(car, Car, drive, 5);
        expect(car->total_meters).to.equal(20);
        CALL(car, Object, dealloc);
    });
    
    it(@"should record the driving times", ^{
        Car *car = NEW_INSTANCE(Car, 15);
        CALL(car, Car, drive, 15);
        int drive_times = CALL(car, Car, drive_times);
        expect(drive_times).to.equal(1);
        CALL(car, Car, drive, 15);
        drive_times = CALL(car, Car, drive_times);
        expect(drive_times).to.equal(2);
        CALL(car, Object, dealloc);
    });
    
    it(@"can invoke dealloc method in subclass", ^{
        Car *car = NEW_INSTANCE(Car, 15);
        expect(Global_Car_Count).to.equal(1);
        CALL(car, Object, dealloc);
        expect(Global_Car_Count).to.equal(0);
    });
    
    it(@"can invoke super class method", ^{
        Taxi *taxi = NEW_INSTANCE(Taxi);
        CALL(taxi, Taxi, pick_up);
        expect(Global_Car_Count).to.equal(1);
        CALL(taxi, Object, dealloc);
        expect(Global_Car_Count).to.equal(0);
    });
    
    it(@"should have polymorphism method", ^{
        Taxi *taxi = NEW_INSTANCE(Taxi);
        Car *car = NEW_INSTANCE(Car, 15);
        Car *taxi_for_cat_pointer = (Car *)taxi;
        const char *color1 = CALL(car, Car, color);
        expect([NSString stringWithUTF8String:color1]).to.equal(@"unknown");
        const char *color2 = CALL(taxi_for_cat_pointer, Car, color);
        expect([NSString stringWithUTF8String:color2]).to.equal(@"yellow");
        CALL(taxi, Object, dealloc);
        CALL(car, Object, dealloc);
        
    });
});

SpecEnd
