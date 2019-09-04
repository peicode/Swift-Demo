//
//  ViewController.m
//  OC内存管理
//
//  Created by 廖佩志 on 2019/4/16.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, retain)NSNumber *count;
@end

@implementation ViewController{
    NSObject * obj2;
}
/*
 谁持有，谁释放；
 向已经释放的对象，调用release，程序会崩溃
 id obj2 = [obj object];
 [obj2 release];
 或者没有持有对象，调用release，也会崩溃
*/
- (void)viewDidLoad {
    [super viewDidLoad];

    NSObject * obj = [[NSObject alloc] init];
    obj2 = obj;
    NSLog(@"%lu", (unsigned long)obj2.retainCount);
//    [obj autorelease];
    NSLog(@"%lu", (unsigned long)obj.retainCount);
    [obj release];

    UIView *view = [[UIView alloc] init];
    NSLog(@"view--%lu", (unsigned long)view.retainCount);
    UILabel *label = [[UILabel alloc] init];
    NSLog(@"label--%lu", (unsigned long)label.retainCount);

    [view addSubview:label];
    NSLog(@"view--%lu", (unsigned long)view.retainCount);
    NSLog(@"label--%lu", (unsigned long)label.retainCount);

    [view release];
//    NSLog(@"view--%lu", (unsigned long)view.retainCount);
    NSLog(@"label--%lu", (unsigned long)label.retainCount);


    [self aboutNSNumber];

    NSObject* object1 = [NSMutableArray array];
    NSLog(@"%ld", object1.retainCount);
}
// 常量不会有引用计数，因为在常量区，不需要回收。无论你是retain和release都没有影响
- (void)aboutNSNumber {
    // 因为int为常量，
    NSNumber *number = [NSNumber numberWithInt: 1];
    [self setCount:number];
    NSLog(@"count--%ld", _count.retainCount);
    NSLog(@"number--%ld", number.retainCount);

    NSNumber *num2 = [[NSNumber alloc] initWithInteger: 1];

    [self setCount:num2];

    NSLog(@"count2--%ld", _count.retainCount);
    NSLog(@"num2--%ld", num2.retainCount);
}

- (void)aboutNSString {
    //
    NSString *str = [[NSString alloc] init];
    NSLog(@"str--%ld", str.retainCount);
    [str retain];
    NSLog(@"str--%ld", str.retainCount);
    // 因为字符串为常量 所以不会对其进行j引用计数，无论是retain还是release，都无法改变
    NSString *str1 = @"12312313131331311";
    NSLog(@"str1--%ld", str1.retainCount);
    NSString *str2 = @"31331311";
    NSLog(@"str2--%ld", str2.retainCount);
}

- (void)aboutNSAutoReleasePool {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [pool drain];
}
- (void)dealloc {
    [super dealloc];
    NSLog(@"%lu", (unsigned long)obj2.retainCount);
}

@end

