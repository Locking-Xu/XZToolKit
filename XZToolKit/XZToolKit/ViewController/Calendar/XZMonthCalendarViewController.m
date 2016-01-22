//
//  XZMonthCalendarViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/21.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMonthCalendarViewController.h"
#import "XZMonthCalendarCell.h"
#import "NSDate+String.h"
#import "UINavigationController+Common.h"
#import "XZTipView.h"

@interface XZMonthCalendarViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UITableView *_tableView;
    CGFloat _cellHeight;
    
    NSInteger  _offset;
    
    XZTipView *_tipView;
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
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView reloadData];
    //tableView滚到中间
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _tipView = ({
        
        XZTipView *view = [[XZTipView alloc] initWithFrame:CGRectMake(0, 30, UISCREEN_WIDTH, 30)];
        view.backgroundColor = [UIColor greenColor];
        view.alpha = 0.0f;
        [self.view addSubview:view];
        view;
    });

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
    
    NSDate *tmpDate = [self.date dateByAddingValue:indexPath.row - 10 + 10*(_offset) forKey:@"month"];
    
    NSString *month = [NSDate stringFromDate:tmpDate format:@"  MM月"];
    
    cell.titleLab.text = month;
    
    [cell setUpCellWithDate:tmpDate];
    
    return cell;
}


#pragma mark - UIScrollView_Delegate
- (void)changeYearAndMonth:(CGFloat)contentOffset_Y{

    NSArray *indexArray = _tableView.indexPathsForVisibleRows;
    
    if (indexArray.count > 0){
        
        NSIndexPath *indexPath = indexArray.firstObject;
        
        CGFloat height = _cellHeight*(indexPath.row + 1);
        
        if ((height - contentOffset_Y) < _cellHeight/2) {
            
            NSDate *tmpDate = [self.date dateByAddingValue:indexPath.row - 10 + 10*(_offset)+1 forKey:@"month"];
            
            NSString *string = [NSDate stringFromDate:tmpDate format:@"yyyy年MM月"];
            
            [self.navigationController setBackItemTitle:string viewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2]];
            
            _tipView.label.text = string;
        }
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGPoint contentOffset  = scrollView.contentOffset;
    
    if (contentOffset.y <= _cellHeight) {
        
        contentOffset.y = scrollView.contentSize.height/2 + _cellHeight;
        
        _offset--;
    }else if (contentOffset.y >= scrollView.contentSize.height - _cellHeight*2){
        
        contentOffset.y = scrollView.contentSize.height/2 - _cellHeight*2;
        _offset++;
    }
  
    [self changeYearAndMonth:contentOffset.y];
    
    [scrollView setContentOffset:contentOffset];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [_tipView showWithTime:0.5];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (velocity.y == 0) {
        
        [_tipView hideWithTime:0.5];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [_tipView hideWithTime:0.5f];
}
@end
