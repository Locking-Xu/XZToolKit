//
//  XZAVFoundationViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/13.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZAVFoundationViewController.h"
#import "UINavigationController+Common.h"
#import "XZCodeViewController.h"
#import "XZAudioViewController.h"


#define DemoList @[@"音频Demo"]
#define KnowledgeList @[@"音效",@"相机"]

@interface XZAVFoundationViewController ()

@end

@implementation XZAVFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView_DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return section == 0 ? @"Knowledge" : @"Demo";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return section == 0 ? KnowledgeList.count : DemoList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"MY_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = indexPath.section == 0 ? KnowledgeList[indexPath.row] : DemoList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    if (indexPath.section == 0) {
        
        XZCodeViewController *codeVc = [[XZCodeViewController alloc] init];
        codeVc.knowledgeTitle = KnowledgeList[indexPath.row];
        [self.navigationController pushViewController:codeVc animated:YES];
        return;
    }
    else if (indexPath.section == 1){
    
        switch (indexPath.row) {
            case 0:
            {
                XZAudioViewController *audioVc = [[XZAudioViewController alloc] initWithNibName:@"XZAudioViewController" bundle:[NSBundle mainBundle]];
                audioVc.title = DemoList[indexPath.row];
                [self.navigationController pushViewController:audioVc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    
}
@end
