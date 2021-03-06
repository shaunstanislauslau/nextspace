/** @class NXUtilities
    @brief The various utility functions wich can't be assigned to some class.
    
    @author Sergii Stoian
*/

#import "NXUtilities.h"
#import <NXSystem/NXScreen.h>

NSString *
shortenString(NSString *fullString, CGFloat viewWidth, NSFont *font,
              NXElementType elementType, NXDotsPosition dotsPosition)
{
  NSMutableString *shortString = [NSMutableString stringWithString:fullString];
  NSMutableArray  *pathComponents;

  viewWidth -= [font widthOfString:@"..."];

  if (([font widthOfString:shortString]) <= viewWidth)
    {
      return fullString;
    }

  while ([font widthOfString:shortString] > viewWidth)
    {
      if (dotsPosition == NXDotsAtLeft)
        {
          if (elementType == NXSymbolElement)
            {
              [shortString deleteCharactersInRange:NSMakeRange(0, 1)];
            }
          else if (elementType == NXPathElement)
            {
              pathComponents = [[shortString pathComponents] mutableCopy];
              [pathComponents removeObjectAtIndex:0];
              shortString = [[NSString pathWithComponents:pathComponents] 
                              mutableCopy];
              [pathComponents release];
            }
          else // NXWordElement
            {
              // TODO
            }
        }
      else if (dotsPosition == NXDotsAtRight)
        {
          if (elementType == NXSymbolElement)
            {
              [shortString 
                deleteCharactersInRange:NSMakeRange([shortString length]-1, 1)];
            }
          else if (elementType == NXPathElement)
            {
              shortString = [NSMutableString 
                              stringWithString:
                                [shortString stringByDeletingLastPathComponent]];
            }
          else // NXWordElement
            {
              // TODO
            }
        }
      else // NXDotsAtCenter
        {
          // TODO
        }
    }

  // String was shortened - insert dots
  if (dotsPosition == NXDotsAtLeft)
    {
      if (elementType == NXSymbolElement ||
          elementType == NXWordElement)
        {
          return [NSString stringWithFormat:@"...%@", shortString];
        }
      else if (elementType == NXPathElement)
        {
          return [NSString stringWithFormat:@".../%@", shortString];
        }
    }
  else if (dotsPosition == NXDotsAtRight)
    {
      if (elementType == NXSymbolElement ||
          elementType == NXWordElement)
        {
          return [NSString stringWithFormat:@"%@...", shortString];
        }
      else if (elementType == NXPathElement)
        {
          return [NSString stringWithFormat:@"%@/...", shortString];
        }
    }
  else // NXDotsAtCenter
    {
      // TODO
    }

  return fullString;
}

// NSInteger NXRunAlertPanel(NSString *title,
//                           NSString *msg,
//                           NSString *defaultButton,
//                           NSString *alternateButton,
//                           NSString *otherButton, ...)
// {
//   id        panel;
//   NSInteger result;
//   va_list       ap;

//   va_start(ap, otherButton);
//   panel = NSGetAlertPanel(title, msg, 
//                           defaultButton,
//                           alternateButton,
//                           otherButton, ap);
//   va_end(ap);

//   {
//     NSSize  screenSize = [[NXScreen sharedScreen] sizeInPixels];
//     NSPoint panelOrigin;

//     [panel center];
//     panelOrigin = [panel frame].origin;
//     panelOrigin.y =
//       (screenSize.height - screenSize.height/4) - [panel frame].size.height;
//     [panel setFrameOrigin:panelOrigin];
//   }
  
//   result = [NSApp runModalForWindow:panel];
//   [panel orderOut:panel];
//   NSReleaseAlertPanel(panel);
  
//   return result;
// }
