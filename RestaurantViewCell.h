//
//  RestaurantViewCell.h
//  Restaurant App
//
//  Created by Peter Schultz on 11/11/15.
//  Copyright © 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *restaurantImage;

@property (strong, nonatomic) IBOutlet UILabel *labelForRestaurant;

@end
