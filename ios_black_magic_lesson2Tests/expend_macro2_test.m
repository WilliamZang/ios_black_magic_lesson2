//
//  expend_macro2_test.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/9.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <Specta/Specta.h>
#import <Mantle/Mantle.h>

#define SOME_CLASS_PROPERTY_LIST(_) \
  _(NSString, property1)            \
  _(NSDictionary, property2)        \
  _(NSURL, property3)

#define PROPERTY_DEFINE(TYPE, NAME) \
  @property (nonatomic, strong) TYPE * NAME;

@interface SomeClass : MTLModel <MTLJSONSerializing>

SOME_CLASS_PROPERTY_LIST(PROPERTY_DEFINE)
@property (nonatomic, strong) NSString * property11;
@end

#define KEY_PATH(CLASS, PATH)           \
(((void)(NO && ((void)[CLASS new].PATH, NO)), @# PATH))


@implementation SomeClass

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             KEY_PATH(SomeClass, property1): @"property_1",
             KEY_PATH(SomeClass, property2): @"property_2",
             KEY_PATH(SomeClass, property3): @"property_3"
             };
}

@end

SpecBegin(expend_macro2_test)

describe(@"expend_macro2_test", ^{
    it(@"should implement a class shortly", ^{
        NSError *error = nil;
        NSDictionary *dictionary = @{@"property_1": @"ABC",
                                     @"property_2": @{@"a": @"b"},
                                     @"property_3": @"http://google.com"};
        
        SomeClass *instance = [MTLJSONAdapter modelOfClass:[SomeClass class]
                                        fromJSONDictionary:dictionary
                                                     error:&error];
        expect(error).beNil();
        expect(instance.property1).to.equal(@"ABC");
        expect(instance.property2).to.equal(@{@"a": @"b"});
        expect(instance.property3).to.equal([NSURL URLWithString:@"http://google.com"]);
    });
});

SpecEnd
