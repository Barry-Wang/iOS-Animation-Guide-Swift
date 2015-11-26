//
//  ViewController.m
//  LuaFix
//
//  Created by barryclass on 15/11/25.
//  Copyright © 2015年 barry. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()
@property (nonatomic, strong) id installManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add) name:@"123" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add2) name:@"234" object:nil];
}

- (void)setBackGround {
   
    NSLog(@"设置背景颜色");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setBackGround];
}
- (IBAction)pushVC:(id)sender {
    
    NextViewController *vc = [[NextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)add{
    
    id subView = [[NSClassFromString(@"SubView") alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:subView];

}

-(void)add2{
    
    id subView3 = [[NSClassFromString(@"SubView3") alloc] initWithFrame:CGRectMake(10, 200, 200, 200)];
    NSLog(@"%@",subView3);
    [self.view addSubview:subView3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
