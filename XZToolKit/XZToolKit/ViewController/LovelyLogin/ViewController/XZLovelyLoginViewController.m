//
//  XZLovelyLoginViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/2/5.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZLovelyLoginViewController.h"
#import "XZRotateButton.h"
#import "UIView+Frame.h"
#import "UIColor+HexString.h"

@interface XZLovelyLoginViewController ()<UITextFieldDelegate>{
    
    UIImageView *_leftLegImg;
    UIImageView *_rightLegImg;
    
    UIImageView *_leftFistImg;
    UIImageView *_rightFistImg;
    
    UITextField *_userTf;
    UITextField *_passwordTf;
    
    UIScrollView *_scrollView;
    
    XZRotateButton *_loginBtn;
    
    //是否遮住眼睛
    BOOL _isCloseEyes;
}

@end

@implementation XZLovelyLoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isCloseEyes = NO;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [_scrollView addGestureRecognizer:tap];
    
    [self addHeadAndLegs];
    [self addLoginView];
    [self addFist];
    [self addLoginButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private_Methods
/**
 *  添加头部和Legs图片
 */
- (void)addHeadAndLegs{
    
    //头部图片
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 - 100, 50, 200, 100)];
    headImg.image = [UIImage imageNamed:@"animalHead"];
    headImg.layer.masksToBounds = YES;
    headImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:headImg];
    
    //左leg
    _leftLegImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 85, 40, 65)];
    _leftLegImg.image = [UIImage imageNamed:@"leftArm"];
    [headImg addSubview:_leftLegImg];
    
    //右leg
    _rightLegImg = [[UIImageView alloc] initWithFrame:CGRectMake(160, 85, 40, 65)];
    _rightLegImg.image = [UIImage imageNamed:@"rightArm"];
    [headImg addSubview:_rightLegImg];
}

/**
 *  添加登录UI
 */
- (void)addLoginView{
    
    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(20, 140, UISCREEN_WIDTH - 40, 160)];
    loginView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginView.layer.borderWidth = 1.0f;
    loginView.layer.cornerRadius = 5.0f;
    
    loginView.backgroundColor = [UIColor whiteColor];
    
    [self addAccountAndPassword:loginView];
    
    [_scrollView addSubview:loginView];
}

/**
 *  添加拳头
 */
- (void)addFist{
    
    _leftFistImg = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 - 100, 120, 40, 40)];
    _leftFistImg.image = [UIImage imageNamed:@"fist"];
    
    [_scrollView addSubview:_leftFistImg];
    
    _rightFistImg = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 + 100 - 40, 120, 40, 40)];
    _rightFistImg.image = [UIImage imageNamed:@"fist"];
    
    [_scrollView addSubview:_rightFistImg];
    
}

/**
 *  添加帐号密码UI
 */
- (void)addAccountAndPassword:(UIView *)view{
    
    //帐号
    _userTf = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, view.width - 60, 44)];
    _userTf.delegate = self;
    _userTf.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _userTf.layer.borderWidth = 0.5f;
    _userTf.layer.cornerRadius = 5.0f;
    _userTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _userTf.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    userImg.image = [UIImage imageNamed:@"loginUser"];
    
    [_userTf.leftView addSubview:userImg];
    [view addSubview:_userTf];
    
    //密码
    _passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, view.width - 60, 44)];
    _passwordTf.delegate = self;
    _passwordTf.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _passwordTf.layer.borderWidth = 0.5f;
    _passwordTf.layer.cornerRadius = 5.0f;
    _passwordTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    _passwordTf.leftViewMode = UITextFieldViewModeAlways;
    _passwordTf.secureTextEntry = YES;
    UIImageView *passwoedImg = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
    passwoedImg.image = [UIImage imageNamed:@"loginPassword"];
    
    [_passwordTf.leftView addSubview:passwoedImg];
    [view addSubview:_passwordTf];
    
}

/**
 *  添加登录按钮
 */
- (void)addLoginButton{
    
    _loginBtn = [[XZRotateButton alloc] initWithFrame:CGRectMake(20, 350, UISCREEN_WIDTH - 40, 50)];
    
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#72a4d3"];
    _loginBtn.layer.cornerRadius = 5.0f;
    
    [_loginBtn addTarget:self action:@selector(loginBtn_Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:_loginBtn];
}

/**
 *  闭眼
 */
- (void)closeEyes{
    
    [UIView animateWithDuration:0.5f animations:^{
        
        _leftLegImg.origin = CGPointMake(_leftLegImg.x + 60, _leftLegImg.y - 30);
        _leftFistImg.frame = CGRectMake(_leftFistImg.x + 60, _leftFistImg.y, 0, 0);
        
        _rightLegImg.origin = CGPointMake(_rightLegImg.x -  53, _rightLegImg.y - 30);
        _rightFistImg.frame = CGRectMake(_rightFistImg.x - 53, _rightFistImg.y, 0, 0);
        
    } completion:^(BOOL finished) {
        
        _isCloseEyes = YES;
    }];
}

/**
 *  开眼
 */
- (void)openEyes{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _leftLegImg.origin = CGPointMake(_leftLegImg.x - 60, _leftLegImg.y + 30);
        _leftFistImg.frame = CGRectMake(_leftFistImg.x - 60, _leftFistImg.y, 40, 40);
        
        _rightLegImg.origin = CGPointMake(_rightLegImg.x +  53, _rightLegImg.y + 30);
        _rightFistImg.frame = CGRectMake(_rightFistImg.x + 53, _rightFistImg.y, 40, 40);
        
    } completion:^(BOOL finished) {
        
        _isCloseEyes = NO;
    }];
}

/**
 *  隐藏键盘
 */
- (void)hideKeyBoard{
    
    [_userTf resignFirstResponder];
    [_passwordTf resignFirstResponder];
}

/**
 *  登录
 */
- (void)login{
    
    [_loginBtn stopRotating];
    
    _loginBtn.enabled = YES;
    
}

#pragma makr - UIButton_Action
- (void)loginBtn_Pressed:(XZRotateButton*)sender{
    
    [self hideKeyBoard];
    
    _loginBtn.enabled = NO;
    
    [_loginBtn startRotating];
    
    [self performSelector:@selector(login) withObject:nil afterDelay:3.0f];
    
}

#pragma mark - UITextField_Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (_isCloseEyes) {
        
        [self openEyes];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == _userTf) {
        
        if (_isCloseEyes) {
            
            [self openEyes];
        }
        
    }else if (textField == _passwordTf){
        
        if (!_isCloseEyes) {
            
            [self closeEyes];
        }
    }
}
@end
