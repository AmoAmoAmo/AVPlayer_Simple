//
//  ViewController.m
//  AVPlayer_Test_1
//
//  Created by Josie on 2017/7/28.
//  Copyright © 2017年 Josie. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HJPlayerView.h"

@interface ViewController ()
//播放item         播放内容对象
@property (nonatomic, strong) AVPlayerItem  *playerItem;

@property (nonatomic, strong) AVPlayer      *player;

@property (nonatomic ,readwrite) AVPlayerLayer *playerLayer;

@property (nonatomic, strong) HJPlayerView  *myPlayerView;

@property (nonatomic, strong) NSTimer       *timer;

@property (nonatomic, assign) BOOL          isPlay;   // 或者: 播放状态 = 按钮select状态

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.isPlay = NO;
    [self createPlayer];
}


//初始化播放器
- (void)createPlayer
{
    // 此处自行修改成相应的文件名
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake it off" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //创建播放item
    self.playerItem = [[AVPlayerItem alloc] initWithURL:url];
    
    //创建播放器
    self.player = [[AVPlayer alloc]initWithPlayerItem:self.playerItem];
    
    //需要使用到自定义的播放器
    self.myPlayerView = [[HJPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 280)];
    self.myPlayerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.myPlayerView];
    //把播放器设置给_playerView
    self.myPlayerView.myPlayer = self.player;
    
    //调整位置
    [self.view sendSubviewToBack:self.myPlayerView];
    
//    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
//    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    [self.myPlayerView.layer addSublayer:_playerLayer];
    
    
    
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
    // 定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(renewProgress) userInfo:nil repeats:YES];
    
    
}

//显示播放进度    // _timer 更新进度条,当前时间
-(void)renewProgress
{
    //取得当前视频时间
    long long second = self.playerItem.currentTime.value / self.playerItem.currentTime.timescale;
    //显示在label上
    _label.text = [NSString stringWithFormat:@"%02ld:%02ld",(NSInteger)second/60,(NSInteger)second%60];
    
     //让slider走
    self.slider.value = second;
}


- (IBAction)clickButton:(UIButton *)sender {
    
    if (self.isPlay)
    {
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [_player pause];
    }
    else
    {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [_player play];
        
        //开始播放视频之后,获取视频总长
        long long second = self.playerItem.duration.value/self.playerItem.duration.timescale;
        
        _totalLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(NSInteger)second/60,(NSInteger)second%60];
        
        //给slider设置总长度
        _slider.maximumValue = second;
    }
    self.isPlay = !self.isPlay;
}




-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


















