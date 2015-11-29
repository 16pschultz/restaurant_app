//
//  QRCodeVC.m
//  Restaurant App
//
//  Created by Peter Schultz on 7/27/15.
//  Copyright (c) 2015 Cape Up Development. All rights reserved.
//

#import "QRCodeVC.h"
#import <Parse/Parse.h>

@interface QRCodeVC ()

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic) BOOL isReading;

-(BOOL)startReading;
-(void)stopReading;
-(void)loadBeepSound;


@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.imageCheckmark.image = [UIImage imageNamed:@""];
    
    // Initially make the captureSession object nil.
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    [self loadBeepSound];
    
    self.viewPreview.layer.cornerRadius = 20;
    self.viewPreview.layer.masksToBounds = YES;

}

- (void) viewWillAppear:(BOOL)animated {
    
    [[self.viewPreview layer] setBorderWidth:1.5f];
    [[self.viewPreview layer] setBorderColor:[UIColor whiteColor].CGColor];
    
    // Navigation Bar Attibutes
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationController.navigationBar.barTintColor = self.resColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;

    
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {

        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        [self stopReading];
    }
    
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    
    
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    self.messageString = AVMetadataObjectTypeQRCode;
    
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    
//    self.imageCheckmark.image = [UIImage imageNamed:@"checkmark_RA"];
    
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    /*
     // Remove the video preview layer from the viewPreview view's layer.
     [_videoPreviewLayer removeFromSuperlayer];
     */
}


-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Initialize the audio player object using the NSURL object previously set.
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // If the audio player cannot be initialized then log a message.
        NSLog(@"Could not play beep file.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        // If the audio player was successfully initialized then load it in memory.
        [_audioPlayer prepareToPlay];
    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            NSString *scanResult = [metadataObj stringValue];
            
            if ([scanResult isEqualToString:@"MAILTO:capeupdev@gmail.com"]) {
                
                self.imageCheckmark.image = [UIImage imageNamed:@"checkmark_RA"];
                
                [[self.viewPreview layer] setBorderWidth:2.0f];
                [[self.viewPreview layer] setBorderColor:[UIColor greenColor].CGColor];
                
                [[PFUser currentUser] incrementKey:@"Points" byAmount:[NSNumber numberWithInt:1]];
                [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"The object has been saved.");
                    } else {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }];
                
                
                //if statement for 12 hour count. Maybe if (timer < 43,000 || NSDate 12 hours) {
                // }
            
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"1 point has been added to your account" delegate:nil cancelButtonTitle:@"Yes!" otherButtonTitles:nil];
            
                [alertView show];
                
                NSLog(@"Correct QR Code!");

            } else {
                
                [[self.viewPreview layer] setBorderWidth:2.5f];
                [[self.viewPreview layer] setBorderColor:[UIColor redColor].CGColor];
                
                self.wrongQRCodeLabel.text = @"Wrong QR Code!";
                NSLog(@"Wrong QR Code!");
                
            }
            
            NSLog(@"%@", scanResult);
            
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            _isReading = NO;
            
            // If the audio player is not nil, then play the sound effect.
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
    
    
}

@end
