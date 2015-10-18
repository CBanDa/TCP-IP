//
//  ViewController.m
//  网络_服务器通信协议
//
//  Created by 千雪的iMac on 15/10/14.
//  Copyright (c) 2015年 qianxue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSString *str = @"http://localhost:8080/Shopping/servlet/ShoppingService?reqStr={%22requestId%22:100}";
    //获得接口
    NSString *reqStr = @"{\"requestId\":100}";
    NSString *requrl = [NSString stringWithFormat:@"http://localhost:8080/Shopping/servlet/ShoppingService?reqStr=%@",reqStr];
    
    requrl = [requrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSString *asd = [NSString stringWithUTF8String:@"http://localhost:8080/Shopping/servlet/ShoppingService?reqStr={\"requestId\":100}"];
    NSLog(@"string  -- - - %@",requrl);
    //
    NSURL *url = [NSURL URLWithString:requrl];
    NSLog(@"url - - - --   %@",url);
    
       //创建一个请求，最大请求时间为30秒
    NSURLRequest *requrst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
    
    //同步请求返回的参数
    NSURLResponse *response = nil;
    NSError *error = nil;
    //建立连接，下载数据，同步请求    Asynchronous异步
    NSData *data = [NSURLConnection sendSynchronousRequest:requrst returningResponse:&response error:&error];
    
    NSLog(@"00------%@",data);
    
     id isonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
     NSDictionary *iosdic=isonObject;
    
    
    
    NSLog(@"dic ::%@",iosdic);
    
    _musicName = [iosdic objectForKey:@"musiclist"];
    NSLog(@"Name %@",_musicName);
    NSLog(@"歌曲数量：%lu",(unsigned long)_musicName.count);
    
    NSDictionary *iosdic1= [_musicName objectAtIndex:1];
    
    NSString *qwe = [iosdic1 objectForKey:@"musicikey"];
    NSLog(@"%@",qwe);
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _musicName.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSDictionary *iosdic1 = [_musicName objectAtIndex:indexPath.row];
    cell.textLabel.text=  [iosdic1 objectForKey:@"musicname"];
     return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"你选择了播放歌曲： %@",[[_musicName objectAtIndex:indexPath.row]objectForKey:@"musicurl"]);
    //将下载歌曲的链接放在字符串中
    NSString *strurl=[[_musicName objectAtIndex:indexPath.row]objectForKey:@"musicurl"];
//    NSLog(@"%@",strurl);
    NSString *stricon=[[_musicName objectAtIndex:indexPath.row]objectForKey:@"musicicon"];
    
    NSString *strlrc=[[_musicName objectAtIndex:indexPath.row]objectForKey:@"musiclrc"];
    
//    NSString *strsinger=[[_musicName objectAtIndex:indexPath.row]objectForKey:@"muscisinger"];
//    NSLog(@".....%@",strsinger);
    NSString *singer = [[_musicName objectAtIndex:indexPath.row] objectForKey:@"musicsinger"];
    NSLog(@"singer:::%@",singer);
    NSString *singName = [[_musicName objectAtIndex:indexPath.row] objectForKey:@"musicname"];
    
    _musicView = [[MusicViewController alloc]initWithNibName:@"MusicViewController" bundle:nil];
    
    _musicView.url = strurl;
    _musicView.Stricon=stricon;
    _musicView.Strlrc=strlrc;
    _musicView.Strsinger=singer;
    _musicView.Strname=singName;
    
    [self.view addSubview:_musicView.view];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
