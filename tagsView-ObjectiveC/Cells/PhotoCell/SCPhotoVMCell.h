//
//  SantaCatalinaVMCell.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//


#import "SCBaseVMCell.h"

// Model
#import "SCModelForPhotoCell.h"

@interface SCPhotoVMCell : SCBaseVMCell

#pragma - Own modified properties
// photoURL
@property (nonatomic, strong) NSString* photoURL;

#pragma - Model
// link on model
@property (nonatomic, strong) SCModelForPhotoCell* model;

#pragma mark - Inits methods
- (instancetype)initWithModel:(SCModelForPhotoCell*) model;
@end
