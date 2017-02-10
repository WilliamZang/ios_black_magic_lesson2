//
//  macro_big_example_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/10.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

// ========基础宏部分===========
// 可变参数宏小例子1
#define ARG_AT(INDEX, ...) _ARG_AT##INDEX(__VA_ARGS__)

#define _ARG_AT0(_0, ...) _0
#define _ARG_AT1(_0, _1, ...) _1
#define _ARG_AT2(_0, _1, _2, ...) _2
#define _ARG_AT3(_0, _1, _2, _3, ...) _3
#define _ARG_AT4(_0, _1, _2, _3, _4, ...) _4
#define _ARG_AT5(_0, _1, _2, _3, _4, _5, ...) _5

// 可变参数宏小例子2
#define ARG_COUNT(...) \
ARG_AT(5, ##__VA_ARGS__, 5, 4, 3, 2, 1, 0)

// 可变参数宏小例子3
#define DEC(N)          \
ARG_AT(N, -1, 0, 1, 2, 3, 4)

#define INC(N)          \
ARG_AT(N, 1, 2, 3, 4, 5)

//#define DEC(N)    N - 1
//#define INC(N)    N + 1

// 宏的静态判断例子1
//#define IS_EQ(A, B)   A > B ? _IS_EQ(B, A) : _IS_EQ(A, B)
//#define _IS_EQ(A, B)   _CONCAT(_IS_EQ, A)(B)
#define IS_EQ(A, B)   _CONCAT(_IS_EQ, A)(B)

#define _CONCAT(A, B)   A ## B

#define _IS_EQ0(B)    _CONCAT(_IS_EQ0_, B)

#define _IS_EQ0_0   1
#define _IS_EQ0_1   0
#define _IS_EQ0_2   0
#define _IS_EQ0_3   0
#define _IS_EQ0_4   0
#define _IS_EQ0_5   0

#define _IS_EQ1(B)    _IS_EQ0(DEC(B))
#define _IS_EQ2(B)    _IS_EQ1(DEC(B))
#define _IS_EQ3(B)    _IS_EQ2(DEC(B))
#define _IS_EQ4(B)    _IS_EQ3(DEC(B))
#define _IS_EQ5(B)    _IS_EQ4(DEC(B))

// 宏的静态判断例子2

// 使用的时候IF(判断条件)(为真时候的表达式)(为假的时候的表达式)
#define IF(CONDITION)   _CONCAT(_IF, CONDITION)

#define _CONSUME(...)
#define _EXPEND(...)    __VA_ARGS__

#define _IF1(...)     __VA_ARGS__ _CONSUME
#define _IF0(...)     _EXPEND

// ===========下面是大例子=========

#define USER_PROPERTY_LIST(_)         \
_(NSString *, userName, copy)         \
_(NSDictionary *, userInfo)           \
_(NSURL *, avatar)                    \
_(NSInteger, level, assign, readonly)

#define CLASS_PROPERTY_LIST(_)    \
_(NSString *, className, copy)    \
_(NSDictionary *, classInfo)      \
_(NSArray *, students)            \
_(User *, classMonitor, weak)

#define PROPERTY_DEFINE(...)           \
  IF(IS_EQ(2, ARG_COUNT(__VA_ARGS__))) \
    (_PROPERTY_DEFINE_2(__VA_ARGS__))  \
    (_PROPERTY_DEFINE_X(__VA_ARGS__))
  
#define _PROPERTY_DEFINE_2(TYPE, NAME, ...) \
@property (nonatomic, strong) TYPE NAME;

#define _PROPERTY_DEFINE_X(TYPE, NAME, ...) \
@property (nonatomic, ##__VA_ARGS__) TYPE NAME;

@interface User : NSObject

USER_PROPERTY_LIST(PROPERTY_DEFINE)

@end

@interface User_ : NSObject

@property (nonatomic, copy) NSString * userName;
@property (nonatomic, strong) NSDictionary * userInfo;
@property (nonatomic, strong) NSURL * avatar;
@property (nonatomic, assign, readonly) NSInteger level;

@end

@interface SchoolClass : NSObject

CLASS_PROPERTY_LIST(PROPERTY_DEFINE)

@end

#define PROPERTY_NAME(_, NAME, ...) @#NAME,
#define PROPERTY_NAME_ARRAY(LIST)        \
    [NSArray arrayWithObjects: LIST(PROPERTY_NAME) nil]

SpecBegin(macro_big_example_test)

describe(@"macro_big_example_test", ^{
    it(@"should use PROPERTY_NAME_ARRAY successful", ^{
        NSArray *array = PROPERTY_NAME_ARRAY(USER_PROPERTY_LIST);
        expect(array.count).to.equal(4);
        array = [NSArray arrayWithObjects: @"userName", @"userInfo", @"avatar", @"level", nil];
    });
    
    
});

SpecEnd


