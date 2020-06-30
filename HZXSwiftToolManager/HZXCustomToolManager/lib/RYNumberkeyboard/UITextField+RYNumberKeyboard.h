//
//  UITextField+RYNumberKeyboard.h
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYNumberKeyboard.h"

@interface UITextField (RYNumberKeyboard)

/// 键盘类型
@property (nonatomic, assign) RYInputType ry_inputType;
/// 每隔多少个数字空一格
@property (nonatomic, assign) NSInteger ry_interval;
/// inputAccessoryView显示的文字
@property (nonatomic, copy) NSString *ry_inputAccessoryText;

/// 设置输入框输入的最大数量
/// @param maxlength 字符数量
- (void)setMaxLength:(NSInteger)maxlength;

/// 切记这个方法一定要写在placeholder设置之后，也就是有placeholder之后才能写，否则会崩溃
/// @param placeholderColor 占位符字体颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor;


+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string controllDecimalLenth:(NSInteger)lenth pointBehindLenth:(NSInteger)poinLenth;
@end


