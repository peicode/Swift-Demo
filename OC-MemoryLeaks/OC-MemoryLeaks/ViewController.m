//
//  ViewController.m
//  OC-MemoryLeaks
//
//  Created by 廖佩志 on 2019/3/28.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.block = ^(NSInteger * _Nonnull age) {
        _name = @"lpz";
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
-(void)dealloc {
    NSLog(@"BlockController已经摧毁！");
}


@end
