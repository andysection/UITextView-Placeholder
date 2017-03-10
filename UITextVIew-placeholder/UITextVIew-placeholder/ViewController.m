//
//  ViewController.m
//  UITextVIew-placeholder
//
//  Created by admin on 16/12/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "UITextView+Extension.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextView *xibTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    for (int i = 0; i < count; i++)
    { Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    
    [self setupUIForExtension];
}

- (void)setupUIForExtension{
    //纯代码
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(5, 100, [UIScreen mainScreen].bounds.size.width -10, 200);
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    //模仿cell复用
    [textView setPlaceholderWithText:@"占位字符串" Color:[UIColor lightGrayColor]];
    [textView setPlaceholderWithText:@"占位字符串" Color:[UIColor lightGrayColor]];

    NSLog(@"%@",textView.font);
    
    textView.font = [UIFont systemFontOfSize:18];
    
    
    //xib加载
//    UILabel *placeHolderLabel = [[UILabel alloc] init];
//    placeHolderLabel.text = @"new";
//    placeHolderLabel.textColor = [UIColor lightGrayColor];
//    self.xibTextView.backgroundColor = [UIColor orangeColor];
//    [self.xibTextView addSubview:placeHolderLabel];
//    [self.xibTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}



@end
