//
//  ZQGraphValidateCode.m
//  GraphValidateCode
//
//  Created by aoliday on 15/8/12.
//  Copyright (c) 2015年 aoliday. All rights reserved.
//

#import "ZQGraphValidateCode.h"

@interface ZQGraphValidateCode ()


@end

@implementation ZQGraphValidateCode

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeValues];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeValues];
    }
    return self;
}

- (void)initializeValues
{
    self.backgroundColor = [UIColor whiteColor];
    _needGenerateBackgroundColor = NO;
    _maxLineNumbers = 6;
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setNeedsDisplay)];
    [self addGestureRecognizer:tapgesture];
    tapgesture = nil;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat drawOriginX = 5.0;
    CGFloat drawOriginY = 5.0;
    NSArray *numbers = [self generateValidateCode];
    NSInteger numbersCount = numbers.count;
    CGFloat space = (rect.size.width - drawOriginX * 2) / numbersCount;
    CGPoint startPoint = CGPointMake(drawOriginX, drawOriginY);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_needGenerateBackgroundColor)
    {
        CGContextSaveGState(context);
        [[self generateRandomColor] setFill];
        CGContextFillRect(context, rect);
        CGContextRestoreGState(context);
    }
    
    //画出字符
    for (id number in numbers)
    {
        UIFont *stringFont = [self generateRandomFont];
        startPoint.y = [self generateNeedAddRandomY:(rect.size.height - stringFont.lineHeight)];
        
        // 记录初始位置的字符的x位置
        CGFloat tempX = startPoint.x;
        
        // 每个字符在space这个rect中居中显示的起始位置
        // 字符在当前rect居中显示的originX
        startPoint.x += (space - stringFont.xHeight) / 2;
        NSString *numberString = [number stringValue];
        CGContextSaveGState(context);
        int translateX = startPoint.x + (stringFont.xHeight) / 2;
        int translateY = startPoint.y + (stringFont.lineHeight) / 2;
        CGContextTranslateCTM(context, translateX, translateY);
        CGAffineTransform transform = CGAffineTransformMakeRotation([self generateAngle]);
        CGContextConcatCTM(context, transform);
        CGContextTranslateCTM(context, -translateX, -translateY);
        [numberString drawAtPoint:startPoint withAttributes:@{NSFontAttributeName:stringFont, NSForegroundColorAttributeName:[self generateRandomColor]}];
        CGContextRestoreGState(context);
        // 画出字符之后回到初始位置并计算下一个字符的初始起始位置
        startPoint.x = tempX + space;
    }
    
    // 画出线条
    int lineNumbers = arc4random() % _maxLineNumbers;
    for (int i = 0; i < lineNumbers; i++)
    {
        int width = (int)rect.size.width;
        int height = (int)rect.size.height;
        CGContextSaveGState(context);
        int startX = [self generateRandomLinePositionWithNumber:width];
        int startY = [self generateRandomLinePositionWithNumber:height];
        int endX = [self generateRandomLinePositionWithNumber:width];
        int endY = [self generateRandomLinePositionWithNumber:height];
        [[self generateRandomColor] setStroke];
        CGContextSetLineWidth(context, 1);
        CGContextMoveToPoint(context, startX, startY);
        CGContextAddLineToPoint(context, endX, endY);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
}

// 生成0-9的随机数
- (NSArray *)generateValidateCode
{
    __autoreleasing NSMutableArray *numbers = [NSMutableArray new];
    NSMutableString *numberString = [NSMutableString new];
    for (int i = 0; i < 4; i++)
    {
        int number = arc4random() % 10;
        NSNumber *numberObject = [NSNumber numberWithInt:number];
        [numbers addObject:numberObject];
        [numberString appendString:[numberObject stringValue]];
    }
    _validateCode = numberString.copy;
    numberString = nil;
    return numbers.copy;
}

// 生成随机颜色
- (UIColor *)generateRandomColor
{
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

// 生成随机字体
- (UIFont *)generateRandomFont
{
    int fontSize = arc4random() % 6 + 15;
    return [UIFont boldSystemFontOfSize:fontSize];
}

// 生成随机的originY变化的范围
- (NSInteger)generateNeedAddRandomY:(NSInteger)randomNumber
{
    return arc4random() % randomNumber;
}

// 生成随机弧度
- (CGFloat)generateAngle
{
    int degrees = arc4random() % 45;
    int isPositive = arc4random() % 2;
    if (isPositive == 1)
    {
        return degrees * M_PI / 180.0;
    }
    return -degrees * M_PI / 180.0;
}

// 随机生成线条的positive
- (int)generateRandomLinePositionWithNumber:(int)number
{
    return arc4random() % number;
}

@end
