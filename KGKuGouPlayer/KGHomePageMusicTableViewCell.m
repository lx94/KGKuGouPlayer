//
//  KGHomePageMusicTableViewCell.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 slx. All rights reserved.
//

#import "KGHomePageMusicTableViewCell.h"

@implementation KGHomePageMusicTableViewCell

+(instancetype)homePageMusicTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"homeListCell";
    
    KGHomePageMusicTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (cell ==nil) {
        cell = [[KGHomePageMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
- (void)setStatus:(KGMusicCellStatus *)status{
    if (status.selected) {
        self.textLabel.textColor = [UIColor orangeColor];
    }else{
        self.textLabel.textColor = [UIColor whiteColor];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
