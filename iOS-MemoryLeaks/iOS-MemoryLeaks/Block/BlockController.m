//
//  BlockController.m
//  iOS-MemoryLeaks
//
//  Created by 廖佩志 on 2019/3/27.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "BlockController.h"
#import "iOS_MemoryLeaks-Swift.h"
@interface BlockController ()

@end

@implementation BlockController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self)weakSelf = self;
    self.block = ^(NSInteger * _Nonnull age) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.name = @"lpz";
    };
    NSLog(@"%@", _name);

    //这里self和block互相引用
//    self.block = ^(NSInteger * _Nonnull age) {
//        self.address = @"Tianmen";
//        NSLog(@"%@", _address);
//    };

//    self.block = ^(NSInteger * _Nonnull age) {
//        job = @"iOS";
//    };
//    NSLog(@"cada");

}
+ (void)load {

    People *p = [[People alloc] init];

    Ivar ivar = class_getInstanceVariable([p class], "age");
    NSLog(@"%s", ivar_getName(ivar));

//    object_getIvar(, )
}
-(void)dealloc {
    NSLog(@"BlockController已经摧毁！");
}

@end
