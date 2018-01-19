//
//  SantaCatalinaCollectionCellModel.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCModelForTagCell.h"

@implementation SCModelForTagCell

#pragma mark - Inits methods

- (instancetype) initWithTags:(NSArray<NSString*>*) tag
{
    self = [super init];
    if (self) {
        self.tags =  [NSArray arrayWithArray:tag];
    }
    return self;
}

@end
