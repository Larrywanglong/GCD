//
//  GCDLockViewController.m
//  GCD
//
//  Created by 王龙 on 16/3/3.
//  Copyright © 2016年 Larry（Lawrence）. All rights reserved.
//

#import "GCDLockViewController.h"

@interface GCDLockViewController ()
{
    NSLock *lock;
}
@end

@implementation GCDLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    实例化一个线程锁
    lock = [NSLock new];
#pragma mark 线程锁
    __block int tickNum = 10;
    dispatch_queue_t concurrent = dispatch_get_global_queue(0, 0);
    for (int index = 0; index<15; index++) {
        dispatch_async(concurrent, ^{
//            上锁
//            [lock lock];
//            if (tickNum>0) {
//                
//                tickNum--;
//                NSLog(@"还剩%d张票",tickNum);
//            }
////            解锁
//            [lock unlock];
            
//            参数一般为self 与self相关的变量多个线程同时只访问一次
            @synchronized(self) {
                if (tickNum>0) {
                    
                    tickNum--;
                    NSLog(@"还剩%d张票",tickNum);
                }

            }
            
        });
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
