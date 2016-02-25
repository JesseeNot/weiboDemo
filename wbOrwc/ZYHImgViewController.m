//
//  ZYHImgViewController.m
//  wbOrwc
//
//  Created by 张云皓 on 16/2/13.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZYHImgViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ZYHImgViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *urlStrArr;

@property (strong, nonatomic) NSMutableArray *dataArr;

@end

@implementation ZYHImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGes];
    
    [self GetImgHAHA];
    

}

- (void)GetImgHAHA{

    self.urlStrArr = [NSMutableArray array];
    
    for (NSDictionary *dic in self.urlArr) {
        
        NSString *pathStr = [dic objectForKey:@"thumbnail_pic"];
        
        NSRange range = [pathStr rangeOfString:@"thumbnail"];
        
        NSString *finalStr = [pathStr stringByReplacingCharactersInRange:range withString:@"large"];
        
        [self.urlStrArr addObject:finalStr];
    }
    
    NSLog(@"%@",self.urlStrArr);
    
    [self performSelectorInBackground:@selector(GetAllData) withObject:nil];
    
}

- (void)GetAllData {

    self.dataArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<self.urlStrArr.count; i++) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlStrArr[i]]];
        [self.dataArr addObject:data];
    }


    [self performSelectorOnMainThread:@selector(printImage) withObject:nil waitUntilDone:NO];
}

- (void)printImage{
    
    NSLog(@"dataArr data = %lu",(unsigned long)self.dataArr.count);
    for (int i = 0; i<self.dataArr.count; i++) {
        
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, self.scrollView.frame.size.height)];
        
        imageV.image = [UIImage imageWithData:self.dataArr[i]];
        
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.scrollView addSubview:imageV];
    }
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.urlStrArr.count, 0);
    
    
}


- (void)addGes {

    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(Dismiss)];
    
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Dismiss {

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
