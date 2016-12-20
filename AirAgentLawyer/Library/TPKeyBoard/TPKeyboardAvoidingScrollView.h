//
//  TPKeyboardAvoidingScrollView.h
//  TPKeyboardAvoiding
//
//  Created by Michael Tyson on 30/09/2013.
//  Copyright 2015 A Tasty Pixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"

@protocol TpKeyboardDelegate <NSObject>

//-(void) didTextFieldEditingStart:(id) textField;
-(void) didTextFieldEditingFinish:(id) textField;
-(BOOL) willTextFieldBeginEditing:(id) textField;

@optional
-(BOOL) shouldChangeTextViewText:(id) textView range: (NSRange) range1 text:(NSString *)str1;

@end


@interface TPKeyboardAvoidingScrollView : UIScrollView <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, weak) id <TpKeyboardDelegate> delegate;


- (void)contentSizeToFit;
- (BOOL)focusNextTextField;
- (void)scrollToActiveTextField;
@end
