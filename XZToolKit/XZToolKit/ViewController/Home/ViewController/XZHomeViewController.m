//
//  XZHomeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/17.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZCalendarViewController.h"
#import "XZAddressBookViewController.h"
#import "UINavigationController+Common.h"


#define TitleList @[@"日历",@"通讯录",@"轮播图",@"TabBar"]

@interface XZHomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    __weak IBOutlet UITableView *_tableView;
    
    
}

@end

@implementation XZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ToolKit";
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return TitleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"homeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"Calendar"];
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = TitleList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            XZCalendarViewController *calendarVc = [[XZCalendarViewController alloc] init];
            
            [self.navigationController setBackItemTitle:@"" viewController:self];
            
            [self.navigationController pushViewController:calendarVc animated:YES];
        }
            break;
        case 1:
        {
            XZAddressBookViewController *addressBookVc = [[XZAddressBookViewController alloc] init];
            
            [self.navigationController setBackItemTitle:@"" viewController:self];
            
            [self.navigationController pushViewController:addressBookVc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
