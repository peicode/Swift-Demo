//
//  ViewController.m
//  NSThread
//
//  Created by 廖佩志 on 2019/8/26.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSThread * thread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)test2 {
    NSLog(@"3");
}
- (void)test {
//    [self test2];
    NSLog(@"2");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode: NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
//        NSLog(@"zzzzz%@", [NSRunLoop currentRunLoop]);
    }];

    [thread start];

    [self performSelector:@selector(test) onThread: thread withObject:nil waitUntilDone: YES];
    NSLog(@"123");
//    NSLog(@"%@", self.thread);
//    [];
//    [self performSelectorInBackground:@selector(test) withObject:nil];
}

@end
