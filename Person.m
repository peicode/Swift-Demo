//
//  Person.m
//  
//
//  Created by 廖佩志 on 2019/8/6.
//

#import "Person.h"

@implementation Person

- (void)init{
    NSDictionary *dict = [NSDictionary new];
    [dict setValue:@"lpz" forKey:@"name"];
    [dict setValue:@"hubei" forKey:@"adress"];
}


@end
