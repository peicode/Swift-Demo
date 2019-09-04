//
//  ViewController.m
//  引用类型
//
//  Created by 廖佩志 on 2019/8/23.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *mulA = [NSMutableArray arrayWithObjects: @1,@2,@3,@4,@5, nil];

    NSMutableArray *mulB = mulA;
    [mulA insertObject:@10 atIndex:2];
//    [mulA addObject:@1];
    NSLog(@"%@ %@", mulA, mulB);
}


@end
