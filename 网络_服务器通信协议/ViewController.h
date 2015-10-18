//
//  ViewController.h
//  网络_服务器通信协议
//
//  Created by 千雪的iMac on 15/10/14.
//  Copyright (c) 2015年 qianxue. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MusicViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property (strong,nonatomic) MusicViewController *musicView;
@property (strong,nonatomic) NSArray *musicName;
@end

