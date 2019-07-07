//
//  ViewController.h
//  InsecureApp
//
//  Created by Seung Cheol Jung on 05/07/2019.
//  Copyright © 2019 Seung Cheol Jung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UITextField *HTTPRspCacheLeakURLField;
@property (weak, nonatomic) IBOutlet UILabel *HTTPRspCacheLeakStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *HTTPRspCacheLeakImage;

- (IBAction)HTTPRspCacheLeakDownloadButton1Tapped:(UIButton *)sender;
- (IBAction)HTTPRspCacheLeakDownloadButton2Tapped:(UIButton *)sender;
- (IBAction)HTTPRspCacheLeakDownloadButton3Tapped:(UIButton *)sender;
- (IBAction)HTTPRspCacheLeakDownloadButton4Tapped:(UIButton *)sender;

@end

