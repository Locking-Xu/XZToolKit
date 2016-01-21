//
//  XZMonthCalendarViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMonthCalendarViewController.h"
#import "XZMonthCalendarCell.h"

@interface XZMonthCalendarViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *_tableView;
    CGFloat _cellHeight;
    
    NSInteger  _offset;
}

@end

@implementation XZMonthCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"日历";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _cellHeight = [XZMonthCalendarCell heightOfCell];
    _tableView.rowHeight = _cellHeight;
    
    [_tableView reloadData];
    //tableView滚到中间
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"monthCalendarCell";
    
    XZMonthCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[XZMonthCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.titleLab.text = [NSString stringWithFormat:@"%@月",self.month];
    
    return cell;
}

#pragma mark - UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint contentOffset  = scrollView.contentOffset;
    
    if (contentOffset.y <= _cellHeight) {
        
        contentOffset.y = scrollView.contentSize.height/2 + _cellHeight;
        
        _offset--;
    }else if (contentOffset.y >= scrollView.contentSize.height - _cellHeight*2){
        
        contentOffset.y = scrollView.contentSize.height/2 - _cellHeight*2;
        _offset++;
    }
    
    [scrollView setContentOffset:contentOffset];
}

@end
