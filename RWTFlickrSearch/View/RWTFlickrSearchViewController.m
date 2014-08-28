//
//  Created by Colin Eberhardt on 13/04/2014.
//  Copyright (c) 2014 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RWTFlickrSearchViewController ()

@property (weak, nonatomic) RWTFlickrSearchViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *searchHistoryTable;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

@end

@implementation RWTFlickrSearchViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self bindViewModel];
  
}

- (instancetype)initWithViewModel:(RWTFlickrSearchViewModel *)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
        [_viewModel.connectionErrors subscribeNext:^(NSError *error) {
            UIAlertView *alert =
            [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                       message:@"There was a problem reaching Flickr."
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
            [alert show];
        }];
    }
    return self;
}

- (void)bindViewModel
{
    self.title = self.viewModel.title;
    self.searchTextField.text = self.viewModel.searchText;
    RAC(self.viewModel, searchText) = self.searchTextField.rac_textSignal;
    self.searchButton.rac_command = self.viewModel.executeSearch;
    RAC([UIApplication sharedApplication], networkActivityIndicatorVisible) = self.viewModel.executeSearch.executing;
    RAC(self.loadingIndicator, hidden) = [self.viewModel.executeSearch.executing not];
    
    [self.viewModel.executeSearch.executionSignals subscribeNext:^(id x) {
        [self.searchTextField resignFirstResponder];
    }];
}

@end
