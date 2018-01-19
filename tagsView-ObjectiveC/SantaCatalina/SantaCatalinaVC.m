//
//  SantaCatalinaVC.m
//  tagsView-ObjectiveC
//
//  Created by Uber on 17/01/2018.
//  Copyright © 2018 Uber. All rights reserved.
//

#import "SantaCatalinaVC.h"
#import "SCPhotoCell.h"
#import "SCTagCell.h"
#import <QuartzCore/QuartzCore.h>
#define PhotoCell   1
#define TagViewCell 1
#define standartCellHeight 100.f

@class TTGTextTagCollectionView;
#import <TTGTagCollectionView/TTGTextTagCollectionView.h>


#import "SCPhotoVMCell.h"           // ViewModel для ячейки SantaCatalinaPhotoCell
#import "SCTagVMCell.h"              // ViewModel для ячейки SantaCatalinaCollectionCell


//////////////////////////////////////////////////
////                                          ////
////                                          ////
////    NEW MVVM ARCHITECTURE IMPLEMENTATION  ////
////                                          ////
////                                          ////
//////////////////////////////////////////////////

@interface SantaCatalinaVC ()

#pragma mark - UI property
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton    *addToFavoriteBtn;
@property (weak, nonatomic) IBOutlet UIView      *gradientView;

@end

@implementation SantaCatalinaVC

#pragma mark - Init methods

- (instancetype)init{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self = [storyboard instantiateViewControllerWithIdentifier:@"SantaCatalinaVC"];
    if (self) {
    }
    return self;
}


#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupUIBeforeUsingController];
}

#pragma mark - UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.vm_TableView didSelectAtRowFromTable:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.vm_TableView countCells];
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCBaseVMCell* vm  = [self.vm_TableView cellViewModel:indexPath.row];
    
    if ([vm isMemberOfClass:[SCPhotoVMCell class]])
    {
        SCPhotoVMCell* myVM = (SCPhotoVMCell*)vm;
        return [SCPhotoCell calculateHeightOfImageViewSize:CGSizeMake(CGRectGetWidth(self.tableView.frame)-(StandartOffSetInCell*2), CGFLOAT_MAX)
                                                         andImageSize:[UIImage imageNamed:myVM.photoURL].size]+(StandartOffSetInCell*2);
        
    }
    
    if ([[self.vm_TableView cellViewModel:indexPath.row] isMemberOfClass:[SCTagVMCell class]])
    {
        return (CGFloat)self.vm_TableView.heightForSecondCell;
    }
    
    return standartCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell;
    NSString* identifier;
    
    SCBaseVMCell* vm  = [self.vm_TableView cellViewModel:indexPath.row];
    
    if ([vm isMemberOfClass:[SCPhotoVMCell class]])                  identifier = @"SCPhotoCell";
    if ([vm isMemberOfClass:[SCTagVMCell class]])                    identifier = @"SCTagCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:cell atIndexPath:indexPath];
}

#pragma mark - UITableView helper methods

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath
{
    __weak SantaCatalinaVC *weakSelf = self;
    
    ANDispatchBlockToBackgroundQueue(^{
        
           // Get viewmodel's cell
            SCBaseVMCell* vm  = [weakSelf.vm_TableView cellViewModel:indexPath.row];
        
            // check, where is from this vm class
            if ([cell isMemberOfClass:[SCPhotoCell class]])
            {
                SCPhotoCell*  customCell = (SCPhotoCell*)cell;
                if (!customCell.vm_cell) {
                    customCell.vm_cell = (SCPhotoVMCell*)vm;
                }
            }
        
            if ([cell isMemberOfClass:[SCTagCell class]])
            {
                SCTagCell* customCell = (SCTagCell*)cell;

                // Additional configuration ....
                if (!customCell.vm_cell)
                    customCell.vm_cell = (SCTagVMCell*)vm;
                
                if (weakSelf.vm_TableView.heightForSecondCell < 1.f)
                {
                    [customCell initTagViewWithArray:customCell.vm_cell.tags
                                      getHeightBlock:^(float heightCell) {
                                         
                                          weakSelf.vm_TableView.heightForSecondCell = heightCell;
                                          ANDispatchBlockToMainQueue(^{
                                              [weakSelf.tableView reloadData];
                                          });
                                      }];
                } else if (weakSelf.vm_TableView.heightForSecondCell > 1.f && customCell.tagView)
                {
                    [customCell addConstraintAndAnotherSettingsToTagView];
                }
            }
    });
}

#pragma mark - Others
// Setters
- (void) setVm_TableView:(SantaCatalinaVM *)vm_TableView
{
    _vm_TableView = vm_TableView;
    
    if (self.addToFavoriteBtn)
        [self.addToFavoriteBtn addTarget:_vm_TableView  action:@selector(addToFavoriteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_vm_TableView getDataFromServer:^(BOOL successOperation) {
        [self.tableView reloadData];
    } onFailure:^(NSError *errorBlock, NSObject *errObj) {
        NSLog(@"errObj = %@",errObj);
    }];
}

- (void) setupUIBeforeUsingController
{
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.29 green:0.31 blue:0.32 alpha:1.0];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // Add target to button
    if (self.vm_TableView)
       [self.addToFavoriteBtn addTarget:self.vm_TableView  action:@selector(addToFavoriteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    // Around "Favorite" Button
    self.addToFavoriteBtn.layer.masksToBounds = NO;
    self.addToFavoriteBtn.layer.cornerRadius  = CGRectGetWidth(self.addToFavoriteBtn.frame)/45;
    
    // Add shadow to button
    self.addToFavoriteBtn.layer.shadowColor   = [UIColor greenColor].CGColor;
    self.addToFavoriteBtn.layer.shadowOpacity = 0.1;
    self.addToFavoriteBtn.layer.shadowRadius  = 3;
    self.addToFavoriteBtn.layer.shadowOffset  = CGSizeMake(0.0f, 2.0f);
    
    // Call method for redraw UIStatusBar in light color
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Add gradient half-transparent for self.gradientView
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame  = self.gradientView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:0.17 green:0.22 blue:0.25 alpha:0.0].CGColor,
                        (id)[UIColor colorWithRed:0.17 green:0.22 blue:0.25 alpha:1.0].CGColor];
    self.gradientView.alpha = 0.9f;
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
    self.gradientView.backgroundColor = [UIColor colorWithRed:0.17 green:0.22 blue:0.25 alpha:1.0];
    
    // Set color in backgroundColor
    self.view.backgroundColor = [UIColor colorWithRed:0.17 green:0.22 blue:0.25 alpha:1.0]; // dark color
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

