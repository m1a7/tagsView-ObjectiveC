//
//  SantaCatalinaCollectionCellModel.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCBaseModelForCell.h"

@interface SCModelForTagCell : SCBaseModelForCell

@property (nonatomic, strong) NSArray* tags;

#pragma mark - Inits methods
- (instancetype) initWithTags:(NSArray<NSString*>*) tag;

@end
