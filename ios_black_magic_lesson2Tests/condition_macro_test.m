//
//  condition_macro3_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/9.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

// 普通的宏判断
#define HAS_FLAG

#ifdef HAS_FLAG
#define VALUE 5
#else
#define VALUE 6
#endif

#if 15 > 3
#define VALUE2 5
#else
#define VALUE2 1
#endif

// 可变参数宏小例子1
#define ARG_AT(INDEX, ...) _ARG_AT##INDEX(__VA_ARGS__)

#define _ARG_ATX(...)   X
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
  ARG_AT(N, X, 0, 1, 2, 3, 4)

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

#define _IS_EQ0_X   0
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

SpecBegin(condition_macro_test)

describe(@"condition_macro_test", ^{
    it(@"should find element at args", ^{
        int value = ARG_AT(3, 100, 200, 300, 400);
        expect(value).to.equal(400);
    });
    
    it(@"should get args count", ^{
        int count = ARG_COUNT(10, 20, 30, 40);
        expect(count).to.equal(4);
        count = ARG_COUNT();
        expect(count).to.equal(0);
    });
    
    it(@"should dec or inc by macros", ^{
        int value = DEC(4);
        expect(value).to.equal(3);
        value = INC(1);
        expect(value).to.equal(2);
    });
    
    it(@"can static condition in preprocess", ^{
        int zeroOrOne = IS_EQ(5, 2);
        expect(zeroOrOne).to.equal(0);
        zeroOrOne = IS_EQ(3, 3);
        expect(zeroOrOne).to.equal(1);
    });
    
    it(@"can use if to choose follow expressions", ^{
        CGPoint point = CGPointMake(IF(IS_EQ(3, 4))(1, 2)(18, 22));
        expect(point.x).to.equal(18);
        expect(point.y).to.equal(22);
        CGPoint point2 = CGPointMake(IF(IS_EQ(4, 4))(1, 2)(18, 22));
        expect(point2.x).to.equal(1);
        expect(point2.y).to.equal(2);
    });
    
    it(@"cannot use macro condition for runtime", ^{
//        int a = 0, b = 1;
//        int zeroOrOne = IS_EQ(a, b);
    });
});

SpecEnd
