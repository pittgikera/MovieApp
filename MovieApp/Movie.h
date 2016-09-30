//
//  Movie.h
//  
//
//  Created by Peter Gikera on 04/08/2016.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSManagedObject

@property (nullable, nonatomic, retain) NSString *imdbID;
@property (nullable, nonatomic, retain) NSString *poster;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *year;


@end

NS_ASSUME_NONNULL_END

