###一个图形验证码控件

随机生成四位数的图形验证码，位数可以根据条件更改，直接初始化使用。

![Demo Icon](./GraphValidateCode/validateCodeDemo.png)

背景色也可以随机生成
```
validateCode.needGenerateBackgroundColor = YES;
```

障碍线的条数根据条件控制
```
validateCode.maxLineNumbers = 10;
```
判断用户输入是否与验证码一致
```
if ([someTextField.text isEqualString:graphValidateCode.validateCode]) {
// 下一步动作
} else {
// 验证码输入不一致的提示
}
```
