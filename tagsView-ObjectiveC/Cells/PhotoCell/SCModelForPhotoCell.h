//
//  SantaCatalinaPhotoCellModel.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCBaseModelForCell.h"

@interface SCModelForPhotoCell : SCBaseModelForCell

@property (nonatomic, strong) NSString* photoURL;

#pragma mark - Inits methods

- (instancetype) initWithPhotoURL:(NSString*) photoURL;
@end
