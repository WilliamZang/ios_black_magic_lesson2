//
//  condition_macro3_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/9.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

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

#define ARG_AT(INDEX, ...) _ARG_AT##INDEX(__VA_ARGS__)

#define _ARG_AT0(_0, ...) _0
#define _ARG_AT1(_0, _1, ...) _1
#define _ARG_AT2(_0, _1, _2, ...) _2
#define _ARG_AT3(_0, _1, _2, _3, ...) _3
#define _ARG_AT4(_0, _1, _2, _3, _4, ...) _4
#define _ARG_AT5(_0, _1, _2, _3, _4, _5, ...) _5

#define ARG_COUNT(...) \
  ARG_AT(5, ##__VA_ARGS__, 5, 4, 3, 2, 1, 0)

#define DEC(N)          \
  ARG_AT(N, -1, 0, 1, 2, 3, 4)

#define INC(N)          \
  ARG_AT(N, 1, 2, 3, 4, 5)

//#define DEC(N)    N - 1
//#define INC(N)    N + 1

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
});

SpecEnd
