//
//  YLDropDownTableView.m
//  MMComboBoxDemo
//
//  Created by 张雨露 on 2017/3/13.
//  Copyright © 2017年 Raindew. All rights reserved.
//

#import "YLDropDownTableView.h"
#import "UITableView+LayoutMargins.h"
#import "UITableViewCell+LayoutMargins.h"
#import "YLInsetLabel.h"
@interface YLDropDownTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *midTableView;
@property (nonatomic, strong) UITableView *rightTableView;
//用来记录选择数据对应的cell下标。三层只需要两个值即可
@property (nonatomic, strong) NSMutableArray *IndexPathArray;
//用来记录每次选择的indexPath. 需要三个元素
@property (nonatomic, strong) NSMutableArray *selectedArray;
//self的高度 内部使用
@property (nonatomic, assign) float height;
//蒙版
@property(nonatomic, strong) UIView *shadowView;

@end
#define SelectedColor [UIColor colorWithRed:109/255. green:181/255. blue:149/255. alpha:1.]
@implementation YLDropDownTableView
#pragma mark -- 懒加载
- (UITableView *)leftTableView {
    if (nil == _leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.tableFooterView = [[UIView alloc] init];
        [_leftTableView setTableViewMarginsIsZero];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
    }
    return _leftTableView;
}

- (UITableView *)midTableView {
    
    if (nil == _midTableView) {
        _midTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _midTableView.backgroundColor = [UIColor colorWithRed:250/255. green:250/255. blue:250/255. alpha:1];
        _midTableView.tableFooterView = [[UIView alloc] init];
        [_midTableView setTableViewMarginsIsZero];
        _midTableView.delegate = self;
        _midTableView.dataSource = self;
    }
    return _midTableView;
}

