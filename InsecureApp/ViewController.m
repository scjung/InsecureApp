//
//  ViewController.m
//  InsecureApp
//
//  Created by Seung Cheol Jung on 05/07/2019.
//  Copyright © 2019 Seung Cheol Jung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTextFieldsOfKeyboardCachingScene];
}


- (void)addTextFieldsOfKeyboardCachingScene {
    UITextField *textFieldDefault = [[UITextField alloc] init];
    textFieldDefault.placeholder = @"program,auto correction=Default";
    textFieldDefault.autocorrectionType = UITextAutocorrectionTypeDefault;
    [self.keyboardCachingStackView addArrangedSubview:textFieldDefault];
    
    UITextField *textFieldYes = [[UITextField alloc] init];
    textFieldYes.placeholder = @"program,auto correction=Yes";
    textFieldYes.autocorrectionType = UITextAutocorrectionTypeYes;
    [self.keyboardCachingStackView addArrangedSubview:textFieldYes];
    
    UITextField *textFieldNo = [[UITextField alloc] init];
    textFieldNo.placeholder = @"program,auto correction=No";
    textFieldNo.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.keyboardCachingStackView addArrangedSubview:textFieldNo];
}


- (IBAction)HTTPRspCacheLeakDownloadButton1Tapped:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:[self.HTTPRspCacheLeakURLField text]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    void (^setStatusLabelAfterCompletion)(NSData *, NSURLResponse *, NSError *) =
        ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString *label;
            UIImage *image = nil;
            if (error == nil) {
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *httpRsp = (NSHTTPURLResponse *)response;
                    label = [NSString stringWithFormat:@"Success\n(status code=%ld, mime type=%@)",
                             httpRsp.statusCode, httpRsp.MIMEType];
                    if ([httpRsp.MIMEType isEqualToString:@"image/png"]) {
                        image = [UIImage imageWithData:data];
                    }
                } else {
                    label = @"Non-HTTP response.";
                }
            } else {
                label = error.localizedDescription;
            }
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                self.HTTPRspCacheLeakStatusLabel.text = label;
                if (image != nil) {
                    [self.HTTPRspCacheLeakImage setImage:image];
                }
            });
    };
    
    NSURLSessionDataTask *task =
        [session dataTaskWithURL:url completionHandler:setStatusLabelAfterCompletion];
    
    self.HTTPRspCacheLeakStatusLabel.text = @"Downloading...";
    [task resume];
}

- (IBAction)HTTPRspCacheLeakDownloadButton2Tapped:(id)sender {
    NSURL *url = [NSURL URLWithString:[self.HTTPRspCacheLeakURLField text]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    void (^setStatusLabelAfterCompletion)(NSURL *, NSURLResponse *, NSError *) =
    ^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *label;
        UIImage *image = nil;
        if (error == nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpRsp = (NSHTTPURLResponse *)response;
                label = [NSString stringWithFormat:@"Success\n(status code=%ld, mime type=%@)",
                         httpRsp.statusCode, httpRsp.MIMEType];
                if ([httpRsp.MIMEType isEqualToString:@"image/png"]) {
                    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                }
            } else {
                label = @"Non-HTTP response.";
            }
        } else {
            label = error.localizedDescription;
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.HTTPRspCacheLeakStatusLabel.text = label;
            if (image != nil) {
                [self.HTTPRspCacheLeakImage setImage:image];
            }
        });
    };
    
    NSURLSessionDownloadTask *task =
        [session downloadTaskWithURL:url completionHandler:setStatusLabelAfterCompletion];
    
    self.HTTPRspCacheLeakStatusLabel.text = @"Downloading...";
    [task resume];
}

- (IBAction)HTTPRspCacheLeakDownloadButton3Tapped:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:[self.HTTPRspCacheLeakURLField text]];
    
    NSURLSession *session =
        [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration];
    
    void (^setStatusLabelAfterCompletion)(NSData *, NSURLResponse *, NSError *) =
    ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *label;
        UIImage *image = nil;
        if (error == nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpRsp = (NSHTTPURLResponse *)response;
                label = [NSString stringWithFormat:@"Success\n(status code=%ld, mime type=%@)",
                         httpRsp.statusCode, httpRsp.MIMEType];
                if ([httpRsp.MIMEType isEqualToString:@"image/png"]) {
                    image = [UIImage imageWithData:data];
                }
            } else {
                label = @"Non-HTTP response.";
            }
        } else {
            label = error.localizedDescription;
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.HTTPRspCacheLeakStatusLabel.text = label;
            if (image != nil) {
                [self.HTTPRspCacheLeakImage setImage:image];
            }
        });
    };
    
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url completionHandler:setStatusLabelAfterCompletion];
    
    self.HTTPRspCacheLeakStatusLabel.text = @"Downloading...";
    [task resume];
}

- (IBAction)HTTPRspCacheLeakDownloadButton4Tapped:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:[self.HTTPRspCacheLeakURLField text]];
    
    NSURLSessionConfiguration *sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration;
    sessionConfig.URLCache = nil;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    void (^setStatusLabelAfterCompletion)(NSData *, NSURLResponse *, NSError *) =
    ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *label;
        UIImage *image = nil;
        if (error == nil) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpRsp = (NSHTTPURLResponse *)response;
                label = [NSString stringWithFormat:@"Success\n(status code=%ld, mime type=%@)",
                         httpRsp.statusCode, httpRsp.MIMEType];
                if ([httpRsp.MIMEType isEqualToString:@"image/png"]) {
                    image = [UIImage imageWithData:data];
                }
            } else {
                label = @"Non-HTTP response.";
            }
        } else {
            label = error.localizedDescription;
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.HTTPRspCacheLeakStatusLabel.text = label;
            if (image != nil) {
                [self.HTTPRspCacheLeakImage setImage:image];
            }
        });
    };
    
    NSURLSessionDataTask *task =
    [session dataTaskWithURL:url completionHandler:setStatusLabelAfterCompletion];
    
    self.HTTPRspCacheLeakStatusLabel.text = @"Downloading...";
    [task resume];
}
@end
