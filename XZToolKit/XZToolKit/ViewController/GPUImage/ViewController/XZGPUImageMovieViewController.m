//
//  XZGPUImageMovieViewController.m
//  XZToolKit
//
//  Created by 徐章 on 16/3/15.
//  Copyright © 2016年 xuzhang. All rights reserved.
//

#import "XZGPUImageMovieViewController.h"
#import <GPUImage/GPUImage.h>
#import <Masonry/Masonry.h>
@interface XZGPUImageMovieViewController ()
@property (nonatomic, strong) GPUImageMovie *movieFile;
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;

@end

@implementation XZGPUImageMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"mp4"];
    
    self.movieFile = [[GPUImageMovie alloc] initWithURL:url];
    
    self.filter = [[GPUImagePixellateFilter alloc] init];
    [self.movieFile addTarget:self.filter];
    
    GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:filterView];
    [self.filter addTarget:filterView];
    
    [self.movieFile startProcessing];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
