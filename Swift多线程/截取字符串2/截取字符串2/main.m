//
//  main.m
//  截取字符串2
//
//  Created by 廖佩志 on 2019/2/21.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString * str =[[NSString alloc]initWithFormat:@"%@%d",@"23ios",123123];

        NSLog(@"%@",str);
        NSString * str1=[str substringToIndex:3];
        NSString * str2=[str substringWithRange:NSMakeRange(6, 3)];
        NSString * newStr=[str1 stringByAppendingString:str2];
        NSLog(@"%@",newStr);
        NSLog(@"Hello, World!");
    }
    return 0;
}
