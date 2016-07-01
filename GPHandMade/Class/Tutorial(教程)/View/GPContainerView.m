//
//  GPContainerView.m
//  GPHandMade
//
//  Created by dandan on 16/6/30.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPContainerView.h"

@interface GPContainerView()<UIScrollViewDelegate>

@property (nonatomic, copy) selecBlock selecB;
@property (nonatomic, strong) NSArray *childVcArray;
@property (nonatomic, strong) UIView *lasetView;
@end

@implementation GPContainerView

- (instancetype)initWithChildControllerS:(NSArray *)vcArray selectBlock:(selecBlock)selecB
{
    if (self = [super init]) {
        self.selecB = selecB;
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.childVcArray = vcArray;
        [self layout];
    }
        return self;
}
- (void)layout
{
    UIView *lastView = nil;
    for (UIViewController *viewVc in self.childVcArray) {
        [self addSubview:viewVc.view];
        if (lastView) {
            viewVc.view.sd_layout
            .widthIs(SCREEN_WIDTH)
            .heightIs(SCREEN_HEIGHT)
            .leftSpaceToView(lastView,0);
        }else{
            viewVc.view.sd_layout
            .widthIs(SCREEN_WIDTH)
            .heightIs(SCREEN_HEIGHT)
            .leftSpaceToView(self,0);
        }
        lastView = viewVc.view;
    }
    [self setupAutoContentSizeWithRightView:lastView rightMargin:0];
}
-(void)updateVCViewFromIndex:(NSInteger )index
{
    [self setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + SCREEN_WIDTH / 2) / SCREEN_WIDTH;
    self.selecB(page);
}
@end
