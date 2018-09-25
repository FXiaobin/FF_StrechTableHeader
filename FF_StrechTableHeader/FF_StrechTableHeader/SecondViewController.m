//
//  SecondViewController.m
//  FF_StrechTableHeader
//
//  Created by mac on 2018/9/25.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "SecondViewController.h"

#define kHeaderHeight   240

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIImageView *headerView;

@property (nonatomic,assign) CGRect headerOriginRect;

@end

@implementation SecondViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView setTableFooterView:[UIView new]];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -kHeaderHeight);
    
    [self.view addSubview:self.tableView];
    
    
    self.headerOriginRect = CGRectMake(0, 0, self.view.bounds.size.width, kHeaderHeight);
    self.headerView = [[UIImageView alloc] initWithFrame:self.headerOriginRect];
    self.headerView.image = [UIImage imageNamed:@"header01"];
    ///裁剪 这一句很重要
    self.headerView.clipsToBounds = YES;
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.headerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.headerView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tap];
    
}

-(void)tap:(UITapGestureRecognizer *)sender{
    NSLog(@"----- tap -----");
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [UIView new];
    header.backgroundColor = [UIColor redColor];
    return header;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offy = scrollView.contentOffset.y + kHeaderHeight;
    //NSLog(@"---offy = %.1f",offy);

    if (self.type == SecondViewControllerTypeFirst) {
        ///第1种效果
        CGRect rect = self.headerOriginRect;
        rect.size.height -= offy;
        self.headerView.frame = rect;
        
    }else if (self.type == SecondViewControllerTypeSecond){
        ///第2种效果
        if (offy < 0.0) {
            ///向下
            ///这句话要写
            CGRect rect = self.headerOriginRect;
            rect.size.height += fabs(offy);
            self.headerView.frame = rect;
            
        }else{
            ///向上
            CGRect frame = self.headerOriginRect;
            frame.origin.y = -offy;
            self.headerView.frame = frame;
        }
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
