//
//  ViewController.m
//  YLThreeColumnTableDemo
//
//  Created by 张雨露 on 2017/3/15.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import "ViewController.h"
#import "YLDropDownTableView.h"
@interface ViewController ()<YLDropDownTableViewDelegate>
@property(nonatomic, strong) YLDropDownTableView *dropView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dropView = [[YLDropDownTableView alloc] initWithFrame:CGRectMake(0, 40 + 64, self.view.frame.size.width, 350)];
    self.dropView.delegate = self;
    [self.view addSubview:self.dropView];


    //构造数据
    for (int i = 0; i < 6; i++) {
        //一维数组
        [self.dropView.firstData addObject:[NSString stringWithFormat:@"第一列 %d",i]];
        NSMutableArray *two0 = [NSMutableArray array];
        NSMutableArray *third0 = [NSMutableArray array];
        for (int j = 0; j < 7; j++) {
            [two0 addObject:[NSString stringWithFormat:@"第二列 %d-%d",i,j]];
            NSMutableArray *third1 = [NSMutableArray array];
            for (int k = 0; k < 15; k++) {
                [third1 addObject:[NSString stringWithFormat:@"第三列 %d-%d-%d",i,j,k]];
            }
            [third0 addObject:third1];
        }
        //二维数组
        [self.dropView.secondeData addObject:two0];
        //三维数组
        [self.dropView.thirdData addObject:third0];
    }

    [self.dropView reloadData];

}


//show
- (IBAction)showDropView:(id)sender {
    
    [self.dropView show];
    
}
#pragma mark -- YLDropDownTableViewDelegate
- (void)didSeleted_ylDropDownWithFirstStr:(NSString *)firstTitle andSecondTitle:(NSString *)secondTitle andThirdTitle:(NSString *)thirdTitle {

    NSLog(@"1 : %@  2 : %@  3 : %@", firstTitle, secondTitle, thirdTitle);

}

//点击下部蒙版
- (void)touchShadowView {
    NSLog(@"点击了蒙版");
}

@end
