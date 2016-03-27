//
//  OneImageViewController.m
//  GCD
//
//  Created by 王龙 on 16/3/3.
//  Copyright © 2016年 Larry（Lawrence）. All rights reserved.
//

#import "OneImageViewController.h"

#define kurl @"http://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/s/38/s38ga/rdgd/s38ga-rdgd-sel-201601?wid=848&hei=848&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1454777389943"
@interface OneImageViewController ()
{
    
        UIImageView *myImageView;
        UIImage *iamges;
    

}
@end

@implementation OneImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    /*
     1、创建视图
     2、创建一个串行队列
     3、用异步方式执行串行队列中的任务
     4、加载网络资源
     5、回到主线程
     6、更新UI
     
     */
//    1、创建视图
    myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    myImageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:myImageView];
    
//    2、找到串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    
//    3、用异步方式执行任务
    dispatch_async(serialQueue, ^{
//       4、加载网络资源
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kurl]];
        UIImage *image = [UIImage imageWithData:data];
        
//        5、回到主线程
//        找到主队列：dispatch_get_main_queue()
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_sync(mainQueue, ^{
//           6、更新UI
            myImageView.image = image;
            
        });
        
    });
    
    

    
}

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
