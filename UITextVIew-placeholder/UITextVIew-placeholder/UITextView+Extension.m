//
//  UITextView+Extension.m
//  UITextVIew-placeholder
//
//  Created by admin on 16/12/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UITextView+Extension.h"
#import <objc/runtime.h>

@implementation UITextView (Extension)

+ (void)load {
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod = class_getInstanceMethod(self, @selector(was_setFont:));
    
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
}

- (void)setPlaceholderWithText:(NSString *)text Color:(UIColor *)color{
    //防止重复设置 cell复用等问题
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }

    //设置占位label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = self.font;
    label.textColor = color;
    
    [self addSubview:label];
    [self setValue:label forKey:@"_placeholderLabel"];
    
    //第一次会有位移
    self.text = @"1";
    self.text = @"";
}

- (void)was_setFont:(UIFont *)font{
    //调用原方法 setFont:
    [self was_setFont:font];
    //设置占位字符串的font
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.font = font;
    NSLog(@"%s", __func__);
}

@end
