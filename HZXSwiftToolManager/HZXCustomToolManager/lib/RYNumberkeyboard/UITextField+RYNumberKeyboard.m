//
//  UITextField+RYNumberKeyboard.m
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "UITextField+RYNumberKeyboard.h"
#import <objc/runtime.h>
static const void *kmaxlen = "maxlen";
@interface UITextField()
@property(nonatomic,copy) NSString *maxlen;
@end

@implementation UITextField (RYNumberKeyboard)
- (void)setMaxlen:(NSString *)maxlen{
    objc_setAssociatedObject(self, kmaxlen, maxlen, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)maxlen{
    return objc_getAssociatedObject(self, kmaxlen);
}
#pragma mark -
#pragma mark -  Setter

- (void)setRy_inputType:(RYInputType)ry_inputType {
    RYNumberKeyboard *inputView = [[RYNumberKeyboard alloc] initWithInputType:ry_inputType];
    self.inputView = inputView;
    objc_setAssociatedObject(self, _cmd, @(ry_inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRy_interval:(NSInteger)ry_interval {
    if([self.inputView isKindOfClass:[RYNumberKeyboard class]])
        [self.inputView performSelector:@selector(setInterval:) withObject:@(ry_interval)];
    objc_setAssociatedObject(self, _cmd, @(ry_interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRy_inputAccessoryText:(NSString *)ry_inputAccessoryText {
    
    NSLog(@"********** %@",ry_inputAccessoryText);
    // inputAccessoryView
    UIView *tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    // 顶部分割线
    UIView *tLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 0.5)];
    tLine.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0];
    // 字体label
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    tLabel.text = ry_inputAccessoryText;
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.font = [UIFont systemFontOfSize:14.0];
    tLabel.backgroundColor = [UIColor whiteColor];
    
    [tView addSubview:tLabel];
    [tView addSubview:tLine];
    self.inputAccessoryView = tView;
    objc_setAssociatedObject(self, _cmd, ry_inputAccessoryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark -  Getter

- (RYInputType)ry_inputType {
    return [objc_getAssociatedObject(self, @selector(setRy_inputType:)) integerValue];
}

- (NSInteger)ry_interval {
    return [objc_getAssociatedObject(self, @selector(setRy_interval:)) integerValue];
}

- (NSString *)ry_inputAccessoryText {
    return objc_getAssociatedObject(self, @selector(ry_inputAccessoryText));
}
#pragma mark -- 字数限制
- (void)setMaxLength:(NSInteger)maxlength{
    
    self.maxlen=[NSString stringWithFormat:@"%@",@(maxlength)];
    [self addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    if (@available(iOS 13.0, *)) {
        NSString *placeholderStr = self.placeholder ? self.placeholder : @"";
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:placeholderStr attributes:@{NSForegroundColorAttributeName : placeholderColor}];
        self.attributedPlaceholder = str;
    } else {
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}
- (void)TextFieldChange:(UITextField *)obj{
    UITextField *NameText=(UITextField *)obj;
    NSInteger _maxlength=[self.maxlen integerValue];
    NSString *toBeString = NameText.text;
    NSString *toString=@"";
    if (self.ry_interval > 0) {
        toString = toBeString;
        toBeString = [self trimStringWithStr:toBeString];
    }
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [NameText markedTextRange];
        //获取高亮部分
        UITextPosition *position = [NameText positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _maxlength) {
                NameText.text = [toBeString substringToIndex:_maxlength];
            }
        }
    } else {
        if (toBeString.length > _maxlength) {
            if (self.ry_interval > 0) {
                NSInteger i = _maxlength/self.ry_interval; //记录空格的数量
                if (_maxlength%self.ry_interval == 0) {
                    i--;
                }
                NameText.text = [toString substringToIndex:(_maxlength + i)];
            } else {
                NameText.text = [toBeString substringToIndex:_maxlength];
            }
        }
    }
}
#pragma mark 清空字符串中的空白字符
- (NSString *)trimStringWithStr:(NSString *)AllStr{
    NSString *trim = [AllStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [trim stringByReplacingOccurrencesOfString:@" " withString:@""];
}
+ (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string controllDecimalLenth:(NSInteger)lenth pointBehindLenth:(NSInteger)poinLenth{
    BOOL _isHasPoint = NO;
    if ([textField.text rangeOfString:@"."].location != NSNotFound) {
        _isHasPoint = YES;
    }
    if ([string length] > 0) {
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if (poinLenth<1) {
            if (single == '.') {
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            //首字母不能为0和小数点
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    textField.text=@"0";
                    return YES;
                }
                if (single == '0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return YES;
                }
            }else if ([textField.text length]==1 && [textField.text integerValue]==0){
                if (single=='0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }else if (single != '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    textField.text=@"";
                    return YES;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                //text中还没有小数点
                if(!_isHasPoint) {
                    _isHasPoint = YES;
                    return YES;
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (_isHasPoint) {//存在小数点
                    NSRange ran = [textField.text rangeOfString:@"."];
                    //判断小数点的位数
                    //NSRange ran = [textField.text rangeOfString:@"."];
                    if ((range.location - ran.location <= poinLenth) && ran.location<lenth) {
                        return YES;
                    }else{
                        if (range.location - ran.location <= poinLenth) {
                            return YES;
                        }
                        return NO;
                    }
                }else{
                    if (range.location<lenth) {
                        return YES;
                    }
                    return NO;
                }
            }
        } else {//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    } else {
        return YES;
    }
}
@end
