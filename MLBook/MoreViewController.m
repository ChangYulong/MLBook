//
//  MoreViewController.m
//  MLBook
//
//  Created by shanghaikedu on 16/2/18.
//  Copyright © 2016年 Langmuir. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //[self.myWebView loadHTMLString:_dataObject baseURL:nil];
    //self.myWebView.scrollView.bounces = NO;
    //[self.view addSubview:self.myWebView];
    
    self.view.backgroundColor = [UIColor colorWithRed:200/255.0 green:220/255.0 blue:207/255.0 alpha:1];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 50)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    //[label sizeToFit];
    label.text = (NSString *)self.dataObject;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
