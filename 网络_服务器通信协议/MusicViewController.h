//
//  MusicViewController.h
//  网络_服务器通信协议
//
//  Created by 千雪的iMac on 15/10/14.
//  Copyright (c) 2015年 qianxue. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>
@interface MusicViewController : UIViewController<AVAudioPlayerDelegate,UIScrollViewDelegate>

@property (strong,nonatomic)AVAudioPlayer *audioPlayer;

@property(strong,nonatomic)CABasicAnimation* rotationAnimation;
- (IBAction)playMusic:(id)sender;
@property CGFloat  angle;
//@property CGFloat  imageviewAngle;
@property (strong,nonatomic)UITextView *lable;
@property (strong,nonatomic)UIImageView *imageview;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *Stricon;
@property (nonatomic,strong) NSString *Strlrc;
@property (nonatomic,strong) NSString *Strsinger;
@property (nonatomic,strong) NSString *Strname;
@property (strong,nonatomic)MPMoviePlayerController *moviePlayer;
- (IBAction)return:(UIButton *)sender;

@property(strong,nonatomic)NSTimer *timer;
@property CGFloat white;
@property CGFloat alphl;
@end
