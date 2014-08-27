//
//  RWTFlickrSearchResults.m
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 26..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchResults.h"

@implementation RWTFlickrSearchResults

- (NSString *)description
{
    return [NSString stringWithFormat:@"searchString=%@, totalresults=%lU, photos=%@", self.searchString, (unsigned long)self.totalResults, self.photos];
}

@end
