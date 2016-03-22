//
//  YLTools.m
//  MyTools
//
//  Created by shanghaikedu on 15/12/21.
//  Copyright © 2015年 Langmuir. All rights reserved.
//

#import "YLTools.h"

@implementation YLTools

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加载到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）
 *
 *  @return 返回图片对象
 */
+ (UIImage *)imageWithName:(NSString *)imgName{
    if (imgName) {
        NSString * path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage * image = [UIImage imageWithContentsOfFile:path];
        return image;
    }
    return nil;
}

//创建一个按钮（以图片展现）
+ (UIButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger) tag addTarget:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//创建一个按钮（以文字形式展现，带背景）
+ (UIButton *)createButtonBgImage:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:24.0f];
    btn.tag = tag;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//创建UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.font = font;
    label.textColor = color;
    label.textAlignment = align;
    label.text = text;
    return label;
}

//一个AlertView提示框(一个确定按钮)
+ (UIAlertController *)showAlertWithMessage:(NSString *)msg{
    UIAlertController * AlertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [AlertC addAction:action];
    return AlertC;
}

+ (void)showAlertWithMessage:(NSString *)msg withController:(UIViewController *)selfC withBlock:(certainBlock)certain_block{
    UIAlertController * AlertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        certain_block();
    }];
    [AlertC addAction:action];
    [selfC presentViewController:AlertC animated:YES completion:nil];
}

//一个AlertView提示框(两个按钮)
+ (void)showTwoButtonAlertWithMessage:(NSString *)msg withController:(UIViewController *)selfC withDeterminal:(determineBlock)determinal_block withCancel:(cancelBlock)cancel_block{
    UIAlertController * AlertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancel_block();
    }];
    [AlertC addAction:action];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        determinal_block();
    }];
    [AlertC addAction:action2];
    [selfC presentViewController:AlertC animated:YES completion:nil];
}

//监听键盘
+ (void)addObserverForKeyboardWithViewController:(UIViewController *)selfC{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:selfC selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:selfC selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
//***需要在selfC控制器中添加以下两个方法***
////当键盘显示时调用
//- (void)keyboardWillShow:(NSNotification *)aNotification{
//    NSLog(@"当键盘显示时调用");
//}
////当键盘退出时调用
//- (void)keyboardWillHide:(NSNotification *)aNotification{
//    NSLog(@"当键盘退出时调用");
//}


/**
 *  服务端null空值的处理
 */
+ (id)getValueExceptNull:(id)value{
    return [value isEqual:[NSNull null]] ? @"aaaaa" : value;
}

//判断本地是否有图片缓存
//+ (BOOL)isImageCachedRootPath:(NSString *)rootPath imageUrl:(NSString *)url{
//    NSFileManager * fm = [NSFileManager defaultManager];
//    //需要添加MD5三方库
//    NSString * imagePath = [rootPath stringByAppendingPathComponent:[url MD5Hash]];
//    if ([fm fileExistsAtPath:imagePath]) {
//        //存在
//        return YES;
//    }
//    return NO;
//}

//缓存图片
+ (void)cacheImage:(UIImage *)image imagePath:(NSString *)imgPath{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSData * data = UIImagePNGRepresentation([UIImage imageNamed:imgPath]);
    if(![fm fileExistsAtPath:imgPath]){
        [fm createFileAtPath:imgPath contents:data attributes:nil];
    }
}

//字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic{
    NSError * parseError = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * err;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if (err) {
        NSLog(@"json解析失败:%@",err);
        return nil;
    }
    return dic;
}

//在view上画一条实线或虚线
+ (void)drawLineWithRealLine:(BOOL)isRealLine withLineColor:(UIColor *)lineColor withLineWidth:(CGFloat)lineWidth withStartPoint:(CGPoint)startPoint withStopPoint:(CGPoint)stopPoint withLineAddView:(UIView *)addView{
    CAShapeLayer * solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath = CGPathCreateMutable();
    [solidShapeLayer setFillColor:[UIColor clearColor].CGColor];
    [solidShapeLayer setStrokeColor:lineColor.CGColor];
    solidShapeLayer.lineWidth = lineWidth;
    if (!isRealLine) {
        //虚线
        NSArray * dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:5], nil];
        [solidShapeLayer setLineDashPattern:dotteShapeArr];
    }
    CGPathMoveToPoint(solidShapePath, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(solidShapePath, NULL, stopPoint.x, stopPoint.y);
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [addView.layer addSublayer:solidShapeLayer];
}

