# Browser Portability Standards
This document defines the standards to be followed when implementing Web-based applications so as to ensure that users
are not constrained to a particular browser or browser version.

(This is likely to be subsumed into general browser-based application standards.)

## Introduction
This document defines the standards to be followed when implementing Web-based applications so as to ensure that users
are not constrained to a particular browser or browser version.

 > TBC - something about the purpose of these standards?  Is this necessary or just a waste of the reader's time?

## Design Principles
This section provides the portability design principles to be applied when building Web-based applications.
They are presented broadly in order of importance.

###Principle 1 - Cross Browser Support
Web applications will only be built using features that are well supported across the major browsers.

Benefits:

 - Users are more likely to be able to change browser and still be able to use the Web application, thus decoupling the
 application from the browser technology constraint.

Implications:

 - It will not be possible to use certain features within Web applications.

###Principle 2 - Current Browser Support
Web applications will be built using features that are well supported across the **current** versions of major browsers.

Benefits:

 - Web application functionality is not constrained by older browsers that do not support modern features and standards.

Implications:

 - Users will need to be able to switch to a more modern browser if their current version of a particular browser is
 significantly out of date.

###Principle 3 - Progressive Enhancement
A progressive enhancement approach will be taken to Web application design.

This is actually a broader design principle than just a consideration for browser portability, but it has relevance
here.

Benefits:

 - Unsupported features, particularly in mobile browsers, are less likely to cause portability problems.

Implications:

 - Proper progressive enhancement requires more effort than simply designing for a fixed platform.

###Principle 4 - Mobile Apps are Different
Where mobile apps are built using Web technologies with a native wrapper, these principles should only be applied
**as far as is reasonable**.

Benefits:

 - By following the principles to some degree it helps to make re-platforming native apps easier.
 - By not slavishly adhering to the principles it enables mobile apps to make use of the features that the native
 platform makes available, which is pretty much the point of a native app.
 - By only following the principles up to a point, it makes development of mobile apps quicker by allowing them to
 focus only on support for specific platforms.

Implications:

 - There will be some effort required in re-platforming mobile apps, should this ever be required.

## Design Standards

###Standard 1 - Browser Support
Current browser support must be determined,
using https://www.gov.uk/service-manual/user-centred-design/browsers-and-devices as a guide.

###Standard 2 - No CSS
A basic, functional interface must be provided for clients that have CSS disabled.

###Standard 3 - No Javascript
A basic, functional interface must be provided for clients that have Javascript disabled.

###Standard 4 - HTML Features
HTML features must be checked on http://caniuse.com for current compatibility.

Incompatible HTML features *may* be used provided that a fallback is implemented and tested for supported browsers.

Any such fallbacks will be catalogued so that they can be reviewed and potentially eliminated in future updates to the
interface.

###Standard 5 - CSS Features
No vendor- or browser-specific prefixes will be used.  And this includes CSS generated from SASS and the like.

CSS features are the quirkiest (least compatible) of the browser technologies.

Users dream of a simple, intuitive interface that gently steers them through the process of undertaking their allotted
tasks, whilst Web designers dream of fluid, responsive interfaces that dynamically shape themselves to the user's every
need.

In reality, this kind of thing requires the use of browser-specific CSS features due to lack of consistent support
across browsers.  This makes these interfaces a development support hell.

So, any feature that requires the use of a vendor prefix in order to be supported across browsers will not be used.

CSS features must be checked on http://caniuse.com and http://www.quirksmode.org for current compatibility.

The potential use of vendor-specific features will be catalogued so that they can be reviewed and potentially
exploited in future updates to the interface, when they become better supported.

###Standard 6 - DOM Features
DOM features must be checked on http://caniuse.com and http://www.quirksmode.org for current compatibility.

Standard Javascript libraries such as JQuery and Dojo that provide an abstraction of the DOM may be used to provide
feature compatibility.

Any such libraries will be catalogued so that they can be reviewed and potentially eliminated in future updates to
the interface.

###Standard 7 - Javascript Features
Javascript features must be checked on http://caniuse.com for current compatibility.

Custom shims to support features on incompatible browsers will not be developed, as these are a maintenance headache.
Sorry, you'll just have to do without that feature until it has better cross-browser support.

However, well supported open source third party shims or libraries *may* be used.

Any such libraries will be catalogued so that they can be reviewed and potentially eliminated in future updates to the
interface.

###Standard 8 - Compatibility Testing
Browser compatibility will be tested using automated tools

> TBC

###Standard 9 - Review and Update

###Standard 10 - Review and Update
Browser compatibility requirements will be re-assessed at least once every 12 months.

Interfaces will be rechecked and retested against any changed browser compatibility requirements and feature support.

Use of fallbacks will be updated as necessary, i.e. potentially every 12 months, as a result of rechecking and
retesting.

## Implementation Checklist
This section provides a summary list of checks to be made when implementing a browser-based user interface.

 1. Identify current browser standards - this can vary depending on your target audience,
    but generally: https://www.gov.uk/service-manual/user-centred-design/browsers-and-devices
 2. Check caniuse.com
 3. Check quirksmode.org
 4. Build the interface using progressive enhancement.
 5. Don't use CSS vendor prefixes.
 6. Check to see if Javascript frameworks such as JQuery or Dojo can provide useful abstraction of DOM and Javascript
    features.
 7. Check to see if there are supported, third-party shims for useful Javascript features.
 8. Use a browser compatibility testing platform (TBC).
 9. Create a catalogue of libraries, shims and vendor features. 
 10. Keep reviewing current standards and update the user interface accordingly.
