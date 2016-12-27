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
//    [self setupUI];
    [self setupUIForExtension];
}

- (void)setupUIForExtension{
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(5, 100, [UIScreen mainScreen].bounds.size.width -10, 200);
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    NSLog(@"%@",textView.font);
    [textView setPlaceholderWithText:@"占位字符串" Color:[UIColor lightGrayColor]];
    NSLog(@"%@",textView.font);
    [textView setPlaceholderWithText:@"占位字符串" Color:[UIColor lightGrayColor]];
    NSLog(@"%@",textView.font);
    
    textView.font = [UIFont systemFontOfSize:30];
}

- (void)setupUI{
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(5, 100, [UIScreen mainScreen].bounds.size.width -10, 200);
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    _textView = textView;
    
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"new";
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    self.xibTextView.backgroundColor = [UIColor orangeColor];
    [self.xibTextView addSubview:placeHolderLabel];
    [self.xibTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    // _placeholderLabel
    UILabel *placeHolderLabel1 = [[UILabel alloc] init];
    placeHolderLabel1.text = @"new";
    placeHolderLabel1.textColor = [UIColor lightGrayColor];
    [_textView addSubview:placeHolderLabel1];
    [_textView setValue:placeHolderLabel1 forKey:@"_placeholderLabel"];
    
    _textView.text = @"1";
    _textView.text = @"";

}

- (void)viewWillAppear:(BOOL)animated{
    

}
- (IBAction)buttonClick:(id)sender {
    
    
}



@end
