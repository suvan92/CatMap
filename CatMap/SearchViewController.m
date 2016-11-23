//
//  SearchViewController.m
//  CatMap
//
//  Created by Suvan Ramani on 2016-11-22.
//  Copyright © 2016 suvanr. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)searchButton:(UIButton *)sender {
    [self searchFunction];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchFunction];
    return NO;
}

-(void)searchFunction {
    NSString *searchString = self.searchField.text;
    
    NSNotificationCenter *nCentre = [NSNotificationCenter defaultCenter];
    NSDictionary *searchDict = @{@"searchValue" : searchString};
    NSNotification *notification = [[NSNotification alloc] initWithName:@"newSearchValue" object:nil userInfo:searchDict];
    [nCentre postNotification:notification];
}



@end
