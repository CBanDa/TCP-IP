//
//  MusicViewController.m
//  网络_服务器通信协议
//
//  Created by 千雪的iMac on 15/10/14.
//  Copyright (c) 2015年 qianxue. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self performSelector:@selector(resetText)
//               withObject:nil afterDelay:3.0f];
    
    
    
    
    _white=255/255.0;
    //图片下载播放
    NSURL *urlicon = [NSURL URLWithString:_Stricon];
    NSData *data=[NSData dataWithContentsOfURL:urlicon];
    _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0,200,200)];
    _imageview.image=[UIImage imageWithData:data];
//    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,150)];
//    image2.image=_imageview.image;
    
    _imageview.layer.cornerRadius=95;
//    [_imageview.layer setCornerRadius:CGRectGetHeight([_imageview bounds])/3];
    _imageview.layer.masksToBounds=YES;
    [_imageview.layer setBorderColor:(__bridge CGColorRef)([UIColor blueColor])];
    
//    _imageview.contentMode=UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:_imageview];
    
    //显示下载的歌词
    NSURL *urlLrc = [NSURL URLWithString:_Strlrc];
     NSData *datalrc=[NSData dataWithContentsOfURL:urlLrc];
      NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *str1=[[NSString alloc] initWithData:datalrc encoding:enc];
    
    _lable=[[UITextView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 350)];
    _lable.backgroundColor=[UIColor whiteColor];
    _lable.text=str1;
    [self.view addSubview:_lable];
     //lal.numberOfLines = 0;lable中多行显示
    
//显示歌手的名字

    UILabel *lable1=[[UILabel alloc]initWithFrame:CGRectMake(30, 200, 60, 50)];
    lable1.backgroundColor=[UIColor colorWithWhite:_white alpha:-1.0];
    lable1.textColor=[UIColor greenColor];
    lable1.text=_Strsinger;
    [self.view addSubview:lable1];
    
    //获取歌曲的名字
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(300, 200, 70, 40)];
    lable2.backgroundColor=[UIColor colorWithWhite:_white alpha:-1.0];
    lable2.textColor=[UIColor purpleColor];
    lable2.text=_Strname;
    [self.view addSubview:lable2];
    //音乐下载播放
    NSURL *url = [NSURL URLWithString:_url];
    _moviePlayer = [ [ MPMoviePlayerController alloc]initWithContentURL:url];//远程
    //NSString *path = [[NSBundle mainBundle]pathForResource:@"动画（已转换）.mov" ofType:Nil];
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    _moviePlayer.view.frame = CGRectMake(0, 260, self.view.frame.size.width, 50);
    _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_moviePlayer.view];
    //AVAudioPlayer，，，，，NSTimeInterval
    // Do any additional setup after loading the view from its nib.
}
-(void)scrollViewWillBeginDragging:(UIScrollView
                                    *)scrollView {
    [_timer invalidate];
    _timer= nil;
    NSLog(@"scrollViewWillBeginDragging");
    [self performSelector:@selector(resetText) withObject:nil afterDelay:3.0f];
}

-(void)resetText
{
    [_timer invalidate];
    _timer = nil;
    _timer= [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(onTick:)userInfo:nil repeats:YES];
}
-(void)onTick:(NSTimer*)theTimer
{
    CGPoint pt = [_lable contentOffset];
    CGFloat  n = pt.y + 1;
    [_lable setContentOffset:CGPointMake(pt.x, n)];
    if (n>(_lable.contentSize.height-_lable.bounds.size.height))
    {
        [theTimer invalidate];
        theTimer= nil;
        [_timer invalidate];
        _timer = nil;
    }
}

-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    _imageview.transform = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}
-(void)endAnimation
{
    _angle += 1;
    [self startAnimation];
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

- (IBAction)playMusic:(id)sender
{
    [self startAnimation];
    [self.moviePlayer play];
    [self performSelector:@selector(resetText)
                   withObject:nil afterDelay:3.0f];
  
    
}
- (IBAction)return:(UIButton *)sender
{
    [self.view removeFromSuperview];
}
@end
