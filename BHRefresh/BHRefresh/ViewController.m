//
//  ViewController.m
//  BHRefresh
//
//  Created by sp on 2019/9/12.
//  Copyright © 2019 sp. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "BHTypeView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)BHTypeView *headView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUI];
    
}


-(void)setUI{
    
    [self.view addSubview:self.tableView];
    
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%d类型---第%zd",self.headView.type,indexPath.row+1];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.tableHeaderView = self.headView;
        __weak typeof(self) weakSelf = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"刷新第%d",self.headView.type);
            
            [self.tableView reloadData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
    return _tableView;
}



-(BHTypeView *)headView{
    if (!_headView) {
        _headView = [BHTypeView typeViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    }
    return _headView;
}




@end
