//
//  TableViewCell.h
//  DownLoad
//
//  Created by Tywin on 2017/1/13.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;

@property (nonatomic, assign) float proValue;

@end
