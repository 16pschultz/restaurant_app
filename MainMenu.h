//
//  MainMenu.h
//  Restaurant App
//
//  Created by Peter Schultz on 11/11/15.
//  Copyright © 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenu : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *restaurantObjects;

@property (strong, nonatomic) IBOutlet UICollectionView *restaurantColView;

//@property (strong, nonatomic) IBOutlet UILabel *labelForRestaurant;

@end
