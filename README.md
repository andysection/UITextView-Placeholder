# UITextView-Placeholder
a kind of class base on UITextView With custom PlaceHolder

通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量

# 思路
通过创一个Label然后使用kvc方法赋值给textView实现占位字符串的功能
```
[_textView addSubview:placeHolderLabel1];
```
> 在使用过程中发现如果是xib上加载的TextView采用上述方法可行，但是若是纯代码，占位文字会发生位移，在进行过一次编辑清空后才会到正确位置。

基于以上原因，创建了一个分类，并使用方法交换将TextView的font与placeholderlabel的font绑定，同时变化大小。
```
+ (void)load {
    
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod = class_getInstanceMethod(self, @selector(was_setFont:));
    
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
}
```

# 使用方法
直接将UITextView+Extension.h和UITextView+Extension.m拖入项目中，在需要使用TextView的控制器内导入，调用下面方法可以
```
- (void)setPlaceholderWithText:(NSString *)text Color:(UIColor *)color;
```
谢谢你的观看
Thanks for your reading~
