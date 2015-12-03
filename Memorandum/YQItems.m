//
//  YQItems.m
//  Memorandum
//
//  Created by YoKing on 15/12/3.
//  Copyright © 2015年 YQ. All rights reserved.
//

#import "YQItems.h"

@implementation YQItems



-(instancetype)initWithDictionay:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        self.title = dic[@"title"];
        self.information = dic[@"information"];
        self.image = dic[@"image"];
        self.currentTime = dic[@"currentTime"];
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)initWithDictionay:(NSDictionary *)dic{
    
    return [[self alloc] initWithDictionay:dic];

}

+(NSArray *)questions{
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:dataFilePath];
    
    if(nil == array) {
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:dataFilePath contents:nil attributes:nil];
        
        array = [[NSMutableArray alloc] init];
    }
    
    return array;
}
@end
