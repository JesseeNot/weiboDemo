//
//  ZYHModel.h
//  wbOrwc
//
//  Created by 张云皓 on 16/2/11.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dic;

/***创建时间*/
@property (copy, nonatomic) NSString *created_at;

/***文字信息*/
@property (copy, nonatomic) NSString *text;

/***用户信息*/
@property (strong, nonatomic) NSDictionary *user;

/***多图的时候装地址数组，数组中每个元素都是字典对应thumbnail_pic*/
@property (strong, nonatomic) NSArray *pic_urls;

@property (assign, nonatomic) NSInteger *textLength;

/***缩略图*/
@property (copy, nonatomic) NSString *thumbnail_pic;

/***原图*/
@property (copy, nonatomic) NSString *original_pic;

@end
