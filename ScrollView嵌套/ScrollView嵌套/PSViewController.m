//
//  PSViewController.m
//  ScrollView嵌套
//
//  Created by 廖佩志 on 2018/9/5.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

#import "PSViewController.h"

@interface PSViewController ()<UIScrollViewDelegate>
@property(nonatomic,assign)CGRect beganFrame;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation PSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat scale = MIN(1.0, MAX(0.3,1 - offsetY/_beganFrame.size.height));
    //
    CGFloat width = _beganFrame.size.width *scale;
    CGFloat height = _beganFrame.size.height *scale;
    //这里是随便写的数据，
    CGFloat y = _beganFrame.size.width - offsetY;
    CGFloat x = offsetY;
    //设置imageView的frame和alpha
    _imageView.frame = CGRectMake(x, y, width, height);
    _imageView.alpha = scale * scale;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
