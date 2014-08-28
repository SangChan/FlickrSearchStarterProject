//
//  RWTFlickrPhotoMetadata.m
//  RWTFlickrSearch
//
//  Created by SangChan on 2014. 8. 28..
//  Copyright (c) 2014년 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrPhotoMetadata.h"

@implementation RWTFlickrPhotoMetadata

- (NSString *)description
{
    return [NSString stringWithFormat:@"metadata: comments=%lU, faves=%lU", (unsigned long)self.comments, (unsigned long)self.favorites];
}
@end
