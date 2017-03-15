//
//  UITableViewCell+LayoutMarginsIsZero.m
//  封装
//  QQ: 896525689
//  Created by Yulu Zhang on 16/4/18.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

#import "UITableViewCell+LayoutMargins.h"

@implementation UITableViewCell (LayoutMargins)

- (void)setTableViewCellMarginsIsZero {

    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }

}
@end
