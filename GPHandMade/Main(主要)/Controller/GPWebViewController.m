//
//  GPWebViewController.m
//  GPHandMade
//
//  Created by dandan on 16/5/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPWebViewController.h"
#import "GPslide.h"
#import "GPEventBtn.h"
#import "GPNavigationData.h"
#import "GPTopListData.h"
#import "GPFariHotData.h"

@interface GPWebViewController()<UIWebViewDelegate,UIScrollViewDelegate>

@end
@implementation GPWebViewController

-(void)viewDidLoad{
    [super viewDidLoad];

    [self configNav];
}
#pragma mark - 初始化设置
- (void)configNav
{
    self.loadWebView.scalesPageToFit = YES;
    self.loadWebView.backgroundColor = [UIColor whiteColor];
    self.loadWebView.scrollView.delegate = self;
    self.loadWebView.scrollView.bounces = NO;
}
#pragma mark - 数据处理
- (void)setHotData:(GPFariHotData *)hotData
{
    _hotData = hotData;
    if (hotData.special_id.length) {
        [self loadSlidDataType:hotData.special_id title:@"专题详情"];}
}
// 市集
- (void)setListData:(GPTopListData *)listData
{
    _listData = listData;
    if (listData.mob_h5_url.length) {
        [self loadSlidDataType:listData.mob_h5_url title:@"专题详情"];}
}
// 秒杀
- (void)setNavigatioanData:(GPNavigationData *)navigatioanData
{
    _navigatioanData = navigatioanData;
    if (navigatioanData.mob_h5_url.length) {
        [self loadSlidDataType:navigatioanData.mob_h5_url title:@"专题详情"];    }
}
// 活动
- (void)setHandId:(NSString *)handId
{
    _handId = handId;
    NSString *urlString = [NSString stringWithFormat: @"http://m.shougongke.com/index.php?c=Competition&cid=%@",self.handId];
    [self loadSlidDataType:urlString title:nil];
}
// 轮播图
- (void)setSlide:(GPslide *)slide
{
    _slide = slide;
    if ([slide.itemtype isEqualToString:@"class_special"]) {
         NSString *urlString = [NSString stringWithFormat: @"http://www.shougongke.com/index.php?m=HandClass&a=%@&spec_id=%@",slide.itemtype,slide.hand_id];
        [self loadSlidDataType:urlString title:@"课堂专题"];
    }else if ([slide.itemtype isEqualToString:@"topic_detail_h5"]){
        
        NSString *urlString = slide.hand_id;
        [self loadSlidDataType:urlString title:@"专题详情"];
    }else if ([slide.itemtype isEqualToString:@"event"]){
        NSString *urlString = [NSString stringWithFormat: @"http://m.shougongke.com/index.php?c=Competition&cid=%@",slide.hand_id];
        [self loadSlidDataType:urlString title:nil];

    }
}

- (void)loadSlidDataType:(NSString *)urlString title:(NSString *)title
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.view addSubview:self.loadWebView];
    [self.loadWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.navigationItem.title = title;
}
#pragma mark - UIScrlloView 代理
 static int _lastPosition;    //A variable define in headfile
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 25) {
        _lastPosition = currentPostion;
        [[NSNotificationCenter defaultCenter]postNotificationName:SnowUP object:nil];
    }
    else if (_lastPosition - currentPostion > 25){
        _lastPosition = currentPostion;
        [[NSNotificationCenter defaultCenter]postNotificationName:SnowDown object:nil];
        
    }
}
@end
