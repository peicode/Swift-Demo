//
//  ViewController.m
//  NSDictionary
//
//  Created by 廖佩志 on 2019/8/6.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //局部变量存储在栈区，由高向低分配地址
    NSString *test1 = @"qewqeqw";
    NSString *test = @"1234";
    NSString *test3 = @"dddddd";
    NSString *test2 = @"1234555";
    int a = 12;
    //cls 持有 Person类对象；表示Person本身，是个类对象
    id cls = [Person class];
    NSString *test6 = @"1234555www";
    Person *p = [[Person alloc]init];
    Person *p1 = [[Person alloc] init];
//    [cls print];
//    id ccc = [Person superclass];
    //C语言的obj指针指向cls的内存地址
    void *obj = &cls;
//    void *obj = (__bridge void *)(cls);
    //obj强转为id指针
//    [(__bridge id)obj print];
    NSLog(@"%@", (__bridge id)obj);
    [(__bridge id)obj print];


//    NSLog(@"%@",self.description);

//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    [dict setValue:@"lpz" forKey:@"name"];
//    [dict setValue:@"hubei" forKey:@"adress"];

//    CFDictionaryRef dic = CFDictionaryCreate(CFAllocatorRef , CFAllocatorGetDefault(), <#const void **values#>, <#CFIndex numValues#>, <#const CFDictionaryKeyCallBacks *keyCallBacks#>, const CFDictionaryValueCallBacks *valueCallBacks);
//    (__bridge_retained void *)__CfDictionry;


//    Person *p = [[Person alloc] init];
//    NSMutableSet * mulSet = [NSMutableSet set];
//    [mulSet addObject:p];
//
//    NSArray *array = [NSArray arrayWithObjects: @1,@2,@3,@4, nil];
//    NSSet *set = [NSSet setWithArray: array];

}
@end
