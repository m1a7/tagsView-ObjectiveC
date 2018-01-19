//
//  SantaCatalinaVMCell.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCPhotoVMCell.h"

@implementation SCPhotoVMCell

#pragma mark - Inits methods


- (instancetype)initWithModel:(SCModelForPhotoCell*) model
{
    self = [super init];
    if (self) {

        self.model = model;
        self.photoURL = self.model.photoURL;
    }
    return self;
}

@end
