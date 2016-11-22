//
//  ViewController.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *arrayOfCatPictures;
@property (nonatomic, strong) DownloadManager *downloadManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadManager = [[DownloadManager alloc] init];
}

- (void) getCatJson{
    self.arrayOfCatPictures = [self.downloadManager getCatImages];
}



@end
