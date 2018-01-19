# tagsView-ObjectiveC


This project shows how is the work of the library TTGTagCollectionView. Use the MVVM architecture.
<br>
<br>

| The start screen| The end screen   |
| ------------- |:-------------:|
|![alt text](https://raw.githubusercontent.com/m1a7/tagsView-ObjectiveC/master/ScreensForReadme/iphone1.png)    | ![alt text](https://raw.githubusercontent.com/m1a7/tagsView-ObjectiveC/master/ScreensForReadme/iphone2.png)  |

<br>
<br>

| Vertical orientation | Horizontal orientation  |
| ------------- |:-------------:|
|![alt text](https://raw.githubusercontent.com/m1a7/tagsView-ObjectiveC/master/ScreensForReadme/ipadAir1.png)    | ![alt text](https://raw.githubusercontent.com/m1a7/tagsView-ObjectiveC/master/ScreensForReadme/ipadAir2.png)  |


<br>
<br>

### Main Setting method

```objectivec
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
```
