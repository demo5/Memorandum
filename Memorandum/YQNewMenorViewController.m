//
//  YQNewMenorViewController.m
//  Memorandum
//
//  Created by YoKing on 15/11/3.
//  Copyright © 2015年 YQ. All rights reserved.
//  新建备忘项

#import "YQNewMenorViewController.h"

@interface YQNewMenorViewController ()<UITextViewDelegate>
{
//    NSMutableArray *dataArr;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addMemorandum;
@property (weak, nonatomic) IBOutlet UITextField *memoraTitle;
@property (weak, nonatomic) IBOutlet UITextView *memoraInformation;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLable;

@property (nonatomic,copy) NSMutableArray *_dataArr;
@property NSString  *currentTime;
@end

@implementation YQNewMenorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.memoraInformation.delegate = self;
    
}

-(void)savaData{
    
    //获取系统当前时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    self.currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    //创建存储的数据(字典类型)
    NSDictionary *contentDic = [[NSDictionary alloc] initWithObjectsAndKeys:self.memoraTitle.text,@"title",
                            self.memoraInformation.text,@"information",
                            self.currentTime,@"currentTime",
                            nil];
    //创建存储的数组
    
    NSMutableArray *dataArray =[NSMutableArray arrayWithContentsOfFile:dataFilePath];
    if (!dataArray) {
        dataArray =[NSMutableArray array];
    }
    [dataArray insertObject:contentDic atIndex:0];
    [dataArray writeToFile:dataFilePath atomically:YES];
//    NSLog(@"%@",dataArray);
}

- (IBAction)endEditTitle:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)addMemorandum:(id)sender {
    
    
    
    
    
    //保存数据
    [self savaData];
    
    
    //点击完成时弹出警告  告诉用户完成添加
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"添加完成" message:@"您已经成功添加此条信息" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    
    [alerView show];
}

#pragma mark - textView should editing
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    self.placeholderLable.text = @"";
    self.placeholderLable.backgroundColor = [UIColor clearColor];
    self.placeholderLable.enabled = NO;
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{

    if (self.memoraInformation.text.length == 0) {
        self.placeholderLable.text = @"点击这里添加内容";
    }
    [self.memoraInformation resignFirstResponder];
}

@end
