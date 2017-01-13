//
//  TableViewCell.m
//  DownLoad
//
//  Created by Tywin on 2017/1/13.
//  Copyright © 2017年 Tywin. All rights reserved.
//

#import "TableViewCell.h"
#import <AFNetworking/AFNetworking.h>
@implementation TableViewCell
{
    __weak IBOutlet UIProgressView *_progress;
    __weak IBOutlet UILabel *_label;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setProValue:(float)value
{
    _proValue = value;
    _label.text = [NSString stringWithFormat:@"%.0f %",value*100];
    [_progress setProgress:value animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startDownLoad:(UIButton *)sender
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://dldir1.qq.com/WechatWebDev/012130400/wechat_web_devtools_0.12.130400.dmg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"接收中------------>%@",downloadProgress);
        NSDictionary *dataDic = @{@"index":@(_mainBtn.tag),@"value":@(downloadProgress.fractionCompleted)};
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:dataDic];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"正常------------>%@",response);
        }else{
            NSLog(@"异常------------>%@",error);
        }
    }];
    [downloadTask resume];
}

@end
