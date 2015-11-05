//
//  YQMainTableViewController.h
//  Memorandum
//
//  Created by YoKing on 15/11/1.
//  Copyright © 2015年 YQ. All rights reserved.
//  显示所有备忘录的主页面


#import <UIKit/UIKit.h>

@interface YQMainTableViewController : UITableViewController

@property (retain,nonatomic) NSMutableArray *itemArr;

/**
 *  初始化数据
 */
-(void)initItemData;
@end
