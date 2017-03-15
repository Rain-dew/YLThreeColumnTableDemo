//
//  YLDropDownTableView.h
//  MMComboBoxDemo
//
//  Created by 张雨露 on 2017/3/13.
//  Copyright © 2017年 Raindew. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YLDropDownTableViewDelegate <NSObject>
//做出了最终的选择，当点击第三列cell时调用此代理
- (void)didSeleted_ylDropDownWithFirstStr:(NSString *)firstTitle andSecondTitle:(NSString *)secondTitle andThirdTitle:(NSString *)thirdTitle;
@optional
//点击蒙版
- (void)touchShadowView;
@end
@interface YLDropDownTableView : UIView

//第一个列表数据  一维数组
@property (nonatomic, strong) NSMutableArray *firstData;
//第二个列表数据  二维数组
@property (nonatomic, strong) NSMutableArray *secondeData;
//第三个列表数据  三维数组
@property (nonatomic, strong) NSMutableArray *thirdData;
@property(nonatomic, weak) id<YLDropDownTableViewDelegate> delegate;
//刷新数据 数据赋值后调用
- (void)reloadData;
//视图出现时调用
- (void)show;
//视图消失时调用
- (void)dismiss;

//备注：
//为了UI美观。创建的时候，高度尽量根据数据个数来定，每行cell高44 自行计算总高即可（不可超出屏幕）。
@end
