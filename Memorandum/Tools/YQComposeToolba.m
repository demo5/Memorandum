//
//  YQComposeToolba.m
//  Memorandum
//
//  Created by YoKing on 15/11/27.
//  Copyright © 2015年 YQ. All rights reserved.
//  自定义键盘工具栏

#import "YQComposeToolba.h"

@implementation YQComposeToolba

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /** 设置背景图片*/
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        /** 设置背景图片上的图片*/
        [self setBarButtonImage:@"compose_camerabutton_background" HighImage:@"compose_camerabutton_background_highlighted" Type:YQComposeToolbarButtonTypeCamera];//相机
        
        [self setBarButtonImage:@"compose_toolbar_picture" HighImage:@"compose_toolbar_picture_highlighted" Type:YQComposeToolbarButtonTypePicture];//相册
        
        [self setBarButtonImage:@"compose_emoticonbutton_background" HighImage:@"compose_emoticonbutton_background_highlighted" Type:YQComposeToolbarButtonTypeVoice];//表情--->声音
        
        [self setBarButtonImage:@"compose_keyboardbutton_background" HighImage:@"compose_keyboardbutton_background_highlighted" Type:YQComposeToolbarButtonTypeKeyboardDown];//放下键盘
    }
    
    return self;
}
/**
 *  创建一个按钮
 *
 *  @param image     默认状态下的图片
 *  @param highImage 高亮图片
 *  @param type      按钮类型
 */
-(void)setBarButtonImage:(NSString *)image HighImage:(NSString *)highImage Type:(YQComposeToolbarButtonType)type{
    
    UIButton *bar = [[UIButton alloc] init];
    [bar setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [bar setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [bar addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    bar.tag = type;
    
    [self addSubview:bar];
}

/**
 *  按钮的点击事件
 */
-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        
        NSInteger index = btn.x / btn.width;
        [self.delegate composeToolBar:self didClickButton:index];
    }
    
}

/**
 *  按钮的布局
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSInteger i = 0; i < count; i++) {
        
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    }
}

@end
