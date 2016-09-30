//
//  DataService.h
//  MovieApp
//
//  Created by Peter Gikera on 25/07/2016.
//  Copyright © 2016 @iLabAfrica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataService.h"

@interface SearchDataService : BaseDataService


-(NSMutableArray *) getSearchedFilmFromAPI:(NSString *)searchParam;



@end
