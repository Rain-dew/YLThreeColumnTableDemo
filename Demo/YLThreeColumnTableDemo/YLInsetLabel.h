//
//  YLInsetLabel.h
//  
//
//  Created by 张雨露 on 2017/3/14.
//  Copyright © 2017年 Riandew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLInsetLabel : UILabel
//用于设置Label的内边距
@property(nonatomic) UIEdgeInsets insets;
//初始化方法一
-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
//初始化方法二
-(id) initWithInsets:(UIEdgeInsets)insets;
@end
