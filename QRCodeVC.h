//
//  QRCodeVC.h
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface QRCodeVC : UIViewController <AVCaptureMetadataOutputObjectsDelegate> {
    
    NSTimer *timer;

}

@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (strong, nonatomic) IBOutlet UIImageView *imageCheckmark;

@property (strong, nonatomic) IBOutlet UILabel *wrongQRCodeLabel;

@property(nonatomic, assign) NSString *messageString;

@end
