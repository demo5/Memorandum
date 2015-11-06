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
@end

@implementation YQNewMenorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.memoraInformation.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)savaData{
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];

    NSDictionary *contentDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                self.memoraTitle.text,@"title",
                                                self.memoraInformation.text,@"information",
                                                nil];
    
    [dataArr insertObject:contentDic atIndex:0];
    
    [dataArr writeToFile:dataFilePath atomically:YES];
       
}

- (IBAction)endEditTitle:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)addMemorandum:(id)sender {
    [self savaData];
    
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
