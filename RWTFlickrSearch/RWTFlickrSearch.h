//
//  RWTFlickrSearch.h
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 26..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol RWTFlickrSearch <NSObject>

- (RACSignal *)flickrSearchSignal:(NSString *)searchString;

@end
