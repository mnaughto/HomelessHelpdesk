//
//  SpringDictionary.h
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpringLinkArray.h"
//dictionary for retrieving data from spring web services. I think.
@interface SpringObject : NSDictionary
//the only constructor that's really valid for this class
-(id)initWithContentsOfURL:(NSURL *)url;
@property (readonly, strong) SpringLinkArray* links;
-(NSUInteger) count;
-(id) objectForKey:(id)aKey;
-(NSEnumerator *) keyEnumerator;
@end
