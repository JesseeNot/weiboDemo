//
//  ZYHModel.m
//  wbOrwc
//
//  Created by 张云皓 on 16/2/11.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZYHModel.h"

@implementation ZYHModel

- (instancetype)initWithDict:(NSDictionary *)dic{
    if (self = [self init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
}

@end
