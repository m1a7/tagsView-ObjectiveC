//
//  SantaCatalinaVM.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SantaCatalinaVM.h"

// ViewModels Cells
#import "SCBaseVMCell.h"

// Models
#import "SCModelForPhotoCell.h"
#import "SCModelForTagCell.h"

//ViewModel
#import "SCPhotoVMCell.h"
#import "SCTagVMCell.h"

#import "ANHelperFunctions.h"

@implementation SantaCatalinaVM


#pragma mark - Inits methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellsArray = [NSMutableArray array];
    }
    return self;
}


#pragma mark - Work with API

- (void) getDataFromServer:(void(^)(BOOL successOperation)) success
                 onFailure:(void(^)(NSError* errorBlock,  NSObject* errObj)) failure {
    
    [self.cellsArray removeAllObjects];
    
    __weak SantaCatalinaVM *weakSelf = self;
    
    ANDispatchBlockToBackgroundQueue(^{
        
                    //        for (int i = 0; i <= 10000; i++) {
                    //            NSLog(@"i=%d",i);
                    //        }
            NSArray* tags = @[@"#AutoLayout", @"#dynamically", @"#calculates", @"#the", @"#size", @"#and", @"#position",
                              @"#of", @"#all", @"#the", @"#views", @"#in", @"#your", @"#view", @"#hierarchy", @"#based",
                              @"#on", @"#constraints", @"#placed", @"#on", @"#those", @"#views", @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"
                              , @"#constraints", @"#placed", @"#on", @"#those", @"#views"];

        // Наши модели
            SCModelForPhotoCell*      photoModel      = [[SCModelForPhotoCell alloc] initWithPhotoURL:@"CourtHouse"];
            SCModelForTagCell* collectionModel = [[SCModelForTagCell alloc] initWithTags:tags];
        
            self.modelArray = [NSMutableArray arrayWithArray:@[photoModel,collectionModel]];
        
            // Проходим по массиву моделей
            for (SCBaseModelForCell* model in self.modelArray)
            {
                // Если такое класс, то такая ViewModel. И добавляем ее в self.cellsArray
                if ([model isMemberOfClass:[SCModelForPhotoCell class]])
                {
                    SCModelForPhotoCell* customModel = (SCModelForPhotoCell*)model;
                    [weakSelf.cellsArray addObject: [[SCPhotoVMCell alloc]initWithModel:customModel]];
                }
                // Если такое класс, то такая ViewModel. И добавляем ее в self.cellsArray
                if ([model isMemberOfClass:[SCModelForTagCell class]])
                {
                    SCModelForTagCell* customModel = (SCModelForTagCell*)model;
                    [weakSelf.cellsArray addObject: [[SCTagVMCell alloc]initWithModel:customModel]];
                }
            }
        
            if (weakSelf.cellsArray)
                success(YES);
            else
                failure(nil,@"Self.cellsArray is empty");
    });
}


#pragma mark - Methods for TableView work

- (SCBaseVMCell*) cellViewModel:(NSInteger) index{
    
    if (index > self.cellsArray.count){
        return nil;
    }
    return self.cellsArray[index];
}

- (NSInteger) countCells{
    return self.cellsArray.count;
}

#pragma mark  - UI Handlers

- (void) didSelectAtRowFromTable:(NSIndexPath*) indexPath
{
    SCBaseVMCell* cellVM = [self cellViewModel:indexPath.row];
    // [[Router sharedRouter] openDetailVCwithLinkOnFullCV: cellVM.model.linkOnFullModel];
    NSLog(@"Was selected row at index.row = %ld index.section = %ld",(long)indexPath.row, indexPath.section);
}

- (void) addToFavoriteBtnClicked{
    NSLog(@"addToFavoriteBtnClicked");
}


@end


