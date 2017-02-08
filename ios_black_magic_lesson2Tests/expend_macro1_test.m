//
//  expend_macro1_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/8.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#define TYPE_FLAG_LIST(_)               \
            _(TYPE_A)                   \
            _(TYPE_B)                   \
            _(TYPE_C)                   \
            _(TYPE_D)                   \
            _(TYPE_E)                   \
            _(TYPE_F)

#define ENUM_ELEMENT(FLAG)  FLAG,

typedef enum : NSUInteger {
    TYPE_FLAG_LIST(ENUM_ELEMENT)
    TYPE_TOTAL
} EnumTypeNum;

#undef ENUM_ELEMENT

#define FLAG_VALUE(FLAG)    FLAG##_FLAG

#define ENUM_ELEMENT(FLAG)  FLAG_VALUE(FLAG) = 1 << FLAG,

typedef enum : NSUInteger {
    TYPE_FLAG_LIST(ENUM_ELEMENT)
    TYPE_0_FLAG = 0
} EnumType;

#undef ENUM_ELEMENT

#define CHECK_UINT(FLAG)                \
   if(uint_value & FLAG_VALUE(FLAG)) {  \
        NSLog(@"Has " #FLAG"_FLAG");    \
   }

void check_uint_value(NSUInteger uint_value) {
    TYPE_FLAG_LIST(CHECK_UINT)
}

#undef CHECK_UINT


SpecBegin(expend_macro1_test)

describe(@"expend_macro1_test", ^{
    it(@"should check uint successful", ^{
        NSUInteger value = TYPE_A_FLAG|TYPE_C_FLAG|TYPE_F_FLAG;
        check_uint_value(value);
    });
});

SpecEnd


