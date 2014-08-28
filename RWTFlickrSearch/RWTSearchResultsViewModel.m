//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 28..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import "RWTFlickrPhoto.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTSearchResultsItemViewModel.h"

@implementation RWTSearchResultsViewModel

-(instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)services
{
    if (self = [super init]) {
        _title = results.searchString;
        //_searchResults = results.photos;
        _searchResults = [results.photos linq_select:^id(RWTFlickrPhoto *photo) {
            return [[RWTSearchResultsItemViewModel alloc] initWithPhoto:photo services:services];
        }];
        RWTFlickrPhoto *photo = results.photos.firstObject;
        RACSignal *metaDataSignal = [[services getFlickrSearchService] flickrImageMetadata:photo.identifier];
        [metaDataSignal subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
    }
    return self;
}

@end
