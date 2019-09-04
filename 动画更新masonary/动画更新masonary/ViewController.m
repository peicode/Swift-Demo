//
//  ViewController.m
//  动画更新masonary
//
//  Created by 廖佩志 on 2018/9/7.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
@interface ViewController ()
- (IBAction)btnClick:(id)sender;
@property(nonatomic,strong)UIView *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)updateViewConstraints{
    [self.animationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        //初始化为1
        make.width.height.mas_equalTo(1).priorityLow();
        //
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    [super updateViewConstraints];
}

- (IBAction)btnClick:(id)sender {
    UIView *aniView = [[UIView alloc]init];
    [self.view addSubview:aniView];
    self.animationView = aniView;
    [aniView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        //初始化为1
        make.width.height.mas_equalTo(1).priorityLow();
        //
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    
//    [aniView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        //初始化为1
//        make.width.height.mas_equalTo(1).priorityLow();
//        //
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(200);
//    }];

    [self.view setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
