//
//  RWTSearchResultsItemViewModel.m
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 28..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsItemViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "RWTFlickrPhotoMetadata.h"

@interface RWTSearchResultsItemViewModel ()

@property (weak, nonatomic) id<RWTViewModelServices> services;
@property (strong, nonatomic) RWTFlickrPhoto *photo;

@end

@implementation RWTSearchResultsItemViewModel

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo services:(id<RWTViewModelServices>)services
{
    self = [super init];
    if (self) {
        _title = photo.title;
        _url = photo.url;
        _services = services;
        _photo = photo;
        
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    //RACSignal *fetchMetadata = [RACObserve(self, isVisible) filter:^BOOL(NSNumber *visible) {
    //    return [visible boolValue];
    //}];
    RACSignal *visibleStateChanged = [RACObserve(self, isVisible) skip:1];
    RACSignal *visibleSignal = [visibleStateChanged filter:^BOOL(NSNumber *value) {
        return [value boolValue];
    }];
    RACSignal *hiddenSignal = [visibleStateChanged filter:^BOOL(NSNumber *value) {
        return ![value boolValue];
    }];
    
    RACSignal *fetchMetadata = [[visibleSignal delay:1.0f] takeUntil:hiddenSignal];
    
    @weakify(self)
    [fetchMetadata subscribeNext:^(id x) {
        @strongify(self)
        [[[self.services getFlickrSearchService] flickrImageMetadata:self.photo.identifier] subscribeNext:^(RWTFlickrPhotoMetadata *x) {
            self.favorites = @(x.favorites);
            self.comments = @(x.comments);
        }];
    }];
}

@end
