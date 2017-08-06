//
//  ViewController.m
//  Overlap
//
//  Created by jv on 2017/8/6.
//  Copyright © 2017年 jv. All rights reserved.
//

#import "ViewController.h"
#import "OverlapView.h"

@interface ViewController ()

@property (strong, nonatomic) OverlapView *lap;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lap = [[OverlapView alloc] initWithFrame:(CGRect){0,100,self.view.width,0}];
    [_lap redBorder];
    [self.view addSubview:_lap];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
