//
//  ZYHVisitViewController.m
//  wbOrwc
//
//  Created by 张云皓 on 16/2/11.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZYHVisitViewController.h"
#import "ZYHModel.h"
#import "ZYHWBTableViewCell.h"
#import "ZYHVideoViewController.h"
#import "ZYHImgViewController.h"
#import "ZyhHomeViewController.h"

@interface ZYHVisitViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *ModelArr;

@property (strong, nonatomic) NSIndexPath *myIndex;

@end

@implementation ZYHVisitViewController

static  NSString *reuseID = @"cell";

-(NSMutableArray *)ModelArr{
    
    if (_ModelArr == nil) {
        
        _ModelArr = [[NSMutableArray alloc]init];
    }
    return _ModelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    self.title = @"Own WeiBo";
    
    [self.tableView registerClass:[ZYHWBTableViewCell class] forCellReuseIdentifier:reuseID];
    
    [self GetWeiBo];
    
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(GetWeiBo)];
    
    self.navigationItem.leftBarButtonItem = barBtnItem;
    
    [self addGes];
    
}

- (void)addGes {
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(luckyLucky)];
    
    [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:recognizer];
}

//双色球哈哈哈
- (void)luckyLucky{

    ZyhHomeViewController *home = [[ZyhHomeViewController alloc]init];
    
    [self.navigationController pushViewController:home animated:YES];
    
}

#pragma mark - 设置表视图
- (void)setUpTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYHWBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (self.ModelArr.count>0) {
        
        
        ZYHModel *model = self.ModelArr[indexPath.row];
        
        cell.wbTextLabel.text = model.text;
        cell.timeLabel.text = model.created_at;
        cell.userNameLabel.text = [model.user objectForKey:@"name"];
        if (indexPath == self.myIndex) {
            cell.wbTextLabel.hidden = NO;
        }else{
            
            cell.wbTextLabel.hidden = YES;
        }
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath == self.myIndex) {
        
        
        return 220;
    }
    
    return 80;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    
//    
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.myIndex == indexPath) {
        self.myIndex = nil;
    }else{
        self.myIndex = indexPath;
    }
    
    [self.tableView reloadData];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"111");
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"MoreandMoreandMore";
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZYHModel *model = self.ModelArr[indexPath.row];
    
    UITableViewRowAction *act1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Player" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"点击了player按钮");
        ZYHVideoViewController *videoVC = [[ZYHVideoViewController alloc]init];
        
        NSRange range = [model.text rangeOfString:@"http://t.cn/"];
        
        NSString *tmp = [model.text substringFromIndex:range.location];
        
        NSString *str = [tmp substringToIndex:19];
        
        videoVC.urlStr = str;
        
        [self presentViewController:videoVC animated:YES completion:^{
            
        }];
    }];
    
    act1.backgroundColor = [UIColor blackColor];
    
    
    UITableViewRowAction *act2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Image" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击了Img按钮");
        
        ZYHImgViewController *imgV = [[ZYHImgViewController alloc]init];
        
        imgV.urlArr = model.pic_urls;
        
        [self presentViewController:imgV animated:YES completion:^{
            
        }];
        
    }];
    act2.backgroundColor = [UIColor orangeColor];
    
    UITableViewRowAction *act3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"别特么点" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
       
        NSLog(@"点击了hehe按钮");
    }];
    act3.backgroundColor = [UIColor purpleColor];
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    [arr addObject:act3];
    
    if (model.pic_urls.count>0) {
        
        [arr addObject:act2];
    }
    
    NSRange range = [model.text rangeOfString:@"http://t.cn/"];
    if (range.location && range.length) {
        
        [arr addObject:act1];
    }
    
    return arr;
}

#pragma mark - 获取微博
- (void)GetWeiBo {
    
    self.myIndex = nil;
    
    NSString *headStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/friends_timeline.json?access_token=%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"] objectForKey:@"access_token"]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:headStr]];
    
    request.HTTPMethod = @"GET";
    
    //    [request setHTTPBody:[pathStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if (dic) {
            //                        NSLog(@"%@",dic);
            self.ModelArr = nil;
            for (NSDictionary *temp in [dic objectForKey:@"statuses"]) {
                ZYHModel *model = [[ZYHModel alloc]initWithDict:temp];
                NSLog(@"%@",temp);
                NSLog(@"-----------------------------------------------");
                [self.ModelArr addObject:model];
            }
            
            [self performSelectorOnMainThread:@selector(ReloadSomeThing) withObject:nil waitUntilDone:NO];
            
        }else{
            
            NSLog(@"获取失败");
        }
    }];
    
    [dataTask resume];
    
    
}

#pragma mark - 刷新表视图
- (void)ReloadSomeThing{
    
    [_tableView reloadData];
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
