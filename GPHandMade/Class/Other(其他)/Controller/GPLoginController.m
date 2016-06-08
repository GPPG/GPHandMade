//
//  GPLoginController.m
//  GPHandMade
//
//  Created by dandan on 16/6/7.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPLoginController.h"

@interface GPLoginController ()
- (IBAction)btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation GPLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)btn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
