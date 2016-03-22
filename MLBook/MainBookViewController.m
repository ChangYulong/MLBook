//
//  MainBookViewController.m
//  MLBook
//
//  Created by shanghaikedu on 16/2/18.
//  Copyright © 2016年 Langmuir. All rights reserved.
//

#import "MainBookViewController.h"
#import "MoreViewController.h"

@interface MainBookViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    BOOL isTap;
    BOOL isFirst;
    UIBarButtonItem * rightItem;
    NSUInteger countPage;
}
@property (nonatomic, strong) UIPageViewController * pageController;
@property (nonatomic, strong) NSArray * pageContent;

@end

@implementation MainBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bookMark"] style:UIBarButtonItemStylePlain target:self action:@selector(bookMarkAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
    
    //初始化所有数据
    [self createContentPages];
    //设置UIPageViewController的配置项
    //NSDictionary * options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMid] forKey:UIPageViewControllerOptionSpineLocationKey];
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    //实例化UIPageViewController对象，根据给定的属性
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    //self.pageController = [[UIPageViewController alloc] init];
    //设置UIPageViewController对象代理
    _pageController.dataSource = self;
    _pageController.delegate = self;
    //定义“这本书”的尺寸
    [[_pageController view] setFrame:[[self view] bounds]];
    
    //让UIPageViewController对象，显示响应的页数据
    //UIPageViewController对象要显示的页数据封装成为一个NSArray
    //因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）
    //如果要显示2页，NSArray中，应该有2个相应页数据
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSLog(@"%d",[ud boolForKey:@"isFirst"]);
    
    NSLog(@"%d",[ud boolForKey:@"isTap"]);
    NSLog(@"%d",[ud boolForKey:@"isFirst"]);
    if ([ud boolForKey:@"isFirst"] || ![ud boolForKey:@"isTap"]) {
        //得到第一页
        MoreViewController * initialViewController = [self viewControllerAtIndex:0];
        NSArray * viewControllers = [NSArray arrayWithObject:initialViewController];
        [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }else{
        MoreViewController * initialViewController = [self viewControllerAtIndex:[ud integerForKey:@"countPage"]];
        NSArray * viewControllers = [NSArray arrayWithObject:initialViewController];
        [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    
    if ([ud boolForKey:@"isFirst"]) {
        isTap = NO;
        [ud setBool:NO forKey:@"isFirst"];
        rightItem.image = [UIImage imageNamed:@"bookMark"];
    }else{
        isTap = [ud boolForKey:@"isTap"];
        if (isTap) {
            rightItem.image = [UIImage imageNamed:@"bookMark_press"];
        }else{
            rightItem.image = [UIImage imageNamed:@"bookMark"];
        }
    }
    [ud synchronize];

    
    //在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
    
    //[self addPageViewController];
}

//点击桌面
- (void)tapAction:(UITapGestureRecognizer *)sender{
    NSLog(@"tap");
    //NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    isTap = !isTap;
    if (isTap) {
        //出现
        //[ud setBool:YES forKey:@"isTap"];
        self.navigationController.navigationBarHidden = NO;
        
    }else{
        //消失
        //[ud setBool:NO forKey:@"isTap"];
        self.navigationController.navigationBarHidden = YES;
        
    }
    //[ud boolForKey:@"isTap"];
    //[ud synchronize];
}

//收藏
- (void)bookMarkAction{
    NSLog(@"bookMark");
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:![ud boolForKey:@"isTap"] forKey:@"isTap"];
    if ([ud boolForKey:@"isTap"]) {
        rightItem.image = [UIImage imageNamed:@"bookMark_press"];
        [ud setInteger:countPage forKey:@"countPage"];
    }else{
        rightItem.image = [UIImage imageNamed:@"bookMark"];
    }
    [ud synchronize];
}

//得到相应的VC对象
- (MoreViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
        return nil;
    }
    //创建一个新的控制器类，并且分配给相应的数据
    MoreViewController * dataViewController = [[MoreViewController alloc] init];
    dataViewController.dataObject = [self.pageContent objectAtIndex:index];
    return dataViewController;
}

//根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(MoreViewController *)viewController{
    return [self.pageContent indexOfObject:viewController.dataObject];
}

//初始化所有数据
- (void)createContentPages{
    NSMutableArray * pageStrings = [[NSMutableArray alloc] init];
    //for (int i = 0; i < 11; i++) {
        //NSString * contentString = [[NSString alloc] initWithFormat:@"Chapter %d",i];
        //[pageStrings addObject:contentString];
    //}
    
    NSString * str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cyl" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    for (int i = 0; i < [str length] / 360; i++) {
        NSString * subStr = [str substringWithRange:NSMakeRange(0 + 360 * i, 360)];
        [pageStrings addObject:subStr];
    }
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
}

//- (void)addPageViewController{
    //UIPageViewController * pageViewController = [[UIPageViewController alloc] init];
    //pageViewController.delegate = self;
    //pageViewController.dataSource = self;
    //pageViewController.view.frame = self.view.frame;
    
    //[self addChildViewController:pageViewController];
    //[self.view addSubview:pageViewController.view];
//}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //MainBookViewController * readerVC = [[MainBookViewController alloc] init];
    //return readerVC;
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    //判断当前页是否是收藏页
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (index == [ud integerForKey:@"countPage"]) {
        rightItem.image = [UIImage imageNamed:@"bookMark_press"];
    }else{
        rightItem.image = [UIImage imageNamed:@"bookMark"];
    }
    countPage = index;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    //MainBookViewController * readerVC = [[MainBookViewController alloc] init];
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    //返回ViewController，将被添加到相应的UIPageViewController对象上
    //UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序
    //不用我们去操心每个Viewcontroller的顺序问题
    countPage = index;
    
    //判断当前页是否是收藏页
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    if (index == [ud integerForKey:@"countPage"]) {
        rightItem.image = [UIImage imageNamed:@"bookMark_press"];
    }else{
        rightItem.image = [UIImage imageNamed:@"bookMark"];
    }
    return [self viewControllerAtIndex:index];
    //return readerVC;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{

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
