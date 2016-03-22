//
//  YLTools.h
//  MyTools
//
//  Created by shanghaikedu on 15/12/21.
//  Copyright © 2015年 Langmuir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Alert一个确定按钮block
typedef void(^certainBlock)();

//Alert两个按钮（一个确定，一个取消）block
typedef void(^determineBlock)();
typedef void(^cancelBlock)();

@interface YLTools : NSObject

/**
 *  通过文件路径加载图片
 *  该方法加载图片优势：不会将图片加载到内存缓存中（适用类型：较大图片的处理）
 *
 *  @param imgName 图片名称（带扩展名）
 *
 *  @return 返回图片对象
 */
+ (UIImage *)imageWithName:(NSString *)imgName;

//创建一个按钮（以图片展现）
+ (UIButton *)createButtonNormalImage:(NSString *)normalImageName selectedImage:(NSString *)selectImageName tag:(NSUInteger) tag addTarget:(id)target action:(SEL)action;

//创建一个按钮（以文字形式展现，带背景）
+ (UIButton *)createButtonBgImage:(NSString *)imageName title:(NSString *)title tag:(NSInteger)tag target:(id)target action:(SEL)action;

//创建UILabel
+ (UILabel *)createLabelWithFrame:(CGRect)frame textContent:(NSString *)text withFont:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)align;

//一个AlertView提示框
+ (UIAlertController *)showAlertWithMessage:(NSString *)msg;
+ (void)showAlertWithMessage:(NSString *)msg withController:(UIViewController *)selfC withBlock:(certainBlock)certain_block;
+ (void)showTwoButtonAlertWithMessage:(NSString *)msg withController:(UIViewController *)selfC withDeterminal:(determineBlock)determinal_block withCancel:(cancelBlock)cancel_block;

//监听键盘
+ (void)addObserverForKeyboardWithViewController:(UIViewController *)selfC;

/**
 *  服务端null空值的处理
 */
+ (id)getValueExceptNull:(id)value;

//缓存图片
+ (void)cacheImage:(UIImage *)image imagePath:(NSString *)imgPath;

//字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//在view上画一条实线或虚线
+ (void)drawLineWithRealLine:(BOOL)isRealLine withLineColor:(UIColor *)lineColor withLineWidth:(CGFloat)lineWidth withStartPoint:(CGPoint)startPoint withStopPoint:(CGPoint)stopPoint withLineAddView:(UIView *)addView;

//画一个圆
+ (void)drawCircleWithRealCircle:(BOOL)isRealCircle withCircleWidth:(CGFloat)lineWidth withCircleColor:(UIColor *)circleColor withFillColor:(UIColor *)fillColor withRect:(CGRect)rect withAddView:(UIView *)addView;

//生成随机颜色
+ (UIColor *)randomColor;

//iOS Post请求原生封装
+ (void)postNetWorkRequestWithURL:(NSString *)url withRequestBody:(NSDictionary *)dataDic withCompletionBlock:(void(^)(NSData * data))completionBlock;

/**
 *  获取当前系统语言环境
 */
+ (NSString *)currentLanguage;

/**
 *  计算字符串的高度
 */
+ (CGFloat)calculateStringHeightWithString:(NSString *)str withFont:(UIFont *)font;
+ (CGRect)calculateStringRectWithString:(NSString *)str withFont:(UIFont *)font;
/**
 *  得到内容的自适应高度
 */
+ (CGFloat)contentHeightWithSize:(CGFloat)size width:(CGFloat)width string:(NSString *)string;

//强行关闭app
+ (void)shutdowmAPP;

@end
