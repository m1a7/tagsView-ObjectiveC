//
//  SantaCatalinaCollectionVMCell.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCBaseVMCell.h"
// Model
#import "SCModelForTagCell.h"


@interface SCTagVMCell : SCBaseVMCell

#pragma - Own modified properties
// Array for TagView
@property (nonatomic, strong) NSArray* tags;

#pragma - Model
// link on model
@property (nonatomic, strong) SCModelForTagCell* model;

#pragma mark - Inits methods
- (instancetype)initWithModel:(SCModelForTagCell*) model;

@end
