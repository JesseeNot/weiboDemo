//
//  ZYHLoginViewController.m
//  wbOrwc
//
//  Created by 张云皓 on 16/2/9.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZYHLoginViewController.h"
#import "ZYHVisitViewController.h"

@interface ZYHLoginViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ZYHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"userInfo"]) {
        
        [_webView removeFromSuperview];
    }
    [self userLogin];
}

- (void)userLogin{
    
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2241635598&redirect_uri=http://qq.com&response_type=code"]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;

    if ([urlStr hasPrefix:@"http://qq.com/?code="]) {
        
        NSRange range = [urlStr rangeOfString:@"?code="];
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        NSLog(@"code = %@",code);
        
        [webView removeFromSuperview];
        
        [self getAccess_tokenWithCode:code];
        
        return  false;
    }
    
    return YES;
}

- (void)getAccess_tokenWithCode:(NSString *)code{

    NSString *headStr = @"https://api.weibo.com/oauth2/access_token";
    
    NSString *temp = @"client_id=2241635598&client_secret=ce103a6529d8dd67b024db5f3f794250&grant_type=authorization_code&redirect_uri=http://qq.com&code=";
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",temp,code];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:headStr]];
    
    request.HTTPMethod = @"POST";
    
    [request setHTTPBody:[pathStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (dic) {
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userInfo"];
            
            ZYHVisitViewController *Visit = [[ZYHVisitViewController alloc]init];
            
            [self.navigationController pushViewController:Visit animated:YES];
            [Visit GetWeiBo];
            
        }else{
        
            NSLog(@"登陆失败");
        }
    }];
    
    [dataTask resume];
}



/***
 access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
