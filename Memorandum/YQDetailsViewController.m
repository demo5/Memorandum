//
//  YQDetailsViewController.m
//  Memorandum
//
//  Created by YoKing on 15/11/3.
//  Copyright © 2015年 YQ. All rights reserved.
//

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
    
    NSLog(@"%ld",(long)self.index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initItemData{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSArray *itemArr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    NSArray *titlt = [itemArr valueForKey:@"title"];
   
    NSString *str = [titlt objectAtIndex:self.index];
   self.titleLable.text = str;
}


@end
