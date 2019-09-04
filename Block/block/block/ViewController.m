//
//  ViewController.m
//  block
//
//  Created by 廖佩志 on 2019/8/21.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __block NSString *str;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            str = [NSString stringWithFormat:@"1234567890"];
        });
    }

//    __block NSString *str;
//
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(queue, ^{
//            str = [NSString stringWithFormat:@"123456789"];
//        });
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

@end
