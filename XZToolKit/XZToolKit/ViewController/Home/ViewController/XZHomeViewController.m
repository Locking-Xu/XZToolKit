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
#import "XZPopViewViewController.h"
#import "XZCommonListViewController.h"
#import "XZCollectionViewLayoutViewController.h"
#import "XZAlbumListController.h"

#import "UINavigationController+Common.h"
#import "XZAlbumHelper.h"
#import "XZUtils.h"


#define KnowledgeList @[@"知识杂记",@"UITableView相关",@"UICollectionView相关",@"UINavigationController相关",@"相册资源文件相关"]

#define DemoList @[@"日历",@"通讯录",@"轮播图",@"TabBar",@"相册",@"PopView",@"UICollectionViewLayout"]

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return DemoList.count;
    }else if (section == 1){
        
        return KnowledgeList.count;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"Demo";
        
    }else if (section == 1){
        
        return @"Knoeledge";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.0f;
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = DemoList[indexPath.row];
        
    }else if (indexPath.section == 1){
    
        cell.textLabel.text = KnowledgeList[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    //Demo
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            //日历
            case 0:
            {
                XZCalendarViewController *calendarVc = [[XZCalendarViewController alloc] init];
                
                calendarVc.title = @"年历";
                
                [self.navigationController pushViewController:calendarVc animated:YES];
            }
                break;
            //通讯录
            case 1:
            {
                XZAddressBookViewController *addressBookVc = [[XZAddressBookViewController alloc] init];
                
                addressBookVc.title = DemoList[indexPath.row];
                
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
            //相册
            case 4:
            {
                
                WS(weakSelf);
                
                [[XZAlbumHelper shareInstance] getAlbumPermissionsSuccessful:^(NSString *message) {
                    
                    XZAlbumListController *photoAlbumVc = [[XZAlbumListController alloc] init];
                    
                    photoAlbumVc.title = DemoList[indexPath.row];
                    
                    [weakSelf.navigationController pushViewController:photoAlbumVc animated:YES];
                    
                } fail:^(NSString *message) {
                    
                    [XZUtils showAlertView:message];
                }];
                
                
                
            }
                break;
            //popView
            case 5:
            {
                
                XZPopViewViewController *popViewVc = [[XZPopViewViewController alloc] init];
    
                popViewVc.title = DemoList[indexPath.row];
                [self.navigationController pushViewController:popViewVc animated:YES];
            }
                break;
            
            case 6:
            {
                XZCollectionViewLayoutViewController *collectionViewLayoutVc = [[XZCollectionViewLayoutViewController alloc] init];
                collectionViewLayoutVc.title = DemoList[indexPath.row];
                [self.navigationController pushViewController:collectionViewLayoutVc animated:YES];
            }
            default:
                break;
        }
        
        
    }
    //Knowledge
    else if (indexPath.section == 1){
        
        NSArray *titleList;
        
        switch (indexPath.row) {
            //@"知识杂记"
            case 0:
            {
                titleList = @[@"内联函数",@"ViewController的生命周期",@"Objective-C中关键字",@"单例创建",@"copy的setter方法",@"深拷贝与浅拷贝",@"OOP语言三大特征",@"new和alloc init",@"BOOL类型",@"Block使用",@"@synchronized",@"代理和通知的区别",@"类别和类扩展",@"initWithCoder和initWithFrame",@"单例继承",@"Documents、Library、tmp区别",@"静态Cell",@"枚举",@"使用Size Class适应屏幕旋转",@"IOS的生命周期",@"类方法",@"形参个数可变方法",@"屏幕旋转",@"键值编码KVC",@"键值监听KVO",@"判断指针变量的实际类型",@"==和isEqual方法",@"动态调用方法",@"面向对象相关",@"对象复制",@"NSSet",@"谓词NSPredicate",@"NSFileHandle",@"归档",@"UILabel",@"UITextField",@"UIVisualEffectView"];
            }
                break;
            //@"UITableView相关"
            case 1:
            {
                titleList = @[@"TableView下划线左右间距",@"TableView不显示多余Cell",@"TableView索引"];
            }
                break;
            //@"UICollectionView相关"
            case 2:
            {
                titleList = @[];
            }
                break;
            //@"UINavigationController相关"
            case 3:
            {
                titleList = @[];
            }
                break;
            //相册资源文件相关
            case 4:
            {
                titleList = @[@"ALAssetRepresentation",@"ALAsset",@"ALAssetsGroup",@"ALAssetsFilter",@"ALAssetsLibrary",@"PHFetchOptions",@"PHAssetCollection",@"PHFetchResult",@"PHAsset",@"PhotosTypes",@"PHImageRequestOptions",@"PHImageManager"];
            }
                
                break;
            default:
                break;
        }
        
        
        XZCommonListViewController *commonListVc = [[XZCommonListViewController alloc] initWithNibName:@"XZCommonListViewController" bundle:[NSBundle mainBundle]];
        
        commonListVc.title = KnowledgeList[indexPath.row];
        commonListVc.titleList = titleList;
        
        [self.navigationController pushViewController:commonListVc animated:YES];
    }
    
}

@end
