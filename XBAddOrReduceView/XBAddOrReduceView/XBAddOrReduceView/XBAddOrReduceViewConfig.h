//
//  XBAddOrReduceViewConfig.h
//  XBAddOrReduceView
//
//  Created by 谢贤彬 on 2019/1/27.
//  Copyright © 2019年 谢贤彬. All rights reserved.
//

#ifndef XBAddOrReduceViewConfig_h
#define XBAddOrReduceViewConfig_h


#define kXBAddOrReduceViewCellHeight (GWidthFactorFun(50))
#define XBColor_clear                           [UIColor clearColor]

#define UIFont(s)            [UIFont systemFontOfSize:s]

#define UIImageName(imageName) [UIImage imageNamed:imageName]

#define XBImage_增加默认                                 UIImageName(@"增加默认")
#define XBImage_增加按下                                 UIImageName(@"增加按下")
#define XBImage_减少默认                                 UIImageName(@"减少默认")
#define XBImage_减少按下                                 UIImageName(@"减少按下")


#define WEAK_SELF __typeof(self) __weak weakSelf = self;


//RGB颜色
#define ColorRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define XBColor_gray_136_136_136                ColorRGBA(136, 136, 136, 1)


//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kConsultHeight 568.0
#define kConsultWidth 320.0

#define ScreenCondition(x) ((kScreenHeight == x) || (kScreenWidth == x))

#define isIpadScreen (ScreenCondition(480.0) ? YES : NO)
#define isIphone5Screen (ScreenCondition(568.0) ? YES : NO)
#define isIphone6Screen (ScreenCondition(667.0) ? YES : NO)
#define isIphone6PScreen (ScreenCondition(736.0) ? YES : NO)
#define isIphoneXScreen (ScreenCondition(812.0) ? YES : NO)
#define isIphoneXScreen (ScreenCondition(812.0) ? YES : NO)
#define isIphoneXROrXSMAXScreen (ScreenCondition(896.0) ? YES : NO)

#define GWidthFactor (MIN(kScreenWidth, kScreenHeight)/kConsultWidth)
#define GHeightFactor \
({\
CGFloat result = kConsultHeight;\
if (isIphoneXScreen)\
{\
result = 667/kConsultHeight;\
}\
else if (isIphoneXROrXSMAXScreen)\
{\
result = 736/kConsultHeight;\
}\
else if (isIpadScreen)\
{\
result = 568/kConsultHeight;\
}\
else\
{\
result = MAX(kScreenWidth, kScreenHeight)/kConsultHeight;\
}\
result;\
})

#define GWidthFactorFun(x) (x * GWidthFactor)
#define GHeightFactorFun(x) (x * GHeightFactor)

#endif /* XBAddOrReduceViewConfig_h */
