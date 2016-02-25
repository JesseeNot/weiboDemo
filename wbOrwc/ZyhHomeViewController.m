//
//  ZyhHomeViewController.m
//  Lucky
//
//  Created by 张云皓 on 16/1/19.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZyhHomeViewController.h"

@interface ZyhHomeViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

/***现实选定数字的label*/
@property (weak, nonatomic) IBOutlet UILabel *showNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *saveNumLabel;

/***前五个数*/
@property (strong, nonatomic) NSMutableArray *fontNum;
/***后两个数*/
@property (strong, nonatomic) NSMutableArray *endNum;
/***选中数的数组*/
@property (strong, nonatomic) NSMutableArray *selectedArr;
@end

@implementation ZyhHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"LUCKY";
    
    self.selectedArr = [[NSMutableArray alloc]init];
    for (int i = 0; i<7; i++) {
        [_selectedArr addObject:@"0"];
    }
    
    //判断偏好里面有没有数字
    NSString *s = [[NSUserDefaults standardUserDefaults]objectForKey:@"NUM"];
    
    self.saveNumLabel.text = s;
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 7;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (component>4) {
        return 12;
    }
    return 35;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (component>4) {
        return self.endNum[row];
    }
    
    return self.fontNum[row];
}

- (IBAction)tochupinside {

    [self changeNum];
    
    NSMutableString *num = [[NSMutableString alloc]init];
    
    for (int i = 0; i<_selectedArr.count; i++) {
        [num appendString:[NSString stringWithFormat:@"%@  ",_selectedArr[i]]];
    }
    
    self.showNumLabel.text = num;
    
    BOOL isHaveTwo = false;
    BOOL isAlsoBehind = false;
    NSLog(@"%@",_selectedArr);
    for (int n = 0; n<4; n++) {
        for (int m = n+1; m<=4; m++) {
            if (_selectedArr[n] == _selectedArr[m]) {
                isHaveTwo = true;
            }
        }
    }
    if (_selectedArr[5] == _selectedArr[6]) {
        isAlsoBehind = true;
    }
    
    if (isHaveTwo || isAlsoBehind) {
        [self tochupinside];
        NSLog(@"重复啦啦啦啦啦啦啦");
    }
}

#pragma mark - 随机数字
-(void)changeNum{

    for (int i = 0; i<5; i++) {
        int k = arc4random()%35;
        [_pickerView selectRow:k inComponent:i animated:YES];
        _selectedArr[i] = _fontNum[k];
    }
    
    for (int j = 5; j<7; j++) {
        int k = arc4random()%12;
        [_pickerView selectRow:k inComponent:j animated:YES];
        _selectedArr[j] = _endNum[k];
    }
    
}

#pragma mark - 懒加载数组
-(NSMutableArray *)fontNum{
    
    if (_fontNum == nil) {
        _fontNum = [[NSMutableArray alloc]init];
        for (int i = 1; i<=35; i++) {
            [_fontNum addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _fontNum;
}

-(NSMutableArray *)endNum{
    
    if (_endNum == nil) {
        _endNum = [[NSMutableArray alloc]init];
        for (int i = 1; i<=12; i++) {
            [_endNum addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _endNum;
}
- (IBAction)lockNum {
    
    self.saveNumLabel.text = self.showNumLabel.text;
    [[NSUserDefaults standardUserDefaults]setObject:self.saveNumLabel.text forKey:@"NUM"];
}
-(void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}
@end
