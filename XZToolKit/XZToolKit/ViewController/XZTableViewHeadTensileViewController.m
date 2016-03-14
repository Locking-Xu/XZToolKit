//
//  XZTableViewHeadTensileViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/12.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZTableViewHeadTensileViewController.h"
#import "UIImage+Color.h"
#import "XZNavigationBackButton.h"

@interface XZTableViewHeadTensileViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *headView;
@end

@implementation XZTableViewHeadTensileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 64.0f)];
    self.headView.backgroundColor = [UIColor clearColor];
    
    XZNavigationBackButton *backBtn = [[XZNavigationBackButton alloc] initWithFrame:CGRectMake(12, 31, 100, 22.0f)];
    
    backBtn.viewController = self;
    backBtn.backgroundColor = [UIColor clearColor];
    
    [self.headView addSubview:backBtn];
    
    [self.view addSubview:self.headView];
    
    

    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 200.0f)];
    self.imageView.image = [UIImage imageNamed:@"2"];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 300.0f)];
    
    [self.tableView.tableHeaderView addSubview:self.imageView];
    [self.view insertSubview:self.tableView belowSubview:self.headView];
    
    // Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return cell;
}

#pragma mark - UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat proportation = -scrollView.contentOffset.y / 200;
    
    if (scrollView.contentOffset.y < 0) {
        
        self.imageView.frame = CGRectMake(-proportation *UISCREEN_WIDTH/2.0, scrollView.contentOffset.y,UISCREEN_WIDTH*(1+proportation), 200-scrollView.contentOffset.y);
    }
    else if(scrollView.contentOffset.y >= 100.0f && -proportation < 1.0f){
    
        self.headView.backgroundColor = RGBA(255, 0, 0, -proportation);
    }else if (scrollView.contentOffset.y < 100.0f){
    
        self.headView.backgroundColor = [UIColor clearColor];
    }
    
}
@end
