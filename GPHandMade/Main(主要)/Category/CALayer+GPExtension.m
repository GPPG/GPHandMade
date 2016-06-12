//
//  CALayer+GPExtension.m
//  GPHandMade
//
//  Created by dandan on 16/5/25.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "CALayer+GPExtension.h"

@interface CALayer()
@property(nonatomic, assign) UIColor *borderUIColor;
@end
@implementation CALayer (GPExtension)

-(void)setBorderUIColor:(UIColor*)color

{
    
    self.borderColor = color.CGColor;
    
}

-(UIColor*)borderUIColor

{
    return [UIColor colorWithCGColor:self.borderColor];
    
}


@end
