//
//  GPMainWebController.m
//  GPHandMade
//
//  Created by dandan on 16/6/26.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPMainWebController.h"
#import "GPHotData.h"
#import "GPFariBestData.h"
#import "GPFariTopicData.h"

@interface GPMainWebController ()
- (IBAction)btnClcik:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@end

@implementation GPMainWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// 市集
- (void)setTopicData:(GPFariTopicData *)topicData
{
    _topicData = topicData;
    NSString *str = [NSString stringWithFormat:@"http://www.shougongke.com/index.php?m=Topic&a=topicDetail&topic_id=%@&topic_type=shiji",topicData.topic_id];
    [self loadSlidDataType:str title:@"专题详情"];
}
// 购买
- (void)setBestData:(GPFariBestData *)bestData
{
    _bestData = bestData;
    NSString *str = [NSString stringWithFormat:@"http://market.shougongke.com//index.php?c=index&a=shop&open_iid=%@",bestData.open_iid];
    [self loadSlidDataType:str title:nil];
}

// 热帖
- (void)setHotData:(GPHotData *)hotData
{
    _hotData = hotData;
    if (hotData.mob_h5_url.length) {
        [self loadSlidDataType:hotData.mob_h5_url title:@"专题详情"];
    }
}
- (void)loadSlidDataType:(NSString *)urlString title:(NSString *)title
{
    NSURL *url = [NSURL URLWithString:urlString];
    [self.view addSubview:self.mainWebView];
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:url]];
    self.navigationItem.title = title;
}
- (IBAction)btnClcik:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
