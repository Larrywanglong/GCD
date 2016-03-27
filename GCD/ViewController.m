//
//  ViewController.m
//  GCD
//
//  Created by 王龙 on 16/3/3.
//  Copyright © 2016年 Larry（Lawrence）. All rights reserved.
//

/*
 
 1、什么是GCD
 
 全称是Grand Central Dispath 纯C语言编写，提供非常多且强大的函数，是目前推荐的多线程开发方法，NSOperation便是基于GCD的封装
 2、GCD的优势
   1.为多核的并行运算提出了解决方案
  2.GCD会自动利用更多的CPU内核，比如 双核，四核
  3、GCD自动管理线程的生命周期（创建线程，调度任务，销毁线程）
  4.程序员只需告诉GCD想要执行什么任务，不需要编写任何线程管理代码
 3、GCD中的两个核心概念
   1.任务：执行什么操作
   2.队列：用来存放任务
 4、队列可分为两大类型
    （1）串行队列(Serial Dispatch Queue)： 只能有一个线程，加入到队列中的操作按添加顺序依次执行，一个任务执行完毕后 才能执行下一个任务
    （2）并发队列（Concurrent Dispatch Queue）： 可以有多个线程，操作进来之后他会将这些线程安排在可用的处理器上，同时保证先进来的任务优先处理
  (3)还有一个特殊的队列就是主队列，主队列中永远只有一个线程-主线程，用来执行主线程的操作任务
 5、采用GCD做多线程，可抽象为两步
  1、找到队列
  2、在队列中用同步或者异步的方式执行任务
 6.执行队列中任务的两种方式
   1、同步：只能在当前线程执行任务，不具备开启新线程的能力
   2、异步：可以在新的线程中执行任务，具备开启新线程的能力
 7、GCD创建的线程任务有四种方式
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
#pragma mark ******串行同步
//   1、找到队列
    /**
     *  找到队列
     *
     *  @param "serailQueue"         该队列的名字
     *  @param DISPATCH_QUEUE_SERIAL 指定队列类型
     *
     *  @return
     */
    dispatch_queue_t serialQueue = dispatch_queue_create("serailQueue", DISPATCH_QUEUE_SERIAL);
    
    /*
     *2、给队列指定任务 asyn异步  syn是同步
     * 第一个参数：任务在哪个队列中执行
     * 第二个参数：想要执行的操作
     */
    dispatch_sync(serialQueue, ^{
        NSLog(@"....%@",[NSThread currentThread]);
    });
    
    
#pragma mark *****  串行异步
//    1、找到队列
    dispatch_queue_t srearialqueue1 = dispatch_queue_create("searialQueue1", DISPATCH_QUEUE_SERIAL);
    
//    2、给队列指定异步任务
    dispatch_async(srearialqueue1, ^{
//        NSLog(@"%@",[NSThread currentThread]);
    });
    
#pragma mark 并行同步
//    1、找到一个队列
    dispatch_queue_t conturrentQueue = dispatch_queue_create("conturrentQueue1", DISPATCH_QUEUE_CONCURRENT);
//    2、给队列指定任务
    dispatch_sync(conturrentQueue, ^{
//        NSLog(@"%@",[NSThread currentThread]);
    });
 
    
#pragma mark 并行异步
    dispatch_queue_t conturrentQueue2 = dispatch_queue_create("conturrentQueue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(conturrentQueue2, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
