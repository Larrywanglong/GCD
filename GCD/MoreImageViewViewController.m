//
//  MoreImageViewViewController.m
//  GCD
//
//  Created by 王龙 on 16/3/3.
//  Copyright © 2016年 Larry（Lawrence）. All rights reserved.
//

#import "MoreImageViewViewController.h"

#define kurl @"http://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/s/38/s38ga/rdgd/s38ga-rdgd-sel-201601?wid=848&hei=848&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1454777389943"

@interface MoreImageViewViewController ()
{
    int imageTag;
    UIImageView *myImageView;
    dispatch_queue_t concurentQueue;
    
    
    NSOperationQueue *operationQueues;
}
@end

@implementation MoreImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageTag = 100;
    self.view.backgroundColor = [UIColor greenColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self controlBtn];
    /*
     1、创建多个视图
     2、找到并行队列
     3、给这个并行队列指定多个任务
     4、在子线程加载网络资源
     5、回到主线程
     6、更新UI
     */
    
//    1、创建多个视图
    for (int i=0; i<3; i++) {
        for (int j=0; j<2; j++) {
            myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+j*200, 40+i*200, 190, 190)];
            myImageView.backgroundColor = [UIColor orangeColor];
            myImageView.tag = imageTag++;
            [self.view addSubview:myImageView];
        }
    }
    
//    2、找到并行队列
//    dispatch_get_global_queue(0, 0) 获取到系统的全局并行队列
//    第一个参数：是优先级
//    第二个参数：保留参数，没用
//     concurentQueue = dispatch_get_global_queue(0, 0);
     concurentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_SERIAL);
//    3、指定任务
    for (int index = 0; index<6; index++) {
        dispatch_async(concurentQueue, ^{
            [NSThread sleepForTimeInterval:1];
//           4、加载网络资源
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kurl]];
            UIImage *image = [UIImage  imageWithData:data];
            
//            5、回到主线程
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_sync(mainQueue, ^{
//               6、刷新UI
                for (int i=0; i<6; i++) {
                    
                    UIImageView *iamgeview = [self.view viewWithTag:100+index];
                    iamgeview.image = image;
                }
                
            });
            
            
        });
    }
    
    

}


- (void)controlBtn{
    
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"暂停",@"开启",]];
    
    segment.frame = CGRectMake(50, 620, 300, 50);
    
    segment.apportionsSegmentWidthsByContent = YES;
    
    [self.view addSubview:segment];
    
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
}

- (void)clickSegment:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case 0:{
//            暂停队列
            dispatch_suspend(concurentQueue);
        }break;
            
        case 1:{
//            恢复队列
            dispatch_resume(concurentQueue);
            
        }break;
            
    }
    
    
    
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
