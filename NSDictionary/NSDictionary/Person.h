//
//  Person.h
//  NSDictionary
//
//  Created by 廖佩志 on 2019/8/8.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
-(instancetype)initWithName: (NSString *)name adddress: (NSString *)address;
-(void)print;
@end

NS_ASSUME_NONNULL_END
