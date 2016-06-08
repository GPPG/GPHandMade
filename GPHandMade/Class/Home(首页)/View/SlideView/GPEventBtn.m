//
//  GPEventBtn.m
//  GPHandMade
//
//  Created by dandan on 16/6/8.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEventBtn.h"

@implementation GPEventBtn


- (void)showEventButCenter:(CGPoint)Centerpoint
{
    self.center = Centerpoint;
}
- (void)shoeAnamEventBtnCenter:(CGPoint)Anmpoint
{
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:0 animations:^{
        self.center = Anmpoint;
    } completion:nil];
}
@end
