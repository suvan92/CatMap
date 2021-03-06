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

-(instancetype)init{
    self = [super init];
    if (self) {
        NSNotificationCenter *nCentre = [NSNotificationCenter defaultCenter];
        [nCentre addObserver:self selector:@selector(changeTagValue:) name:@"newSearchValue" object:nil];
    }
    return self;
}

- (void)changeTagValue:(NSNotification *)notification {
    NSString *tagString = [notification.userInfo objectForKey:@"searchValue"];
    self.tagValue = tagString;
}

- (void)getCatPictures:(void (^)(NSArray *pictures))completion {
    NSMutableArray *catImagesArray = [NSMutableArray new];
    
    NSURL *url = [self constructURL];
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
            NSNumber *pictureId = catPic[@"id"];
            NSString *url = catPic[@"url_m"];
            NSString *sqUrl = catPic[@"url_sq"];
            
            CatPicture *picture = [[CatPicture alloc] initWithTitle:title pictureID:pictureId Url:url andSQUrl:sqUrl];
            [catImagesArray addObject:picture];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(catImagesArray);
        }];
    }];
    [dataTask resume];
}

- (NSURL *)constructURL {
    if (!self.tagValue) {
        self.tagValue = @"cat";
    }
    
    NSDictionary *queryDict = @{@"method" : @"flickr.photos.search", @"api_key" : @"a7e8eeb660518f4cb05325751027181d", @"tags" : self.tagValue, @"has_geo" : @"1", @"extras" : @"url_m, url_sq", @"format" : @"json", @"nojsoncallback" : @"1"};
    
    NSMutableArray *queries = [NSMutableArray new];
    for (NSString *key in queryDict) {
        [queries addObject:[NSURLQueryItem queryItemWithName:key value:queryDict[key]]];
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    components.queryItems = queries;
    
    return components.URL;
}

- (void)getImage:(NSURL *)url completion:(void (^)(UIImage *image))completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(image);
        }];
        
    }];
    [downloadTask resume];
}

@end
