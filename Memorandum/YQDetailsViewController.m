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
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation YQDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更改背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.titleLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.informationTextV.backgroundColor = [UIColor clearColor];
    
    //加载数据
    [self initItemData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 *  从plist中读取数据
 */
-(void)initItemData{
    
    //获取文件
    NSArray *itemArr = [[NSMutableArray alloc] initWithContentsOfFile:dataFilePath];
    
    //获取标题
    NSString *title = [[itemArr valueForKey:@"title"] objectAtIndex:self.index];
    if (title) {
        self.titleLable.text = title;
    }
    
    //获取商品描述
    NSString *information = [[itemArr valueForKey:@"information"] objectAtIndex:self.index];
    if (information) {
        self.informationTextV.text = information;
    }
    //获取图片
    NSData *imageD = [[itemArr valueForKey:@"image"] objectAtIndex:self.index];
    if (imageD) {
        UIImage *image = [UIImage imageWithData:imageD];
        self.imageV.image = image;
    }
    //获取语音
}


@end
