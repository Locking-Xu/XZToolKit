//
//  XZCommonKnowledgeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/31.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCommonKnowledgeViewController.h"
#import "XZCodeViewController.h"
#import "UINavigationController+Common.h"

#define TitleArray @[@"内联函数",@"ViewController的生命周期",@"Objective-C中关键字",@"单例创建",@"copy的setter方法",@"深拷贝与浅拷贝",@"OOP语言三大特征",@"new和alloc init",@"BOOL类型",@"Block使用",@"@synchronized",@"代理和通知的区别",@"类别和类扩展",@"initWithCoder和initWithFrame",@"单例继承",@"Documents、Library、tmp区别"]

@interface XZCommonKnowledgeViewController ()<UITableViewDataSource,UITableViewDelegate>{

    
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation XZCommonKnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return TitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"homeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = TitleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
    codeVc.knowledgeTitle = TitleArray[indexPath.row];
    [self.navigationController pushViewController:codeVc animated:YES];
}

@end
