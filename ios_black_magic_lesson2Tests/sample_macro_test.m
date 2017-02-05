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
});
SpecEnd
