//
//  XZMutableAttributeStringViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/14.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZMutableAttributeStringViewController.h"
#import "NSMutableAttributedString+Structure.h"

@interface XZMutableAttributeStringViewController (){

    NSMutableAttributedString *_string;
    NSRange _range;
}

@end

@implementation XZMutableAttributeStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _range = NSMakeRange(0, 2);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _string = [[NSMutableAttributedString alloc] initWithString:@"这里是富文本"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.attributedText = [_string setTextWithColor:[UIColor redColor] inRange:_range];
            break;
        case 1:
            cell.textLabel.attributedText = [_string setTextWithFont:[UIFont systemFontOfSize:40.0f] inRange:_range];
            break;
        case 2:
            cell.textLabel.attributedText = [_string setTextWithBackgroundColor:[UIColor yellowColor] inRange:_range];
            break;
        case 3:
            cell.textLabel.attributedText = [_string setTextWithStrokeColor:[UIColor purpleColor] strokeWidth:2.0f inRange:_range];
            break;
        case 4:
        {
            NSShadow *shadow = [[NSShadow alloc] init];
            shadow.shadowColor = [UIColor redColor];
            shadow.shadowBlurRadius = 2;
            shadow.shadowOffset = CGSizeMake(2.0f, 2.0f);
            cell.textLabel.attributedText = [_string setTextWithShadow:shadow inRange:_range];
        }
            break;
        case 5:
            cell.textLabel.attributedText = [_string setTextWithDeleteLine:NSUnderlineStyleSingle color:[UIColor orangeColor] inRange:_range];
            break;
        case 6:
            cell.textLabel.attributedText = [_string setTextWithUnderLine:NSUnderlineStyleDouble color:[UIColor blackColor] inRange:_range];
            break;
        case 7:
            cell.textLabel.attributedText = [_string setTextWithKern:5.0f inRange:_range];
            break;
        case 8:
        {
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.paragraphSpacing = 10.0f;
            cell.textLabel.attributedText = [_string setTextWithParagraphStyle:style inRange:_range];
        }
            break;
        case 9:
            cell.textLabel.attributedText = [_string setTextWithEffect:NSTextEffectLetterpressStyle inRange:_range];
            break;
        case 10:
            cell.textLabel.attributedText = [_string setTextWithLigature:YES inRange:_range];
            break;
        case 11:
            cell.textLabel.attributedText = [_string setTextWithObliqueness:1.0f inRange:_range];
            break;
        case 12:
            cell.textLabel.attributedText = [_string setTextWithBaseLineOffset:10.0f inRange:_range];
            break;
        case 13:
            cell.textLabel.attributedText = [_string setTextWithExpansion:-1.3 inRange:_range];
            break;
        case 14:
            cell.textLabel.attributedText = [_string setTextWithURL:[NSURL URLWithString:@"www.baidu.com"] inRange:_range];
            break;
        case 15:
        {
            NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
            attach.image = [UIImage imageNamed:@"Calendar"];
            
            NSMutableAttributedString *tmpStr = [[NSMutableAttributedString alloc] initWithString:@"文字\uFFFC混合排列"];
            
            [tmpStr setTextWithAttacment:attach inRange:NSMakeRange(2, 1)];
            
            cell.textLabel.attributedText = tmpStr;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

@end
