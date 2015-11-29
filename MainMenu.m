//
//  MainMenu.m
//  Restaurant App
//
//  Created by Peter Schultz on 11/11/15.
//  Copyright © 2015 Cape Up Development. All rights reserved.
//

#import <Parse/Parse.h>

#import "MainMenu.h"
#import "RestaurantViewCell.h"
#import "ViewController.h"

@interface MainMenu ()

@end

@implementation MainMenu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self queryForRestaurantData];
    self.restaurantColView.delegate = self;
    self.restaurantColView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController.navigationBar setHidden:YES];

}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.restaurantObjects count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RestaurantViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
        
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 7;
    
    NSNumber *resName = [self.restaurantObjects objectAtIndex:indexPath.row][@"name"];
    cell.labelForRestaurant.text = [NSString stringWithFormat:@"%@", resName];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150.0, 150.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showRestaurant" sender:indexPath];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showRestaurant"]) {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        ViewController *viewC = (ViewController *)segue.destinationViewController;
        
        viewC.resObjectId =  [[self.restaurantObjects objectAtIndex:indexPath.row]objectId];
        viewC.resName =      [self.restaurantObjects objectAtIndex:indexPath.row][@"name"];
        viewC.resLocation =  [self.restaurantObjects objectAtIndex:indexPath.row][@"resLocation"];
        viewC.resLongitude = [self.restaurantObjects objectAtIndex:indexPath.row][@"longitude"];
        viewC.resLatitude =  [self.restaurantObjects objectAtIndex:indexPath.row][@"latitude"];
        viewC.resPhoneNum =  [self.restaurantObjects objectAtIndex:indexPath.row][@"phoneNum"];
        viewC.stringColor =  [self.restaurantObjects objectAtIndex:indexPath.row][@"color"];
    }
}

- (void) queryForRestaurantData {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.restaurantObjects = objects;
        NSLog(@"%@", self.restaurantObjects);
        
        [self.restaurantColView reloadData];
    }];
}

@end
