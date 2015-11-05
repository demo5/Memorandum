//
//  YQDetailsViewController.m
//  Memorandum
//
//  Created by YoKing on 15/11/3.
//  Copyright © 2015年 YQ. All rights reserved.
//  选中备忘项的详细信息

#import "YQDetailsViewController.h"

@interface YQDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextView *informationTextV;

@end

@implementation YQDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initItemData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  从plist中读取数据
 */
-(void)initItemData{
    
    //获取文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSArray *itemArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    //获取标题
    NSString *title = [[itemArr valueForKey:@"title"] objectAtIndex:self.index];
    self.titleLable.text = title;
    
    //获取商品描述
    NSString *information = [[itemArr valueForKey:@"information"] objectAtIndex:self.index];
    self.informationTextV.text = information;
    
    //获取图片
    
    //获取语音
}


@end
