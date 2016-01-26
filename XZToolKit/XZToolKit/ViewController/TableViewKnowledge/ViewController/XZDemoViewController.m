//
//  XZDemoViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/25.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZDemoViewController.h"
#import "AppDelegate.h"

@interface XZDemoViewController ()

@end

@implementation XZDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"TableView下划线左到头显示";
    
    
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
//    {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 20)];
//    }
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
//    {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 50)];
//    }
    
//    [self.tableView removeFromSuperview];
    
//    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
//    
//    textView.text = content;
//    
//    [self.view addSubview:textView];
    

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

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
    
    static NSString *identifier = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 50)];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 50)];
//    }
//}

@end
