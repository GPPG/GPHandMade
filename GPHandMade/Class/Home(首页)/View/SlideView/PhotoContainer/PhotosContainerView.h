//
//  PhotosContainerView.h
//  SDAutoLayoutDemo
//
//  Created by gsd on 16/5/13.

//

#import <UIKit/UIKit.h>

@interface PhotosContainerView : UIView

- (instancetype)initWithMaxItemsCount:(NSInteger)count;

@property (nonatomic, strong) NSArray *photoNamesArray;

@property (nonatomic, assign) NSInteger maxItemsCount;

@end
