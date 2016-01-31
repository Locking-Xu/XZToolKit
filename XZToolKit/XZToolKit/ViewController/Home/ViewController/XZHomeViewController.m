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
#import "XZTableViewKnowledgeViewController.h"
#import "XZPhotoAlbumViewController.h"
#import "XZCollectionKnowledgeViewController.h"
#import "XZPopViewViewController.h"
#import "XZCommonKnowledgeViewController.h"


#define TitleList @[@"日历",@"通讯录",@"轮播图",@"TabBar",@"UITableView相关",@"相册",@"UICollectionView相关",@"PopView",@"知识杂记"]

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
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    switch (indexPath.row) {
        //日历
        case 0:
        {
            XZCalendarViewController *calendarVc = [[XZCalendarViewController alloc] init];
            
            [self.navigationController pushViewController:calendarVc animated:YES];
        }
            break;
        //通讯录
        case 1:
        {
            XZAddressBookViewController *addressBookVc = [[XZAddressBookViewController alloc] init];
            
            [self.navigationController pushViewController:addressBookVc animated:YES];
        }
            break;
        //轮播图
        case 2:
        {
        
        }
            break;
        //TabBar
        case 3:
        {
        
        }
            break;
        //UITableView相关
        case 4:
        {
            XZTableViewKnowledgeViewController *tableViewKnowledgeVc = [[XZTableViewKnowledgeViewController alloc] init];
            
            [self.navigationController pushViewController:tableViewKnowledgeVc animated:YES];
         }
            break;
        //图片浏览器
        case 5:
        {
            XZPhotoAlbumViewController *photoAlbumVc = [[XZPhotoAlbumViewController alloc] initWithNibName:@"XZPhotoAlbumViewController" bundle:[NSBundle mainBundle]];
            
            photoAlbumVc.title = TitleList[indexPath.row];
            
            [self.navigationController pushViewController:photoAlbumVc animated:YES];
            
        }
            break;
        //UICollectionView相关
        case 6:
        {
            XZCollectionKnowledgeViewController *collectionViewKnowledgeVc = [[XZCollectionKnowledgeViewController alloc] init];
            
            collectionViewKnowledgeVc.title = TitleList[indexPath.row];
            
            [self.navigationController pushViewController:collectionViewKnowledgeVc animated:YES];
            
        }
            break;
        //popView
        case 7:
        {
         
            XZPopViewViewController *popViewVc = [[XZPopViewViewController alloc] init];
            
            popViewVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:popViewVc animated:YES];
        }
            break;
        //知识杂记
        case 8:
        {
            
            XZCommonKnowledgeViewController *commonKnowledgeVc = [[XZCommonKnowledgeViewController alloc] init];
            
            commonKnowledgeVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:commonKnowledgeVc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
