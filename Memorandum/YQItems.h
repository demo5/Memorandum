//
//  YQItems.h
//  Memorandum
//
//  Created by YoKing on 15/12/3.
//  Copyright © 2015年 YQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQItems : NSObject

//self.memoraTitle.text,@"title",
//self.memoraInformation.text,  @"information",
//self.currentTime,  @"currentTime",
//UIImagePNGRepresentation(self.imageV.image),@"image",

/**标题*/
@property (nonatomic,copy) NSString *title;

/**信息*/
@property (nonatomic,copy) NSString *information;

/**时间*/
@property (nonatomic,copy) NSString *currentTime;

/**图片*/
@property (nonatomic,strong) UIImage *image;


-(instancetype)initWithDictionay:(NSDictionary *)dic;
+(instancetype)initWithDictionay:(NSDictionary *)dic;

+(NSArray *)questions;
@end
