//
//  XBAddOrReduceView.h
//  AnXin
//
//  Created by xxb on 2018/2/8.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XBAddOrReduceView;
@protocol XBAddOrReduceViewDelegate <NSObject>
/**
 count：即将显示的数量
 返回no不显示，返回yes显示
 */
- (BOOL)addOrReduceView:(XBAddOrReduceView *)XBAddOrReduceView countWillChangeTo:(NSInteger)count;
- (void)addOrReduceViewCountDidChanged:(XBAddOrReduceView *)XBAddOrReduceView;
@end

@interface XBAddOrReduceView : UIView
@property (nonatomic,assign) NSInteger i_count;
@property (nonatomic,weak) id<XBAddOrReduceViewDelegate>delegate;
@property (nonatomic,assign) NSInteger maxCount;
- (void)setZeroCountStatus;
- (void)setNotZeroStatus;
@end
