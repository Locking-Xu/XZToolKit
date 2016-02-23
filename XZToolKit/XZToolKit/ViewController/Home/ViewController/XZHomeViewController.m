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
#import "XZCoreAnimationViewController.h"
#import "XZCAShapeLayerViewController.h"
#import "XZEventsThroughViewController.h"
#import "XZGuideViewController.h"
#import "XZLovelyLoginViewController.h"

#import "UINavigationController+Common.h"
#import "XZAlbumHelper.h"
#import "XZUtils.h"
#import "XZBezierPathViewController.h"
#import "XZAVFoundationViewController.h"
#import "XZStripTableViewProtocolViewController.h"
#import "XZQuartz2DViewController.h"
#import "XZGifPlayerViewController.h"

@interface XZHomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    
    __weak IBOutlet UITableView *_tableView;
    
    NSArray *_demoList;
    
    NSArray *_knowledgeList;
    
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
    
    
    NSString *demoPath = [[NSBundle mainBundle] pathForResource:@"DemoList" ofType:@"plist"];
    
    _demoList = [NSArray arrayWithContentsOfFile:demoPath];
    
    NSString *knowledgePath = [[NSBundle mainBundle] pathForResource:@"KnowledgeList" ofType:@"plist"];
    _knowledgeList = [NSArray arrayWithContentsOfFile:knowledgePath];
    
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
        
        return _demoList.count;
    }else if (section == 1){
        
        return _knowledgeList.count;
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
        
        cell.textLabel.text = _demoList[indexPath.row];
        
    }else if (indexPath.section == 1){
    
        cell.textLabel.text = _knowledgeList[indexPath.row];
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
                
                addressBookVc.title = _demoList[indexPath.row];
                
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
                    
                    photoAlbumVc.title = _demoList[indexPath.row];
                    
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
    
                popViewVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:popViewVc animated:YES];
            }
                break;
            //CollectionViewLayout
            case 6:
            {
                XZCollectionViewLayoutViewController *collectionViewLayoutVc = [[XZCollectionViewLayoutViewController alloc] init];
                collectionViewLayoutVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:collectionViewLayoutVc animated:YES];
            }
                break;
            //CoreAnimation
            case 7:
            {
                XZCoreAnimationViewController *coreAnimationVc = [[XZCoreAnimationViewController alloc] initWithNibName:@"XZCoreAnimationViewController" bundle:[NSBundle mainBundle]];
                coreAnimationVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:coreAnimationVc animated:YES];
            }
                break;
            //CAShapeLayer
            case 8:
            {
                XZCAShapeLayerViewController *caShapeLayerVc = [[XZCAShapeLayerViewController alloc] init];
                caShapeLayerVc.title = _demoList[indexPath.row];
                
                [self.navigationController pushViewController:caShapeLayerVc animated:YES];
            }
                break;
            //事件穿透
            case 9:
            {
                XZEventsThroughViewController *eventsThroughVc = [[XZEventsThroughViewController alloc] init];
                eventsThroughVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:eventsThroughVc animated:YES];
            }
                break;
            //应用引导页
            case 10:
            {
                XZGuideViewController *guideViewVc = [[XZGuideViewController alloc] init];
                
                [self.navigationController pushViewController:guideViewVc animated:YES];
            }
                break;
            //可爱的登录页面
            case 11:
            {
                XZLovelyLoginViewController *lovelyLoginVc = [[XZLovelyLoginViewController alloc] init];
                lovelyLoginVc.title = _demoList[indexPath.row];
                
                [self.navigationController pushViewController:lovelyLoginVc animated:YES];
                
            }
                break;
            //贝塞尔曲线
            case 12:
            {
                XZBezierPathViewController *bezierPathVc = [[XZBezierPathViewController alloc] init];
                bezierPathVc.title = _demoList[indexPath.row];
                
                [self.navigationController pushViewController:bezierPathVc animated:YES];
            }
                break;
            //AVFundation
            case 13:
            {
                XZAVFoundationViewController *avFoundationVc = [[XZAVFoundationViewController alloc] init];
                avFoundationVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:avFoundationVc animated:YES];
            }
                break;
            //TableView代理剥离
            case 14:
            {
                XZStripTableViewProtocolViewController *stripTableViewProtocolVc = [[XZStripTableViewProtocolViewController alloc] init];
                stripTableViewProtocolVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:stripTableViewProtocolVc animated:YES];
            }
                break;
            //Quartz2D
            case 15:
            {
                XZQuartz2DViewController *quartz2DVc = [[XZQuartz2DViewController alloc] init];
                quartz2DVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:quartz2DVc animated:YES];
            }
                break;
            //GIF
            case 16:
            {
                XZGifPlayerViewController *gifPlayerVc = [[XZGifPlayerViewController alloc] init];
                gifPlayerVc.title = _demoList[indexPath.row];
                [self.navigationController pushViewController:gifPlayerVc animated:YES];
            }
                break;
            default:
                break;
        }

    }
    //Knowledge
    else if (indexPath.section == 1){
        
        NSString *path;
        
        switch (indexPath.row) {
            //@"知识杂记"
            case 0:
                path = [[NSBundle mainBundle] pathForResource:@"CommonKnowledgeList" ofType:@"plist"];
                break;
            //@"UITableView相关"
            case 1:
                path = [[NSBundle mainBundle] pathForResource:@"TableViewList" ofType:@"plist"];
                break;
            //@"UICollectionView相关"
            case 2:
                path = nil;
                break;
            //@"UINavigationController相关"
            case 3:
                path = [[NSBundle mainBundle] pathForResource:@"NavigationControllerList" ofType:@"plist"];
                break;
            //相册资源文件相关
            case 4:
                path = [[NSBundle mainBundle] pathForResource:@"AlbumList" ofType:@"plist"];
                break;
            //UITabBarController相关
            case 5:
                path = [[NSBundle mainBundle] pathForResource:@"TabBarControllerList" ofType:@"plist"];
                break;
            default:
                break;
        }
        
        
        XZCommonListViewController *commonListVc = [[XZCommonListViewController alloc] initWithNibName:@"XZCommonListViewController" bundle:[NSBundle mainBundle]];
        
        commonListVc.title = _knowledgeList[indexPath.row];
        commonListVc.titleList = [NSArray arrayWithContentsOfFile:path];
        
        [self.navigationController pushViewController:commonListVc animated:YES];
    }
    
}

@end
