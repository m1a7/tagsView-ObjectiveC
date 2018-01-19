//
//  SantaCatalinaCell.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCPhotoCell.h"
#import "ANHelperFunctions.h"


CGSize CGSizeAspectFit(const CGSize aspectRatio, const CGSize boundingSize)
{
    CGSize aspectFitSize = CGSizeMake(boundingSize.width, boundingSize.height);
    float mW = boundingSize.width / aspectRatio.width;
    float mH = boundingSize.height / aspectRatio.height;
    if( mH < mW )
        aspectFitSize.width = mH * aspectRatio.width;
    else if( mW < mH )
        aspectFitSize.height = mW * aspectRatio.height;
    return aspectFitSize;
}


@implementation SCPhotoCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (CGFloat) calculateHeightOfImageViewSize:(CGSize) imgViewSize andImageSize:(CGSize) uiimageSize
{    
    CGSize resultSize = CGSizeAspectFit(uiimageSize, CGSizeMake(imgViewSize.width, CGFLOAT_MAX));
    return resultSize.height;
}


- (void) setVm_cell:(SCPhotoVMCell *)vm_cell
{
    _vm_cell = vm_cell;
    // Дальше вытаскиваем все из viewModel и сетим в UI
    // Then take out all of the viewModel and set in the UI
    ANDispatchBlockToMainQueue(^{
        self.santaCatalinaImgView.image = [UIImage imageNamed: _vm_cell.photoURL];
    });
}
@end
