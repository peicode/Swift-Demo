//
//  ViewController.h
//  OC-MemoryLeaks
//
//  Created by 廖佩志 on 2019/3/28.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Myblock)(NSInteger * age);

@interface ViewController : UIViewController
{
    //默认是__strong修饰 ==>__strong NSString *job;
    NSString *job;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) Myblock block;
@end