- (UITableView *)rightTableView {
    if (nil == _rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _rightTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _rightTableView.tableFooterView = [[UIView alloc] init];
        [_rightTableView setTableViewMarginsIsZero];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
    }
    return _rightTableView;
}
#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0)]) {
        self.height = frame.size.height;
        self.selectedArray = [NSMutableArray arrayWithArray:@[@"0", @"0",@"0"]];
        self.IndexPathArray = [NSMutableArray arrayWithArray:@[@"0",@"0"]];
        self.firstData = [NSMutableArray array];
        self.secondeData = [NSMutableArray array];
        self.thirdData = [NSMutableArray array];
        [self setupUI];
    
    }
    return self;
}
#pragma mark -- 设置UI
- (void)setupUI {
    
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
    [self addSubview:self.midTableView];
    
    self.shadowView = [[UIView alloc] init];
    self.shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    self.shadowView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchShadow)];
    [self.shadowView addGestureRecognizer:tap];
    [self addSubview:self.shadowView];
}
#pragma mark -- 加载数据源
- (void)reloadData {
        
    [self.leftTableView reloadData];
    [self.midTableView reloadData];
    [self.rightTableView reloadData];
    
    
}
#pragma mark -- 点击蒙版
- (void)touchShadow {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DISMISS" object:nil];
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchShadowView)]) {
        [self.delegate touchShadowView];
    }

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.firstData.count ? self.firstData.count : 0;
    }else if (tableView == self.midTableView) {
        NSInteger index = [self.IndexPathArray[0] integerValue];
//        NSLog(@"%ld",index);
//        if (index >= self.secondeData.count) {
//            index = self.secondeData.count-1;
//        }
        NSArray *array = self.secondeData[index];
        
        return array.count ? array.count : 0;
    }else {
        
        NSInteger index = [self.IndexPathArray[0] integerValue];
        NSInteger index1 = [self.IndexPathArray[1] integerValue];
//        if (index >= self.thirdData.count) {
//            index = self.thirdData.count-1;
//        }
//        NSArray *a = self.thirdData[index];
//        if (index1 >= a.count) {
//            index1 = a.count-1;
//        }
//        NSLog(@"%ld",index1);

        NSArray *array = self.thirdData[index][index1];
        
        return array.count ? array.count : 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        YLInsetLabel *titleLabel = [[YLInsetLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        //设置label的内边距
        titleLabel.insets = UIEdgeInsetsMake(0, 20, 0, 0);
        titleLabel.tag = 100;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [cell.contentView addSubview:titleLabel];
        
        if (tableView == self.rightTableView) {
            UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_selected"]];
            imgV.frame = CGRectMake(10, (44-15) / 2, 15, 15);
            imgV.hidden = YES;
            imgV.tag = 101;
            [cell.contentView addSubview:imgV];
            titleLabel.frame = CGRectMake(20, 0, self.frame.size.width - 200 - 20 - 20, 44);
        }else {
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    }
    UILabel *label = [cell.contentView viewWithTag:100];
    if (tableView == self.leftTableView) {
        cell.backgroundColor = [UIColor whiteColor];
        label.text = self.firstData[indexPath.row];
        //满足一个条件，即可认为是上次选择项
        if ([self.selectedArray[0] integerValue] == indexPath.row) {
            label.textColor = SelectedColor;
        }else {
            label.textColor = [UIColor blackColor];

        }
    }else if (tableView == self.midTableView) {
        cell.backgroundColor = [UIColor colorWithRed:250/255. green:250/255. blue:250/255. alpha:1];
        NSInteger selected = [self.IndexPathArray[0] integerValue];
        label.text = self.secondeData[selected][indexPath.row];
        //同时满足两个tiao'j.即认为是上次选择的cell
        if([self.selectedArray[0] isEqual:self.IndexPathArray[0]] && [self.selectedArray[1] integerValue] == indexPath.row) {
            label.textColor = SelectedColor;
        }else {
            label.textColor = [UIColor blackColor];
        }
    }else {
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        NSInteger selected1 = [self.IndexPathArray[0] integerValue];
        NSInteger selected2 = [self.IndexPathArray[1] integerValue];
        UIImageView *imgV = [cell.contentView viewWithTag:101];
        
        //同时满足三个条件，即认为是上次选择的cell
        if ([self.selectedArray[2] integerValue] == indexPath.row && [self.selectedArray[0] isEqual:self.IndexPathArray[0]] && [self.selectedArray[1] isEqual:self.IndexPathArray[1]]) {
            imgV.hidden = NO;
            label.textColor = SelectedColor;
        }else {
            imgV.hidden = YES;
            label.textColor = [UIColor blackColor];
        }
        
        label.text = self.thirdData[selected1][selected2][indexPath.row];
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate,

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if (tableView == self.leftTableView) {

        self.IndexPathArray[0] = [NSString stringWithFormat:@"%ld", indexPath.row];
        //很重要的一步，把第二列的记录初始化，避免此时第二列已经点击被记录其他值
        //如果这个值大于下一次刷新的第二列的数组个数，会发生数组越界的崩溃
        //点击第一列，相当于后面两列数据从新分配，所以这里修改为初始值
        self.IndexPathArray[1] = @"0";
        [self.midTableView reloadData];
        [self.rightTableView reloadData];
    }else if (tableView == self.midTableView) {
        self.IndexPathArray[1] = [NSString stringWithFormat:@"%ld", indexPath.row];
        [self.rightTableView reloadData];
    }else {
        NSInteger selected2 = [self.IndexPathArray[1] integerValue];
        UIImageView *imgV = [cell.contentView viewWithTag:101];
        if (selected2 == indexPath.row && [self.selectedArray[0] isEqual: self.IndexPathArray[0]] && [self.selectedArray[1] isEqual:self.IndexPathArray[1]]) {
            imgV.hidden = NO;
        }
        //进行赋值。记录最终所选项的对应index
        self.selectedArray[0] = self.IndexPathArray[0];
        self.selectedArray[1] = self.IndexPathArray[1];
        self.selectedArray[2] = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        //刷新3列
        [self.leftTableView reloadData];
        [self.midTableView reloadData];
        [self.rightTableView reloadData];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSeleted_ylDropDownWithFirstStr:andSecondTitle:andThirdTitle:)]) {
            UILabel *label = [cell.contentView viewWithTag:100];
            [self.delegate didSeleted_ylDropDownWithFirstStr:self.firstData[[self.selectedArray[0] integerValue]] andSecondTitle:self.secondeData[[self.selectedArray[0] integerValue]][[self.selectedArray[1] integerValue]] andThirdTitle:label.text];
        }
        //延迟0.1为了等待UI刷新动画
        [self performSelector:@selector(dismiss) withObject:self afterDelay:0.1];
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setTableViewCellMarginsIsZero];
}

#pragma mark -- show

- (void)show {
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [UIScreen mainScreen].bounds.size.height - self.frame.origin.y);
        self.leftTableView.frame = CGRectMake(0, 0, 100, self.height);
        self.midTableView.frame = CGRectMake(100, 0, 100, self.height);
        self.rightTableView.frame = CGRectMake(200, 0, self.frame.size.width - 200, self.height);
    } completion:^(BOOL finished) {
        self.shadowView.frame = CGRectMake(0, self.height, self.frame.size.width, [UIScreen mainScreen].bounds.size.height - self.height -  self.frame.origin.y);
        self.shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }];
}

#pragma mark -- dismiss
- (void)dismiss {
    self.shadowView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0);
        self.leftTableView.frame = CGRectMake(0, 0, 100, 0);
        self.midTableView.frame = CGRectMake(100, 0, 100, 0);
        self.rightTableView.frame = CGRectMake(200, 0, self.frame.size.width - 200, 0);
    } completion:^(BOOL finished) {
        
    }];
}
@end
