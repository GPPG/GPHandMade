//
//  PhotosContainerView.m
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/5/13.
//

#import "PhotosContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "UIView+RoundedCorner.h"
#define coutn 10
@implementation PhotosContainerView
{
    NSMutableArray *_imageViewsArray;
}

- (instancetype)initWithMaxItemsCount:(NSInteger)count
{
    if (self = [super init]) {
        self.maxItemsCount = count;
    }
    return self;
}

- (void)setPhotoNamesArray:(NSArray *)photoNamesArray
{
    _photoNamesArray = photoNamesArray;
    
    if (!_imageViewsArray) {
        _imageViewsArray = [NSMutableArray new];
    }
    
    int needsToAddItemsCount = (int)(_photoNamesArray.count - _imageViewsArray.count);
    
    if (needsToAddItemsCount > 0) {
        for (int i = 0; i < needsToAddItemsCount; i++) {
            UIImageView *imageView = [UIImageView new];
            [self addSubview:imageView];
            [_imageViewsArray addObject:imageView];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    
    [_imageViewsArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        if (idx < _photoNamesArray.count) {
            imageView.hidden = NO;
            imageView.sd_layout.heightEqualToWidth();
            
            NSURL *imageUrl = [NSURL URLWithString:photoNamesArray[idx]];
            [[SDWebImageManager sharedManager] downloadImageWithURL:imageUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    [imageView jm_setCornerRadius:(SCREEN_WIDTH - 102)/ (2 * coutn) withImage:image];
                }
            }];
            [temp addObject:imageView];
        } else {
            [imageView sd_clearAutoLayoutSettings];
            imageView.hidden = YES;       
        }
    }];
    
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:coutn verticalMargin:2 horizontalMargin:2];
}



@end
