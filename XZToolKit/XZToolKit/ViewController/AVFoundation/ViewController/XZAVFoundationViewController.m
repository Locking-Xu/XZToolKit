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
#import "XZSoundEffectViewController.h"
#import "XZMusicPlayerViewController.h"
#import "XZMusicLibraryViewController.h"
#import "XZRecorderViewController.h"
#import "XZMovieViewController.h"
#import "XZAVPlayerViewController.h"
#import "XZImagePickerViewController.h"
#import "XZCustomPhotoViewController.h"
#import "XZCustomVideoViewController.h"


#define TitleList @[@"音效",@"音乐",@"音乐库",@"录音",@"视频",@"AVPlayer",@"ImagePicker",@"自定义拍照",@"自定义录视频"]

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return TitleList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"MY_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = TitleList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.navigationController setBackItemTitle:@"" viewController:self];
    
    switch (indexPath.row) {
        case 0:
        {
            XZSoundEffectViewController *soundEffectVc = [[XZSoundEffectViewController alloc] initWithNibName:@"XZSoundEffectViewController" bundle:[NSBundle mainBundle]];
            soundEffectVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:soundEffectVc animated:YES];
        }
            break;
        case 1:
        {
            XZMusicPlayerViewController *musicPlayerVc = [[XZMusicPlayerViewController alloc] initWithNibName:@"XZMusicPlayerViewController" bundle:[NSBundle mainBundle]];
            musicPlayerVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:musicPlayerVc animated:YES];
        }
            break;
        case 2:
        {
            XZMusicLibraryViewController *musicLibraryVc = [[XZMusicLibraryViewController alloc] initWithNibName:@"XZMusicLibraryViewController" bundle:[NSBundle mainBundle]];
            musicLibraryVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:musicLibraryVc animated:YES];
        }
            break;
        case 3:
        {
            XZRecorderViewController *recorderVc = [[XZRecorderViewController alloc] initWithNibName:@"XZRecorderViewController" bundle:[NSBundle mainBundle]];
            recorderVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:recorderVc animated:YES];
        }
            break;
        case 4:
        {
            XZMovieViewController *movieVc = [[XZMovieViewController alloc] init];
            movieVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:movieVc animated:YES];
        }
            break;
        case 5:
        {
            XZAVPlayerViewController *avPlayerVc = [[XZAVPlayerViewController alloc] init];
            avPlayerVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:avPlayerVc animated:YES];
        }
            break;
        case 6:
        {
            XZImagePickerViewController *imagePickerVc = [[XZImagePickerViewController alloc] init];
            imagePickerVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:imagePickerVc animated:YES];
        }
            break;
        case 7:
        {
            XZCustomPhotoViewController *customPhotoVc = [[XZCustomPhotoViewController alloc] init];
            customPhotoVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:customPhotoVc animated:YES];
        }
            break;
        case 8:
        {
            XZCustomVideoViewController *customVideoVc = [[XZCustomVideoViewController alloc] init];
            customVideoVc.title = TitleList[indexPath.row];
            [self.navigationController pushViewController:customVideoVc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
