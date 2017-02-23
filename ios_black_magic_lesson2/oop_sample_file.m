//
//  oop_sample_file.m
//  ios_black_magic_lesson2
//
//  Created by Chengwei Zang on 2017/2/22.
//  Copyright © 2017年 Chengwei Zang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 该文件存放课件中用到的一些不成体系的举例，不保证可用

@class Student;
@interface PoliceOfficer : NSObject

- (void)arrest:(Student *)student;

@end
void test_oc() {
    Student *student = nil;
    PoliceOfficer *policeOfficer = [[PoliceOfficer alloc] init];
    [policeOfficer arrest:student];
}
