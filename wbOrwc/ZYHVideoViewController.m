//
//  ZYHVideoViewController.m
//  wbOrwc
//
//  Created by 张云皓 on 16/2/13.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZYHVideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZYHVideoViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZYHVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    
    self.webView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismisss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSLog(@"%@",request.URL);
    
    return YES;
}
@end
