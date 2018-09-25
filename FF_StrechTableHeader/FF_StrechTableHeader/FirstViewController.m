//
//  FirstViewController.m
//  FF_StrechTableHeader
//
//  Created by mac on 2018/9/25.
//  Copyright © 2018年 healifeGroup. All rights reserved.
//

#import "FirstViewController.h"

#define kHeaderHeight   240

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>


@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIImageView *headerView;

@property (nonatomic,assign) CGRect headerOriginRect;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];

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
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -kHeaderHeight);
    
    [self.view addSubview:self.tableView];
    
    
    self.headerOriginRect = CGRectMake(0, -kHeaderHeight, self.view.bounds.size.width, kHeaderHeight);
    self.headerView = [[UIImageView alloc] initWithFrame:self.headerOriginRect];
    self.headerView.image = [UIImage imageNamed:@"header"];
    self.headerView.backgroundColor = [UIColor orangeColor];
    [self.tableView addSubview:self.headerView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tap];
    
}

-(void)tap:(UITapGestureRecognizer *)sender{
    NSLog(@"----- tap -----");
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
    ///这句话很重要
    [self.tableView sendSubviewToBack:self.headerView];
    
    CGFloat offy = scrollView.contentOffset.y + kHeaderHeight;
    //NSLog(@"---offy = %.1f",offy);
    
    if (offy < 0.0) {
        ///向下
        ///这句话要写
        self.headerView.frame = self.headerOriginRect;
        
    }else{
        ///向上
        CGRect frame = self.headerOriginRect;
        frame.origin.y = offy-kHeaderHeight;
        self.headerView.frame = frame;
        
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    CGFloat offy = scrollView.contentOffset.y + kHeaderHeight;
    //NSLog(@"---offy = %.1f",offy);
    
    if (offy < 0.0) {
        ///向下
        self.headerView.frame = self.headerOriginRect;
        
    }else{
        ///向上
        if (fabs(offy) < kHeaderHeight/2.0) {
            [self.tableView setContentOffset:CGPointMake(0, -kHeaderHeight) animated:YES];
            
        }else if(fabs(offy) > kHeaderHeight/2.0 && fabs(offy) < kHeaderHeight){
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y + kHeaderHeight;
    //NSLog(@"---offy = %.1f",offy);
    
    if (offy < 0.0) {
        ///向下
        self.headerView.frame = self.headerOriginRect;
        
    }else{
        ///向上
        if (fabs(offy) < kHeaderHeight/2.0) {
            [self.tableView setContentOffset:CGPointMake(0, -kHeaderHeight) animated:YES];
            
        }else if(fabs(offy) > kHeaderHeight/2.0 && fabs(offy) < kHeaderHeight){
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
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
