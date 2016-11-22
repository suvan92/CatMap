//
//  DownloadManager.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "DownloadManager.h"
#import "CatPicture.h"

@implementation DownloadManager

- (NSArray *)getCatImages {
    NSMutableArray *catImagesArray = [NSMutableArray new];
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=a7e8eeb660518f4cb05325751027181d&tags=cat&has_geo=1&extras=url_m&format=json&nojsoncallback=1"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"json error: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *photosDict = jsonDictionary[@"photos"];
        NSArray *arrayOfPhotos = photosDict[@"photo"];
        
        for (NSDictionary *catPic in arrayOfPhotos) {
            NSString *title = catPic[@"title"];
            NSString *url = catPic[@"url_m"];
            
            CatPicture *picture = [[CatPicture alloc] initWithTitle:title andUrl:url];
            [catImagesArray addObject:picture];
        }
    }];
    [dataTask resume];
    return catImagesArray;
}

@end
