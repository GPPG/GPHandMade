//
//  GPWebViewController.h
//  GPHandMade
//
//  Created by dandan on 16/5/21.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPslide,GPHotData;
@interface GPWebViewController : UIViewController
@property (nonatomic, strong) GPslide *slide;
@property (weak, nonatomic) IBOutlet UIWebView *loadWebView;
@end
