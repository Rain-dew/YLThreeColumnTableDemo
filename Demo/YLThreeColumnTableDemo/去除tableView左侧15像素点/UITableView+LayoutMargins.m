//
//  UIButton+LayoutMargins.m
//  封装
//  QQ: 896525689
//  Created by Yulu Zhang on 16/4/18.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

#import "UITableView+LayoutMargins.h"

@implementation UITableView (LayoutMargins)
-(void)setTableViewMarginsIsZero {

    //解决cell左侧15像素点空白
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }

}

@end
