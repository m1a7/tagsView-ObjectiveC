//
//  SantaCatalinaCell.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

#define StandartOffSetInCell 15.f

#import "SCPhotoVMCell.h"


@interface SCPhotoCell : UITableViewCell

#pragma mark - UI property
// Own UI
@property (weak, nonatomic) IBOutlet UIImageView *santaCatalinaImgView;

#pragma mark - Data property
// ViewModel
@property (weak, nonatomic) SCPhotoVMCell* vm_cell; // link on cell's viewmodel

#pragma mark -  Helpers methods
// Layout method. Calculate height of Cell
+ (CGFloat) calculateHeightOfImageViewSize:(CGSize) imgViewSize andImageSize:(CGSize) uiimageSize;

@end
