//
//  sample_macro_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/5.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

SpecBegin(sample_macro_test)

describe(@"sample_macro_test", ^{
    it(@"can include other file not only .h files", ^{
        #import "SampleFile.txt"
        #include "SampleFile2.txt"
    });
    
    it(@"can define some macro in project configurations", ^{
        NSLog(@"MY_MACRO is %d", MY_MACRO);
    });
    
    it(@"can use # to transform a parameter to string", ^{
#define STR(arg)    #arg
        NSLog(@"%s", STR(no more qutoes));
        
#define OCSTR(arg)  @#arg
        NSLog(OCSTR(Correct?));
    });
    
    it(@"can use # with log", ^{
#define TRUE_AND_LOG(condition)                              \
    do {                                                     \
        if (condition) {                                     \
            NSLog(@"Your condition '"#condition"' is true"); \
        }                                                    \
    } while(0)
        TRUE_AND_LOG(1 + 1 == 2);
    });
});
SpecEnd
