//
//  Person.m
//  NSDictionary
//
//  Created by 廖佩志 on 2019/8/8.
//  Copyright © 2019 廖佩志. All rights reserved.
//

#import "Person.h"

@implementation Person

-(instancetype)initWithName:(NSString *)name adddress:(NSString *)address {
    if (self = [super init]) {
        self.name = name;
        self.address = address;
    }
    return self;
}

- (NSUInteger)hash {
    NSLog(@"hash--l");
    return [self.name hash] ^ [self.address hash];
}
- (void)print{
    NSLog(@"------%@", self.name);
}
//- (BOOL)isEqual:(id)object {
//    if (self == object) {
//        return YES;
//    }
//
//    if (![object isKindOfClass:[Person class]]) {
//        return NO;
//    }
//
//    return [self isEqualToPerson:(Person *)object];
//}

//- (BOOL)isEqualToPerson:(Person *)person {
//    if (!person) {
//        return NO;
//    }
//
//    BOOL haveEqualNames = (!self.name && !person.name) || [self.name isEqualToString:person.name];
//    BOOL haveEqualBirthdays = (!self.address && !person.address) || [self.address isEqualToDate:person.address];
//
//    return haveEqualNames && haveEqualBirthdays;
//}

@end
