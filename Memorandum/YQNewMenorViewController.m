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
#import "YQItems.h"
@interface YQNewMenorViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate,YQComposeToolbaDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addMemorandum;//完成按钮
@property (weak, nonatomic) IBOutlet UITextField *memoraTitle;//标题
@property (weak, nonatomic) IBOutlet UITextView *memoraInformation;//备忘信息
@property (weak, nonatomic) IBOutlet UILabel *placeholderLable;//提示文本
@property (weak, nonatomic) IBOutlet UIImageView *imageV;//图片
@property (nonatomic,strong) YQItems *items;
@property (nonatomic,copy) NSMutableArray *_dataArr;//储存数据的数组
@property NSString  *currentTime;//时间
//@property (nonatomic ,assign) BOOL *takePhoto;//判断是否选择了照片
@property(nonatomic ,weak)YQComposeToolba *toolbar;

@property (nonatomic,assign) BOOL  isSwitchKeyboard; //判断时候正在切换键盘
@end

@implementation YQNewMenorViewController
#pragma mark - 初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initMeminformationText]; //设置输入框
    
    [self setupToolBar];//添加工具条
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChanggeFarme:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
-(void)initMeminformationText{
    self.memoraInformation.delegate = self;
    self.memoraInformation.alwaysBounceVertical = YES;
    
    [self.memoraInformation addSubview:self.placeholderLable];
    //设置背景色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.memoraInformation.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.memoraTitle.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self.memoraTitle becomeFirstResponder];
    
    //添加工具条
    self.memoraInformation.inputAccessoryView = self.toolbar;
    self.memoraTitle.inputAccessoryView = self.toolbar;
}
/**
 *  添加工具条
 */
-(void)setupToolBar{
    YQComposeToolba *toolbar = [[YQComposeToolba alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    
    toolbar.delegate = self;
    self.toolbar = toolbar;
}
#pragma mark- 监听方法
-(void)keyBoardWillChanggeFarme:(NSNotification *)notification{
    
    //如果正在切换键盘 ，则不改变工具条的位置
    if(self.isSwitchKeyboard) return;
    
    NSDictionary *userInfo = notification.userInfo;
    //动画持续时间
    double dutation = [userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:dutation animations:^{
        if (keyboardF.origin.y > self.view.height) {
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }
    }];
    
}

#pragma mark - 添加照片的操作
/**
 *  选择照片后的操作
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
 
    self.imageV.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"] ;
//    self.takePhoto = true;
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
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                            self.memoraTitle.text,@"title",
                            self.memoraInformation.text,  @"information",
                            self.currentTime,  @"currentTime",
                            UIImagePNGRepresentation(self.imageV.image),@"image",
                            nil];
    //创建存储的数组
    NSMutableArray *dataArray =[NSMutableArray arrayWithContentsOfFile:dataFilePath];
    
    
    if (!dataArray) {
        dataArray =[NSMutableArray array];
    }
    [dataArray insertObject:contentDic   atIndex:0];
    
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
    /**返回主页面*/
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
-(void)composeToolBar:(YQComposeToolba *)toolbar didClickButton:(YQComposeToolbarButtonType)buttonType{
    switch (buttonType) {
        case YQComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case YQComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
//        case YQComposeToolbarButtonTypeVoice:
//            [self enmotionKeyboard];
//            break;
        case YQComposeToolbarButtonTypeKeyboardDown:
            [self.view endEditing:YES];
            break;
            
        default:
            break;
    }
}
-(void)openCamera{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];

}
-(void)openAlbum{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
-(void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.sourceType = type;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
    
}

/**
 *  表情键盘
 */
//-(void)enmotionKeyboard{
//
//    if (self.memoraInformation.inputView == nil){
//        
//    }else{
//        self.memoraInformation.inputView = nil;
//    }
//    
//    //开始切换键盘
//    self.isSwitchKeyboard = YES;
//    
//    //退出键盘
//    [self.view endEditing:YES];
//    
//    //结束切换键盘
//    self.isSwitchKeyboard = NO;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //弹出键盘
//        [self.memoraInformation becomeFirstResponder];
//        
//        
//    });
//}






@end
