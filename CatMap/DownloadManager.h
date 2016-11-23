//
//  DownloadManager.h
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DownloadManager : NSObject

@property (nonatomic, strong) NSString *tagValue;

- (void)getCatPictures:(void (^)(NSArray *pictures))completion;
- (void)getImage:(NSURL *)url completion:(void (^)(UIImage *image))completion;

@end
