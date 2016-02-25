//
//  ZYHWBTableViewCell.m
//  wbOrwc
//
//  Created by 张云皓 on 16/2/12.
//  Copyright © 2016年 Jessee. All rights reserved.
//

#import "ZYHWBTableViewCell.h"

@implementation ZYHWBTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ZYHWBTableViewCell" owner:self options:nil]lastObject];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
