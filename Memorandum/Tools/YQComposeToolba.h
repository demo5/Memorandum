//
//  YQComposeToolba.h
//  Memorandum
//
//  Created by YoKing on 15/11/27.
//  Copyright © 2015年 YQ. All rights reserved.
//  自定义键盘工具栏

#import <UIKit/UIKit.h>

typedef enum {
    YQComposeToolbarButtonTypeCamera,//拍照
    YQComposeToolbarButtonTypePicture,//相册
//    YQComposeToolbarButtonTypeVoice,//声音
    YQComposeToolbarButtonTypeKeyboardDown//键盘
}YQComposeToolbarButtonType;

@class YQComposeToolba;

//代理
@protocol YQComposeToolbaDelegate <NSObject>
@optional
/** 工具栏的上的按钮的监听方法*/
-(void)composeToolBar:(YQComposeToolba *)toolbar didClickButton:(YQComposeToolbarButtonType)buttonType;

@end


@interface YQComposeToolba : UIView

@property (nonatomic ,weak) id<YQComposeToolbaDelegate> delegate;


@end











