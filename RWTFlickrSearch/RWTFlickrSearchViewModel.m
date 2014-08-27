//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 26..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"

@interface RWTFlickrSearchViewModel()
@property (nonatomic, weak) id<RWTViewModelServices> services;
@end

@implementation RWTFlickrSearchViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithServices:(id<RWTViewModelServices>)services
{
    self = [super init];
    if (self) {
        _services = services;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.title = @"Flickr Search";
    RACSignal *validSearchSignal = [[RACObserve(self, searchText) map:^id(NSString *text) {
        return @(text.length > 3);
    }]distinctUntilChanged];
    [validSearchSignal subscribeNext:^(id x) {
        NSLog(@"search text is valid %@", x);
    }];
    
    self.executeSearch = [[RACCommand alloc] initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        return  [self executeSearchSignal];
    }];
}

- (RACSignal *)executeSearchSignal
{
    //return [[[[RACSignal empty] logAll] delay:2.0] logAll];
    return [[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText] logAll];;
}

@end
