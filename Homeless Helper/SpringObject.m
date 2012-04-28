//
//  SpringDictionary.m
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpringObject.h"

@implementation SpringObject {
    NSDictionary * dataSource;
    SpringLinkArray * _links;
}
-(id) initWithContentsOfURL:(NSURL *)url {
    if(self = [super init]){
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        NSURLResponse * response;
        NSError * error;
        NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        result = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&error];
        dataSource = (NSDictionary*) result;
    }
    return self;
}

-(NSUInteger) count {
    return [dataSource count] - 1; //we don't want to include links with our normal attributes
}

-(id) objectForKey:(id)aKey {
    if([[aKey description] isEqualToString:@"_links"]){
        return nil;
    } else {
        return [dataSource objectForKey:aKey];
    }
}

-(NSEnumerator*) keyEnumerator {
    return [dataSource keyEnumerator];
}

-(SpringLinkArray *) links {
    if(!_links){
        _links = [[SpringLinkArray alloc] initWithArray:[dataSource objectForKey:@"_links"]];
    }
    return _links;
}
@end