//画一个圆
+ (void)drawCircleWithRealCircle:(BOOL)isRealCircle withCircleWidth:(CGFloat)lineWidth withCircleColor:(UIColor *)circleColor withFillColor:(UIColor *)fillColor withRect:(CGRect)rect withAddView:(UIView *)addView{
    CAShapeLayer *dotteLine =  [CAShapeLayer layer];
    CGMutablePathRef dottePath =  CGPathCreateMutable();
    dotteLine.lineWidth = 2.0f ;
    dotteLine.strokeColor = [UIColor orangeColor].CGColor;
    dotteLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(dottePath, nil, CGRectMake(50.0f,  50.0f, 200.0f, 200.0f));
    dotteLine.path = dottePath;
    if (!isRealCircle) {
        NSArray *arr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
        dotteLine.lineDashPhase = 1.0;
        dotteLine.lineDashPattern = arr;
    }
    CGPathRelease(dottePath);
    [addView.layer addSublayer:dotteLine];

}

//生成随机颜色
+ (UIColor *)randomColor{
    CGFloat red = arc4random() % 256 / 255.0;
    CGFloat green = arc4random() % 256 / 255.0;
    CGFloat blue = arc4random() % 256 / 255.0;
    UIColor * color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}

//iOS Post请求原生封装
+ (void)postNetWorkRequestWithURL:(NSString *)urlStr withRequestBody:(NSDictionary *)dataDic withCompletionBlock:(void (^)(NSData *))completionBlock{
    //1.创建请求
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    request.HTTPMethod = @"POST";
    
    //2.设置请求头
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
    
    //3.设置请求体
    //NSDictionary * json = dataDic;
    
    //NSData * data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    NSString * parse = [self parseParams:dataDic];
    NSData * postData = [parse dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody = postData;
    //[request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[data length]] forHTTPHeaderField:@"Content-length"];
    
    //4.发送请求
    NSURLSession * session = [NSURLSession sharedSession];
    //5.创建一个网络请求的任务
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data.length > 0) {
            completionBlock(data);
        }
    }];
    
    
    //6 开始执行任务
    [task resume];
}

//post异步请求封装函数
+ (void)post:(NSString *)URL RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSURL *url = [NSURL URLWithString:URL];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:20];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
    NSString *parseParamsResult = [self parseParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
    //    return result;
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        //NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}

/**
 *  获取当前系统语言环境
 */
+ (NSString *)currentLanguage{
    NSUserDefaults * defus = [NSUserDefaults standardUserDefaults];
    NSArray * languages = [defus objectForKey:@"AppleLanguages"];
    NSString * PReferredLang = [languages objectAtIndex:0];
    return PReferredLang;
}

/**
 *  计算字符串的高度
 */
+ (CGFloat)calculateStringHeightWithString:(NSString *)str withFont:(UIFont *)font{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * dicAtt = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, paragraphStyle.copy, NSParagraphStyleAttributeName, nil];
    NSAttributedString * attribute = [[NSAttributedString alloc] initWithString:str attributes:dicAtt];
    CGRect frame = [attribute boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return frame.size.height;
}

+ (CGRect)calculateStringRectWithString:(NSString *)str withFont:(UIFont *)font{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary * dicAtt = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, paragraphStyle.copy, NSParagraphStyleAttributeName, nil];
    NSAttributedString * attribute = [[NSAttributedString alloc] initWithString:str attributes:dicAtt];
    CGRect frame = [attribute boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return frame;
}

/**
 *  得到内容的自适应高度
 */
+ (CGFloat)contentHeightWithSize:(CGFloat)size width:(CGFloat)width string:(NSString *)string{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size]} context:nil];
    return rect.size.height;
}



//强行关闭app
+ (void)shutdowmAPP{
    [[UIApplication sharedApplication] performSelector:@selector(terminateWithSuccess)];
}

@end
