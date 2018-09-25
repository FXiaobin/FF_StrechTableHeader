//
//  ViewController.m
//  FF_StrechTableHeader
//
//  Created by mac on 2018/9/25.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong) UITableView *tableView;


@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"2种拉伸效果";
    
    CGFloat stateBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    CGFloat originY = 64.0;
    if (stateBarH == 44.0) {
        originY = 88.0;
    }

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, originY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - originY) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView setTableFooterView:[UIView new]];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    
    [self.view addSubview:self.tableView];
 
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray *titles = @[@"仿淘宝详情页上滑遮盖图片效果",@"个人中心拉伸放大效果-1",@"个人中心拉伸放大效果-2"];
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FirstViewController *vc = [[FirstViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1) {
        SecondViewController *vc = [[SecondViewController alloc] init];
        vc.type = SecondViewControllerTypeFirst;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2) {
        SecondViewController *vc = [[SecondViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = SecondViewControllerTypeSecond;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
