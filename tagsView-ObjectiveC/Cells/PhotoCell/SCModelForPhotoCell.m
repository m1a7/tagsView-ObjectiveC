//
//  SantaCatalinaPhotoCellModel.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCModelForPhotoCell.h"

@implementation SCModelForPhotoCell

#pragma mark - Inits methods
- (instancetype) initWithPhotoURL:(NSString*) photoURL
{
    self = [super init];
    if (self) {
        self.photoURL = photoURL;
    }
    return self;
}

@end
