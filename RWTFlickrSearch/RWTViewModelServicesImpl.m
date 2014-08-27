//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 26..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

@interface RWTViewModelServicesImpl()

@property (strong,nonatomic) RWTFlickrSearchImpl *searchService;

@end

@implementation RWTViewModelServicesImpl

- (instancetype)init
{
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchImpl new];
    }
    return self;
}


- (id<RWTFlickrSearch>)getFlickrSearchService
{
    return self.searchService;
}
@end
