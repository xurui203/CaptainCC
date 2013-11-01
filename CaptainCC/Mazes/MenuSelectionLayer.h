//
//  MenuSelectionLayer.h
//  CaptainCC
//
//  Created by Xu Rui on 31/10/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuSelectionLayer : CCLayer {
    NSInvocation *callback;
}

-(id) initWithHeader:(NSString *)header andLine1:(NSString *)line1 andLine2:(NSString *)line2 andLine3:(NSString *)line3 target:(id)callbackObj selector:(SEL)selector;

-(void) buttonPressed:(id) sender;

@end

