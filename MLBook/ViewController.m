//
//  ViewController.m
//  MLBook
//
//  Created by shanghaikedu on 16/2/18.
//  Copyright © 2016年 Langmuir. All rights reserved.
//

#import "ViewController.h"
#import "MainBookViewController.h"

#define ViewWidth self.view.frame.size.width
#define ViewHeight self.view.frame.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight)];
    UIImage * image = [UIImage imageNamed:@"firstImage"];
    imageView.image = image;
    [self.view addSubview:imageView];
    //self.view = imageView;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    NSArray * arr = @[@"问世间情为何物",
                      @"直教生死相许",
                      @"天南地北双飞客",
                      @"老翅几回寒暑",
                      @"欢乐趣，离别苦",
                      @"就中更有痴儿女",
                      @"君应有语，渺万里层云",
                      @"千山暮雪，只影向谁去"];
    for (int i = 0; i < 8; i++) {
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        label1.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 100 + 40 * i);
        label1.text = arr[i];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont boldSystemFontOfSize:18.0f];
        [imageView addSubview:label1];
    }
    
}

- (void)tapAction{
    MainBookViewController * mainB = [[MainBookViewController alloc] init];
    [self.navigationController pushViewController:mainB animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
