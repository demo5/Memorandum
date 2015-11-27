//
//  YQNewMenorViewController.m
//  Memorandum
//
//  Created by YoKing on 15/11/3.
//  Copyright © 2015年 YQ. All rights reserved.
//  新建备忘项

#import "YQNewMenorViewController.h"
#import "YQMainTableViewController.h"
#import "YQComposeToolba.h"
@interface YQNewMenorViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate,YQComposeToolbaDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addMemorandum;//完成按钮
@property (weak, nonatomic) IBOutlet UITextField *memoraTitle;//标题
@property (weak, nonatomic) IBOutlet UITextView *memoraInformation;//备忘信息
@property (weak, nonatomic) IBOutlet UILabel *placeholderLable;//提示文本
@property (weak, nonatomic) IBOutlet UIImageView *imageV;//图片

@property (nonatomic,copy) NSMutableArray *_dataArr;//储存数据的数组
@property NSString  *currentTime;//时间
@property (nonatomic ,assign) BOOL *takePhoto;//判断是否选择了照片
@property(nonatomic ,weak)YQComposeToolba *toolbar;
@end

@implementation YQNewMenorViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.takePhoto = NO;
    self.memoraInformation.delegate = self;
    self.memoraInformation.alwaysBounceVertical = YES;
    
    [self.memoraInformation addSubview:self.placeholderLable];
    //设置背景色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.memoraInformation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.memoraTitle.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //为添加图片添加手势操作
    [self.addMemorandum setEnabled:NO];
    UITapGestureRecognizer *addPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addPhoto)];
    [self.imageV addGestureRecognizer:addPhoto];
    
    [self setupToolBar];//添加工具条
    self.memoraTitle.inputAccessoryView = self.toolbar;
    self.memoraInformation.inputAccessoryView = self.toolbar;

}
#pragma mark - 初始化方法
/**
 *  添加工具条
 */
-(void)setupToolBar{
    YQComposeToolba *toolbar = [[YQComposeToolba alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    
    toolbar.delegate = self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}
#pragma mark - 添加照片的操作
/**
 *  弹出选择框
 */
-(void)addPhoto{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册选取" otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:self.view];
}
/**
 *  选取照片的方式
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if (buttonIndex != 2) {
        if (buttonIndex == 0) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        picker.delegate = self;
        [self presentViewController:picker animated:true completion:nil];
    }
    
}
/**
 *  选择照片后的操作
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

   
    self.imageV.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"] ;
    self.takePhoto = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  储存数据
 */
-(void)savaData{
    
    //获取系统当前时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    self.currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    //创建存储的数据(字典类型)
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.memoraTitle.text,@"title",
                            self.memoraInformation.text,@"information",
//                            UIImagePNGRepresentation(self.imageV.image),@"image",
                            self.currentTime,@"currentTime",
                            nil];
    if (self.takePhoto) {
        [contentDic setValue:UIImagePNGRepresentation(self.imageV.image) forKey:@"image"];
    }
    else{
        [contentDic setValue:UIImagePNGRepresentation([UIImage imageNamed:@"background"]) forKey:@"image"];
    }
    //创建存储的数组
    NSMutableArray *dataArray =[NSMutableArray arrayWithContentsOfFile:dataFilePath];
    if (!dataArray) {
        dataArray =[NSMutableArray array];
    }
    [dataArray insertObject:contentDic atIndex:0];
    [dataArray writeToFile:dataFilePath atomically:YES];
}

/**
 *  取消编辑状态
 */
- (IBAction)endEditTitle:(id)sender
{
    [self.view endEditing:YES];
    [sender resignFirstResponder];
}

/**
 *  保存新增信息
 */
- (IBAction)addMemorandum:(id)sender {
  
    //保存数据
    [self savaData];
    /**
     *  返回主页面
     */
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textView should editing
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.placeholderLable.text = @"";
    self.placeholderLable.backgroundColor = [UIColor clearColor];
    self.placeholderLable.enabled = NO;
   
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    //判断标题和内容是否为空，不为空则可以添加此条记录
    if (![self.memoraTitle.text  isEqual: @""] || ![self.memoraInformation.text isEqual:@""]) {
        
        [self.addMemorandum setEnabled:YES];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{

    if (self.memoraInformation.text.length == 0) {
        self.placeholderLable.text = @"点击这里添加内容";
    }
    [self.memoraInformation resignFirstResponder];
    
    }
#pragma mark - uiscroll view delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark -- 键盘的操作


@end
