//
//  SantaCatalinaVM.h
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCBaseVMCell;
@class SCBaseModelForCell;


@interface SantaCatalinaVM : NSObject

@property (assign, nonatomic) float heightForSecondCell;

@property (nonatomic, strong) NSMutableArray<SCBaseVMCell*>* cellsArray;    // Here store ViewModels cell`s
@property (nonatomic, strong) NSMutableArray<SCBaseModelForCell*>* modelArray; // Here story Model cell's

#pragma mark - Work with API

- (void) getDataFromServer:(void(^)(BOOL successOperation)) success
                 onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure;


#pragma mark - Methods for TableView work

- (SCBaseVMCell*) cellViewModel:(NSInteger) index;
- (NSInteger)       countCells;

#pragma mark  - UI Handlers

- (void) didSelectAtRowFromTable:(NSIndexPath*) indexPath;
- (void) addToFavoriteBtnClicked;

@end
