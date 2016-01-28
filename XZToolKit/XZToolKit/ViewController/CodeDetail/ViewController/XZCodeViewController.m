//
//  XZCodeViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/1/26.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZCodeViewController.h"
#import "XZImageBrowserViewController.h"

@interface XZCodeViewController (){
    
    __weak IBOutlet UITextView *_textView;
    
}

@end

@implementation XZCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.knowledgeTitle;
    
    [self setUpTextView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTextView{

    NSString *path = [[NSBundle mainBundle] pathForResource:self.knowledgeTitle ofType:@"txt"];
    
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    _textView.text = content;
    
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}


@end
