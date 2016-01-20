//
//  XZCalendarViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCalendarViewController.h"
#import "XZCalendarCell.h"
#import "NSDate+String.h"


@interface XZCalendarViewController (){

    CGFloat _cellHeight;
    
    NSInteger  _offset;
}

@end

@implementation XZCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"日历";
    

    
    _cellHeight = [XZCalendarCell heightOfCell];
    self.tableView.rowHeight = _cellHeight;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView reloadData];
    //tableView滚到中间
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:10 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView_DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"calendarCell";
    
    XZCalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        
        cell = [[XZCalendarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    NSDate *date = [[NSDate date] dateByAddingValue:indexPath.row - 10 + 10*(_offset) forKey:@"year"];
    
    
    NSString *string = [NSDate stringFromDate:date format:@"yyyy"];
    
    cell.yearLabel.text = string;
    
    [cell setUpCellWithDate:date];
    
    return cell;
}

#pragma mark - UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint contentOffset  = scrollView.contentOffset;
    
    //    NSLog(@"%f",contentOffset.y);
    
    if (contentOffset.y <= _cellHeight) {
        
        contentOffset.y = scrollView.contentSize.height/2 + _cellHeight;
        
        _offset--;
        //        NSLog(@"size = %@",NSStringFromCGSize(scrollView.contentSize));
        
    }else if (contentOffset.y >= scrollView.contentSize.height - _cellHeight*2){
        
        contentOffset.y = scrollView.contentSize.height/2 - _cellHeight*2;
        
        _offset++;
    }
    
    [scrollView setContentOffset:contentOffset];
}

@end
