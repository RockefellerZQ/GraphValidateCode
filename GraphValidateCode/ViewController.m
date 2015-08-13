//
//  ViewController.m
//  GraphValidateCode
//
//  Created by aoliday on 15/8/12.
//  Copyright (c) 2015年 aoliday. All rights reserved.
//

#import "ViewController.h"
#import "ZQGraphValidateCode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZQGraphValidateCode *validateCode = [[ZQGraphValidateCode alloc] initWithFrame:CGRectMake(100, 100, 80, 40)];
    [self.view addSubview:validateCode];
    validateCode = nil;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
