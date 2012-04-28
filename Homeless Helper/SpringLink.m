//
//  SpringLink.m
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpringLink.h"

@implementation SpringLink {
    NSDictionary* dataSource;
    NSURL* url; 
    SpringObject* _child;
}
//source is the dictionary derived from JSON. it should be the data array containing this object. 
-(id)initFromIndex: (NSUInteger) index inArray: (NSArray *) array{
    if(self = [super init]){
        dataSource = [array objectAtIndex:index];
    }
    return self;
}

-(NSURL *) url{
    if(!url){
        url = [NSURL URLWithString:[[dataSource valueForKey:@"href"] description]];
    }
    return url;
}

-(NSString *) rel {
    return [[dataSource valueForKey:@"rel"] description];
}

-(SpringObject *) child {
    if(!_child){
        _child = [[SpringObject alloc] initWithContentsOfURL:[self url]];
    }
    return _child;
}
@end
