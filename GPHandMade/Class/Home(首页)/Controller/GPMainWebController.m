//
//  GPMainWebController.m
//  GPHandMade
//
//  Created by dandan on 16/6/26.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPMainWebController.h"
#import "GPHotData.h"

@interface GPMainWebController ()
- (IBAction)btnClcik:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@end

@implementation GPMainWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
