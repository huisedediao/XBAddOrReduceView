//
//  XBAddOrReduceView.m
//  AnXin
//
//  Created by xxb on 2018/2/8.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "XBAddOrReduceView.h"
#import "XBButton.h"
#import "Masonry.h"
#import "XBAddOrReduceViewConfig.h"

#define kTagBase (10345)

@interface XBAddOrReduceView ()
@property (nonatomic,strong) XBButton *btn_add;
@property (nonatomic,strong) XBButton *btn_reduce;
@property (nonatomic,strong) UILabel *lb_count;
@end

@implementation XBAddOrReduceView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = XBColor_clear;
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(GWidthFactorFun(88), kXBAddOrReduceViewCellHeight));
        }];
        [self createSubviews];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.i_count != 0)
    {
        [self setNotZeroStatus];
    }
}


- (void)createSubviews
{
    self.btn_reduce = [self createBtnWithNormalImg:XBImage_减少默认 highlightImg:XBImage_减少按下];
    [self.btn_reduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(GWidthFactorFun(44));
    }];
    self.btn_reduce.tag = kTagBase;
    
    self.btn_add = [self createBtnWithNormalImg:XBImage_增加默认 highlightImg:XBImage_增加按下];
    [self.btn_add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
    self.btn_add.tag = kTagBase + 1;
    
    self.lb_count = [UILabel new];
    [self addSubview:self.lb_count];
    [self.lb_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [self setCountLableText:0];
    self.lb_count.textAlignment = NSTextAlignmentCenter;
    self.lb_count.font = UIFont(GWidthFactorFun(12));
    self.lb_count.textColor = XBColor_gray_136_136_136;
    
    [self setZeroCountStatus];
}

- (void)setZeroCountStatus
{
    self.btn_reduce.alpha = 0;
    self.lb_count.hidden = YES;
    self.lb_count.alpha = 0;
}

- (void)setNotZeroStatus
{
    self.btn_reduce.alpha = 1;
    self.lb_count.hidden = NO;
    self.lb_count.alpha = 1;
    [self.btn_reduce mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
    }];
}

- (void)setCountLableText:(NSInteger)count
{
    self.lb_count.text = [NSString stringWithFormat:@"%zd",count];
}

- (XBButton *)createBtnWithNormalImg:(UIImage *)normalImg highlightImg:(UIImage *)highlightImg
{
    WEAK_SELF
    XBButton *btn = [XBButton new];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(GWidthFactorFun(44), GWidthFactorFun(44)));
    }];
    btn.img_normal = normalImg;
    btn.img_highlighted = highlightImg;
    btn.size_image = CGSizeMake(GWidthFactorFun(18), GWidthFactorFun(18));
    btn.bl_click = ^(XBButton *weakBtn) {
        if (weakBtn.tag == kTagBase)
        {
            NSInteger count = weakSelf.i_count - 1;
            if (count == 0)
            {
                if ([weakSelf.delegate respondsToSelector:@selector(XBAddOrReduceViewWillZeroCount:)])
                {
                    [weakSelf.delegate XBAddOrReduceViewWillZeroCount:weakSelf];
                }
                else
                {
                    _i_count = count;
                }
            }
            else
            {
                _i_count = count;
            }
        }
        else
        {
            _i_count = weakSelf.i_count + 1;
        }
        if (_i_count > weakSelf.maxCount)
        {
            _i_count = weakSelf.maxCount;
        }
        [weakSelf reloadStatusAnimation:YES];
        if ([weakSelf.delegate respondsToSelector:@selector(XBAddOrReduceView:clickBtnAtIndex:)])
        {
            [weakSelf.delegate XBAddOrReduceView:weakSelf clickBtnAtIndex:weakBtn.tag - kTagBase];
        }
    };
    return btn;
}

- (void)fixCount
{
    if (_i_count <= 0)
    {
        _i_count = 0;
    }
}

- (void)reloadStatusAnimation:(BOOL)animation
{
    [self fixCount];
    [self setCountLableText:_i_count];
    
    if (_i_count == 0)
    {
        //隐藏
        self.lb_count.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            [self.btn_reduce mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(GWidthFactorFun(44));
            }];
            if (animation)
            {
                [self layoutIfNeeded];
            }
            self.lb_count.alpha = 0;
            self.btn_reduce.alpha = 0;
        }];
    }
    else
    {
        //显示
        self.lb_count.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self.btn_reduce mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
            }];
            if (animation)
            {
                [self layoutIfNeeded];
            }
            self.lb_count.alpha = 1;
            self.btn_reduce.alpha = 1;
        }];
    }
}

- (void)setI_count:(NSInteger)i_count
{
    _i_count = i_count;

    [self reloadStatusAnimation:NO];
}

- (NSInteger)maxCount
{
    if (_maxCount == 0)
    {
        return 5;
    }
    return _maxCount;
}

@end
