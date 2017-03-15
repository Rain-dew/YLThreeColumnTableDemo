//
//  UIButton+LayoutMargins.h
//  封装
//  QQ: 896525689
//  Created by Yulu Zhang on 16/4/18.
//  Copyright © 2016年 Yulu Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LayoutMargins)
/** 创建tableView后调用
 *  只实现此方法，表格右侧还是会有一点空白(若不需要去除全部空白，则不需要实现cell分类方法)
 *  如果需要一点空白没有请在TableView代理方法:
 *  -(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
 *  实现cell分类:UITableViewCell+LayoutMargins的分类方法。
 */
-(void)setTableViewMarginsIsZero;
@end
