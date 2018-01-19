//
//  SantaCatalinaCollectionCell.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTGTagCollectionView;
@class TTGTextTagCollectionView;

#import "SCTagVMCell.h" // link on viewModel


@interface SCTagCell : UITableViewCell

#pragma mark - UI property
// Own UI
@property (nonatomic, strong) TTGTextTagCollectionView *tagView;


#pragma mark - Method for work with TTGTextTagCollectionView

// Call in in the first place
- (void) initTagViewWithArray:(NSArray<NSString*>*) array
                     getHeightBlock:(void (^)(float heightCell))calculatedHeight;

// Call in in the second place
- (void)setTags:(NSArray <NSString *> *)tags;

// Call in in the thrid place
- (void) addConstraintAndAnotherSettingsToTagView;


#pragma mark - Data property
// link on cell viewmodel
@property (weak, nonatomic) SCTagVMCell* vm_cell;


@end


