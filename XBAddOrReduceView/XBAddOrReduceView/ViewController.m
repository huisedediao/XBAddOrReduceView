//
//  ViewController.m
//  XBAddOrReduceView
//
//  Created by 谢贤彬 on 2019/1/27.
//  Copyright © 2019年 谢贤彬. All rights reserved.
//

#import "ViewController.h"
#import "XBAddOrReduceView.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    XBAddOrReduceView *view = [[XBAddOrReduceView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    view.i_count = 1;
}


@end
