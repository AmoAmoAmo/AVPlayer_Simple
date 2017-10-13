//
//  HJPlayerView.m
//  AVPlayer_Test_1
//
//  Created by Josie on 2017/7/28.
//  Copyright © 2017年 Josie. All rights reserved.
//

#import "HJPlayerView.h"



@implementation HJPlayerView


+(Class)layerClass
{
    return [AVPlayerLayer class];
}


//将播放器设置给view的layer       重写set方法
-(void)setMyPlayer:(AVPlayer *)myPlayer
{
    AVPlayerLayer *layer = (AVPlayerLayer*)[self layer];
    layer.player = myPlayer;
}

//返回view播放器      重写get方法
-(AVPlayer *)myPlayer
{
    AVPlayerLayer *layer = (AVPlayerLayer*)[self layer];
    return layer.player;
}

@end
