//
//  ViewController.m
//  WMCAAnimationGroup
//
//  Created by 从来 on 17/1/9.
//  Copyright © 2017年 从来. All rights reserved.
//

#import "ViewController.h"
#import "WMGiftDetaultAnimationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *btnaa = [UIButton buttonWithType:UIButtonTypeCustom];
    btnaa.backgroundColor = [UIColor redColor];
    btnaa.frame= CGRectMake(100, 200, 100, 100);
    [btnaa addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnaa];
    
    
    
    

    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)onClick{
    WMGiftDetaultAnimationView *animationView = [WMGiftDetaultAnimationView sharedDefaultAnimationView];
    [animationView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
