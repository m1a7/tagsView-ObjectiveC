//
//  SantaCatalinaCollectionVMCell.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCTagVMCell.h"

@implementation SCTagVMCell

#pragma mark - Inits methods

- (instancetype)initWithModel:(SCModelForTagCell*) model
{
    self = [super init];
    if (self) {
        
        self.model = model;
        self.tags =  [NSArray arrayWithArray:self.model.tags];
    }
    return self;
}


@end
