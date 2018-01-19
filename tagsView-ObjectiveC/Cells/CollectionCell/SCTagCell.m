//
//  SantaCatalinaCollectionCell.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SCTagCell.h"

// Fraemworks
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>

#import "ANHelperFunctions.h"

#define standartOffSet 15.f

@implementation SCTagCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        __weak SCTagCell *weakSelf = self;
        ANDispatchBlockToMainQueue(^{
            weakSelf.backgroundColor = [UIColor colorWithRed:0.14 green:0.15 blue:0.15 alpha:1.0];
        });
    }
    return self;
}

#pragma mark - Method for work with TTGTextTagCollectionView


// Call in in the first place
- (void) initTagViewWithArray:(NSArray<NSString*>*) array getHeightBlock:(void (^)(float heightCell))calculatedHeigh
{
    [self initTagViewWithArray:array];
    ANDispatchBlockToMainQueue(^{
        calculatedHeigh([self getTotalHeightOfCollectionTagView]);
    });
}

// Call in in the second place
- (void)setTags:(NSArray<NSString *> *)tags {
    [_tagView removeAllTags];
    [_tagView addTags:tags];
    
    // Use manual height, update preferredMaxLayoutWidth
    //_tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 16;
}

// Call in in the thrid place
- (void) addConstraintAndAnotherSettingsToTagView
{
    __weak SCTagCell *weakSelf = self;

    ANDispatchBlockToMainQueue(^{
        
        [weakSelf.contentView addSubview:_tagView];
        
        [weakSelf.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:weakSelf.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:15]];
        
        [weakSelf.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView
                                                                     attribute:NSLayoutAttributeLeading
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:weakSelf.contentView
                                                                     attribute:NSLayoutAttributeLeading
                                                                    multiplier:1.0
                                                                      constant:15]];
        
        [weakSelf.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:weakSelf.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:-15]];
        
        [weakSelf.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:weakSelf.contentView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:-15]];
    });

}

#pragma mark - Private methods

- (void) initTagViewWithArray:(NSArray<NSString*>*) array
{
    __weak SCTagCell *weakSelf = self;

  ANDispatchBlockToMainQueue(^{

    weakSelf.tagView = [[TTGTextTagCollectionView alloc] initWithFrame:CGRectMake(standartOffSet,
                                                                                  standartOffSet,
                                                                                  CGRectGetWidth(weakSelf.contentView.frame)-standartOffSet*2,
                                                                                  50.f)];
    weakSelf.tagView.alignment = TTGTagCollectionAlignmentFillByExpandingWidth;
    weakSelf.tagView.translatesAutoresizingMaskIntoConstraints = NO;
    weakSelf.tagView.showsVerticalScrollIndicator = NO;
    weakSelf.tagView.scrollView.scrollEnabled = NO;
    
    TTGTextTagConfig *config = [TTGTextTagConfig new];

    config.tagBackgroundColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00];
    config.tagTextFont = [UIFont fontWithName:@"AvenirNext-UltraLight" size:15.f];
      
    [weakSelf.tagView removeAllTags];
    [weakSelf.tagView addTags:array withConfig:config];
   });
}


// Get height of tagView (with offset)
- (float) getTotalHeightOfCollectionTagView
{
    if (self.tagView) return (float)self.tagView.contentSize.height+(standartOffSet*2);
    return 0.f;
}

// Ovverided setter our viewmodel
- (void) setVm_cell:(SCTagVMCell *)vm_cell
{
    _vm_cell = vm_cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}



@end
