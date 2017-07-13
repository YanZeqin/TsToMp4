//
//  ViewController.m
//  TsToMp4
//
//  Created by 泽秦  严 on 2017/7/13.
//  Copyright © 2017年 泽秦  严. All rights reserved.
//

#import "ViewController.h"
#import "KMMedia.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)tsToMp4:(id)sender {
    NSURL *tsFileURL = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"20170712160939086" ofType:@"ts"]];
    /*
     支持互相转的格式
     KMMediaFormatUnknown,
     KMMediaFormatAAC,
     KMMediaFormatMP3,
     KMMediaFormatH264,
     KMMediaFormatMP4,
     KMMediaFormatTS
     */
    KMMediaAsset *tsAsset = [KMMediaAsset assetWithURL:tsFileURL withFormat:KMMediaFormatTS];
    NSString *mp4FileName = [NSString stringWithFormat:@"%@/Result.mp4",[self savePath]];
    NSURL *mp4FileURL = [NSURL URLWithString:mp4FileName];
    KMMediaAsset *mp4Asset = [KMMediaAsset assetWithURL:mp4FileURL withFormat:KMMediaFormatMP4];
    KMMediaAssetExportSession *tsToMP4ExportSession = [[KMMediaAssetExportSession alloc] initWithInputAssets:@[tsAsset]];
    tsToMP4ExportSession.outputAssets = @[mp4Asset];
    [tsToMP4ExportSession exportAsynchronouslyWithCompletionHandler:^{
        /*
         KMMediaAssetExportSessionStatusWaiting 导出会话等待执行操作
         KMMediaAssetExportSessionStatusExporting 导出会话操作执行
         KMMediaAssetExportSessionStatusCompleted 导出会话操作成功完成
         KMMediaAssetExportSessionStatusFailed 导出会话操作失败
         KMMediaAssetExportSessionStatusCanceled 取消出口会话操作
         */
        if (tsToMP4ExportSession.status == KMMediaAssetExportSessionStatusCompleted)
        {
            NSLog(@"1====%@",mp4FileName);
            self.infoLabel.text = [NSString stringWithFormat:@"Export of %@ completed",mp4FileName];
        }
        else
        {
            NSLog(@"2====%@",mp4FileName);
            self.infoLabel.text = [NSString stringWithFormat:@"Export of %@ failed",mp4FileName];
        }
    }];

    
}

-(NSString *)savePath{
    
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    NSString *strMediaCenterPath = [documentDirectory stringByAppendingPathComponent:@"video"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:strMediaCenterPath])
    {
        [[NSFileManager defaultManager]  createDirectoryAtPath:strMediaCenterPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return strMediaCenterPath;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
