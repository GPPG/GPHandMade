//
//  GPLoginController.m
//  GPHandMade
//
//  Created by dandan on 16/6/7.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPLoginController.h"
#import "GPEventBtn.h"

@interface GPLoginController ()

@property (nonatomic, weak) GPEventBtn *eventBtn;
@end

@implementation GPLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addEventBar];
}

- (void)addEventBar
{
    GPEventBtn *eventBtn = [[GPEventBtn alloc]init];
    [eventBtn setImage:[UIImage imageNamed:@"activitiesWillStart"] forState:UIControlStateNormal];
    [eventBtn sizeToFit];
    [eventBtn showEventButCenter:CGPointMake(SCREEN_WIDTH * 0.5 , SCREEN_HEIGHT - 2 * eventBtn.width)];
    eventBtn.transform = CGAffineTransformMakeScale(2, 2);
    [eventBtn addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eventBtn];
    [self.view bringSubviewToFront:eventBtn];
    self.eventBtn = eventBtn;
}
- (void)dismissVc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}
@end
