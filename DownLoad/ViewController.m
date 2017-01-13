//
//  ViewController.m
//  DownLoad
//
//  Created by Tywin on 2017/1/12.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *_mainTableView;
    NSMutableDictionary *valueData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    valueData = [NSMutableDictionary dictionary];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData:) name:@"refresh" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = (TableViewCell *)([[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:NULL].firstObject);
    }
    cell.mainBtn.tag = indexPath.row + 100;
    cell.proValue = ((NSNumber *)valueData[[NSString stringWithFormat:@"%@",@(indexPath.row+100)]]).floatValue;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)refreshData:(NSNotification *)notifiation
{
    NSDictionary *data = (NSDictionary *)notifiation.object;
    TableViewCell *cell = [_mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:((NSNumber *)data[@"index"]).integerValue-100 inSection:0]];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [valueData setObject:@(((NSNumber *)data[@"value"]).floatValue) forKey:[NSString stringWithFormat:@"%@",((NSNumber *)data[@"index"])]];
        cell.proValue = ((NSNumber *)valueData[[NSString stringWithFormat:@"%@",((NSNumber *)data[@"index"])]]).floatValue;
    });
}
@end
