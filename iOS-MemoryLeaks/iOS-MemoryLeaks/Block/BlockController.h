//
//  BlockController.h
//  iOS-MemoryLeaks
//
//  Created by 廖佩志 on 2019/3/27.
//  Copyright © 2019 廖佩志. All rights reserved.
//
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^Myblock)(NSInteger * age);
@interface BlockController : UIViewController
{
    //默认是__strong修饰 ==>__strong NSString *job;
    NSString *job;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) Myblock block;
@end
NS_ASSUME_NONNULL_END
