//
//  main.swift
//  截取字符串
//
//  Created by 廖佩志 on 2019/2/21.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import Foundation

print("Hello, World!")

NSString * str =[[NSString alloc]initWithFormat:@"%@",@"iLanou123ios"];
NSString * str1=[str substringToIndex:3];
NSString * str2=[str substringWithRange:NSMakeRange(6, 3)];
NSString * newStr=[str1 stringByAppendingString:str2];
NSLog(@"%@",newStr);
