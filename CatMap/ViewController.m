//
//  ViewController.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "ViewController.h"
#import "DownloadManager.h"
#import "CatImageCellCollectionViewCell.h"
#import "CatPicture.h"
#import "DetailViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *arrayOfCatPictures;
@property (nonatomic, strong) DownloadManager *downloadManager;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"PictureCell";
static NSString * const detailSegueIdentifier = @"showDetailVC";
static NSString * const searchSegueIdentifier = @"displaySearchVC";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.downloadManager = [[DownloadManager alloc] init];
    [self getCatPictures];
    [self addSearchButton];
    
    NSNotificationCenter *nCentre = [NSNotificationCenter defaultCenter];
    [nCentre addObserver:self selector:@selector(newSearch:) name:@"newSearchValue" object:nil];
}

#pragma mark - General Methods

- (void) getCatPictures{
    [self. downloadManager getCatPictures:^(NSArray *pictures) {
        self.arrayOfCatPictures = pictures;
        [self.collectionView reloadData];
    }];
}

-(void)newSearch:(NSNotification *)notification {
    [self getCatPictures];
}

- (void) addSearchButton {
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithTitle:@"Search"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(goToSearchVC)];
    self.navigationItem.rightBarButtonItem = searchButton;
}

- (void)goToSearchVC {
    [self performSegueWithIdentifier:searchSegueIdentifier sender:self];
}

#pragma mark - Collection View

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayOfCatPictures.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatImageCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.catPicture = self.arrayOfCatPictures[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:detailSegueIdentifier sender:self];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:detailSegueIdentifier]) {
        CatPicture *catPicture = [self.arrayOfCatPictures objectAtIndex:self.selectedIndexPath.row];
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.picture = catPicture;
    }
}

@end
