Mobile Application Standards
============================

Scope
-----

These standards apply to mobile application in-house development and management.

These standards are intended to cover all forms of mobile application: from fully "off-line capable" progressive web applications, through cross-platform apps to fully native apps.

As implied, there are a number of ways of delivering mobile apps. These standards will cover which approach is best and under what circumstances, and aspects that are common to all or many of the approaches. As and when more detail is available on specific approaches, such as Flutter app development, or Progressive Web Apps, such approach-specific standards should form part of their own separate, detailed, documented standard, which, ideally, will simply be a reference to a recognised external standard for that specific technology.

Caveats
-------

The huge increase in the use of mobile devices means that mobile application development is now of critical interest to the DEFRA family, even more so given the amount of field-work being carried out by workers within the DEFRA family.

This is a fast moving area involving multiple platforms and diverse technology stacks: these standards are therefore early and provisional. As such, these standards often require more background explanation and justification than those for other, more mature or more homogenous, technology stacks. Inevitably, therefore, these standards, for the time being, are likely to be more discursive than those for other areas, and, unavoidably, the line between standard and guidance can often, as yet, not be so sharply drawn.

This document should therefore be read in conjunction with the Mobile Application Guidance.

Which Mobile Platforms Must Be Supported
----------------------------------------

Mobile applications must run on mobile devices. Currently DEFRA has adopted Apple technology as the standard platform for mobile devices. **All mobile applications intended for internal use must therefore run on Apple devices. All mobile applications intended for use beyond the DEFRA family, by any form of "extended enterprise" or the general public, must run on at least Apple and Android devices.**

Working Offline
---------------

Users of mobile devices, and especially DEFRA family field workers who will often be working in remote, rural locations, must be able to continue to use any mobile applications even when lack of signal prohibits any form of internet access. In fact, **continuing to be readily usable without an internet connection, including the ability to work with data locally on the device, must be considered a defining characteristic of a truly mobile app.**

Extra Security Considerations
-----------------------------

Application and data security is always essential, and mobile apps can be especially exposed to security risks and challenges. All mobile devices suffer from poor physical security in terms of being easily lost or stolen, and all have to operate over potentially insecure public networks. Furthermore, when an app is intended to run on a public device, then the security of the device is an unknown, and, by default, we should assume the device is inherently insecure. This means that the points below **must be considered and addressed very early in any project to develop such a mobile app**, as they could even influence the practical viability of the app or the scope of the requirements it can securely deliver.

As mobile applications will usually be accessing the internet over entirely public networks **all traffic to and from the app must be encrypted**, for example via HTTPS/Transport Layer Security and/or via the use of a Virtual Private Network (VPN) and/or in-built application security wrapper. Please consult the latest security standards as to the appropriate level of encryption any such mechanisms should adopt, given the confidentiality marking of the data in question.

**If your app, which will normally be operating across the public internet, needs to access DEFRA family systems that are non-public, developers and/or application architects must consult with the Cloud Mobile Services team in Group Infrastructure and Operations**, who will advise on what is or isn't permissible and, where permissible, what mechanisms they can provide to allow such access to be done securely. For example, Cloud Mobile Services may advise as to VPN software and VPN end-points that they can make available to mobile devices that can allow safe access into "back-end", non-public DEFRA family systems in the cloud or on premise.

There are other recommendations to also bear in mind, especially around the security of data on the device and authentication strategies, so you are strongly advised to also read the accompanying **[guidance](/guides/mobile_app_guidance.md)** on mobile app development alongside these standards.

Which Type of Mobile Technology to Adopt
----------------------------------------

Mobile apps will usually be required to work on multiple devices and operating systems. For example, for apps intended for general public use, we have already stated that mobile apps created by the DEFRA family must work on at least the Apple and Android platforms. That alone creates a considerable development challenge, and can mean continuing high costs of ownership, especially as those platforms are rapidly changing, and some suppliers, such as Apple, impose additional constraints and demands on users of their technology stack. Add in the need for the mobile app to work readily even with no internet access, and the additional concerns mobile poses to security, and the approach adopted to deliver a mobile app needs to be chosen extremely carefully, following the standard hierarchy explained below, **starting from the top and only working your way further down the options where it is clearly necessary to do so.**

### 

### Option 0: Pick Something "Off-The-Shelf"

This means that, **before developing an in-house app, it is even more important than for other bespoke developments to consider if a Commercial Off-The-Shelf (COTS) approach is preferred**. For example, is a suitable app already available in the app stores? Also, if the app is intended for use with an already adopted COTS suite, for example a time recording or asset management system, then is it possible that the supplier of that suite already has or will soon have a suitable app available, removing the need for us to develop our own app and then integrate that app with third party software? Then not only the development costs of the app, but also the ongoing costs of ownership, will be shared across the supplier's many customers rather than being having to be paid by us alone.

If using a third party app of any kind carefully assess whether use of that app will be appropriate given the sensitivity of the data it will be handling. In particular, many apps, especially free apps available in app stores, harvest user data, for example via Google Analytics. If those data harvesting features cannot be reliably disabled, and the data being processed by the app is in any way sensitive, then the use of such an app would be entirely inappropriate.

### Option 1: Develop a Progressive Web App (PWA)

**Where an in-house app is needed the first option to consider is a Progressive Web App (PWA), as recommended by the Government Digital Service here: <https://www.gov.uk/service-manual/technology/working-with-mobile-technology>**

Progressive Web Apps provide cross platform and cross device support and can be delivered just like ordinary web apps to the browser, so no engagement with an app store or Mobile Device Management (MDM) software is needed, either by ourselves or the users, and the constraints of dealing with a proprietary platform, such as Apple, are avoided (for example, Apple require all apps to be re-released with a renewed provisioning profile at least once a year). Ongoing costs of ownership, as compared with other bespoke approaches, ought to be lower. Furthermore the skills involved in developing Progressive Web Apps are more transferable and much more likely to have a longer shelf life, so time and money invested in learning will have a bigger pay-off. This approach should also make it feasible to take existing web applications, and progressively enhance them until they can become PWAs.

Unfortunately, the DEFRA family mandating of Apple devices does have some negative implications for Progressive Web Apps, of which we need to be aware. Apple force the use of the Safari/WebKit browser on all iOS/iPad OS devices, and, of all the major browsers, Safari has the most limited support for Progressive Web Apps. There is no way around this as even other browser apps in the Apple app store, such as Chrome, are merely wrappers for WebKit. The most notable restrictions are likely to be around size of storage (though, in January 2020, and if using IndexedDB, which is usually the most functional local storage option in any case, over 1 GB was found to be available on a DEFRA iPad), persistence of stored data (as of March 2020 you can depend on IndexedDB data being retained for at least 2 weeks, and possibly much longer, even if an app is completely unused, and data has been observed to survive an iPad OS and Safari update. This therefore seems to be a diminishing issue, though one of which you should be aware.) and the fact that, in Safari on iOS or iPad OS, the way you install an app on the home screen is still currently non-standard.

It is possible to build a perfectly useful PWA that runs on Safari, including being able to access native features such as taking photos (though, at the time of writing, only stills and not videos) and accessing geolocation. However, the situation is always changing, usually improving, though that cannot be guaranteed, so you must use a site such as <https://whatwebcando.today/> to assess which features are actually available in Safari on a DEFRA Apple device before committing to delivering a PWA. Similarly, you should assess the current storage capabilities of Safari on a device by using a web site such as <https://demo.agektmr.com/storage/>.

Of course, PWAs are storing data locally: otherwise they cannot work offline. That means that you will also need to consider the security of the data at rest on the device. These considerations are slightly different for PWAs than for other apps, as the data is being retained in the browser. If, as is likely and recommended, you are using IndexedDB to store your data, then all browsers compliant with the W3C spec, such as Safari, will only allow JavaScript from the same origin as the PWA that has created the database to access that data. Also, your data will be protected by your device's normal data encryption: for example, for an internally managed DEFRA iPad where the setting of a passcode is enforced, that means the data will be encrypted whenever the device is turned off, and only decrypted when the user re-enters the correct passcode. That means "reasonably" secure, but most likely not as secure as Apple's app sandboxing, and this should be borne in mind when assessing whether or not a PWA is appropriate, given the sensitivity, or not, of the data it will be handling, and the general security features of the devices where the app will be in use.

### Option 2: Build a Cross-Platform App

If, having considered above and done the recommended research, a PWA is not acceptable, the next option to consider is building the mobile app using a cross platform technology stack. These stacks are ways of using the same, or very close to the same, code-base but still building the app in ways that can allow it to run on multiple platforms and multiple devices. Otherwise a completely different code base, using a different language and development framework, is needed to build an app for each platform.

There are many such cross platform technology stacks, but some are obscure or are nearing obsolescence. This is still a too broad and fast moving area for us to as yet mandate solid standards, so you are therefore strongly advised to read the accompanying Mobile Application Guidance before considering a technology stack for developing cross platform apps.

In the past one common technique used to build cross platform apps was to actually run the app inside a hidden browser on the device, with such apps often being called "hybrid" apps. However, that is not the approach adopted by any of latest and more popular frameworks, and it is increasingly challenged by ever stricter adoption of "single origin" security restrictions in more modern browser engines. A mobile app rendering local content automatically uses up one "origin", to be precise, before it even starts to interact with any \"remote\" systems, plus single origin restrictions disallow delivering up local content via AJAX calls. Therefore, such frameworks including Apache Cordova, the closely related PhoneGap (which is Adobe's own Cordova variant) and Cordova-based Ionic (though Ionic also now has a React based version) must now be regarded as legacy and **not used for new projects**. It is still just about possible to work around such restrictions using the above frameworks, but the approaches then become painful and convoluted, for example Cordova-based Ionic does so by using a local web server built into the app. **Avoid these "hybrid" approaches for building a cross-platform app within a browser.**

Note that cross platform app development, where in any way feasible, **is always preferable to native app development, even when we are currently targeting only a single platform (say Apple) and range of associated devices**. That is because such apps ought to be easily adaptable to run on a different platform, for example if our selected choice of devices changes, or if we decide to make the app, or a version of the app, available on more devices. Furthermore, investment, in terms of time, money and "hard lessons learned", in cross platform app development is more likely to be applicable across the whole range of possible future apps than if we focus on a single native app technology.

### Option 3: Build a Native App

As a final fallback option it is therefore permissible to develop a native application. **Should the app be intended for anything other than purely and permanently internal use, this will involve developing and maintaining two entirely separate versions of the app, using the technologies native to the given platform: meaning using the Swift language and the Xcode IDE for Apple, and either the Java or Kotlin languages for Android** (Android Studio is the free and recommended IDE for such development but, as this is a much more open eco-system, it cannot be mandated).

**A native app developed purely and permanently for internal use should be developed in Swift and Xcode alone.**

Note that Swift is essentially a replacement for an earlier Apple language called Objective-C. Objective-C is a notoriously eccentric programming language and, as it is now also arguably approaching obsolescence, **its use must be avoided on any new projects.**

Troubleshooting
---------------

Often, issues will only be encountered when running apps on actual target devices. **Therefore you must have the knowledge, kit, privileges and app distribution arrangements in place to be able to remotely debug the app on suitable devices.**

Information about errors occurring on mobile devices will often be lost to us, making problem resolution much more difficult. To mitigate this issue **the app must log errors, and it must be possible for the user to make that information available to us for support purposes**, even if that is just via screenshot. It should also be possible to vary the level of detail logged, for example by implementing a "debug" mode. Early implementation of such features is very likely to also speed up error resolution during development itself.

Extra Considerations for Testing Mobile Apps
--------------------------------------------

**Mobile Apps must be tested on a representative range of platforms and devices.** That range of platforms and devices will obviously depend on the intended use of the app: for example, it can include the Apple platform and associated devices for an internal app, but for an app intended for use beyond the DEFRA family will include at least both the Apple and Android platforms and associated devices.

**At all times clearly state the specific operating system versions and device types on which the app will be tested, and where it is therefore "officially supported". This list will change constantly as operating systems and devices are updated.**

Appropriate tools should be adopted to facilitate this. For example, if using a full functional IDE such as Xcode or Android Studio, make extensive use of the device simulators.

However, no simulator is entirely perfect, and, once the mobile app has gone live, you will also be faced with the need to keep it tested and running despite rapid operating system updates (for example, for iPad OS these occur roughly monthly). It is therefore also strongly recommended that you acquire, and refresh as needed, a range of suitable devices for use in developing and then supporting the app.

**If the app is to be deployed on DEFRA managed devices it must be tested on the currently latest DEFRA adopted version of iOS/iPad OS and the currently latest public version of iOS/iPad OS** (most of the time these versions will be the same, but there is normally a slight delay between Apple releasing a new version of iOS/iPad OS and DEFRA adoption, to ensure that no business critical apps have been negatively affected).

**If the app is intended for use outside DEFRA, then it must be tested on the versions of iOS/iPad OS stated above, plus it should also be tested on the previous public version, at least. It must also be tested on the latest version of Android and should also be tested on the previous version, at least.**

**Device/s must also be enrolled in any beta programmes and used to test emerging versions of iOS/iPad OS or Android, so that we have advance warning of any upcoming issues.**

Distributing and Managing Apps
------------------------------

**A mechanism must be adopted to distribute the app and app updates to end user devices.**

For progressive web apps this task is straight-forward: merely requiring the end user to navigate to the app's URL in a browser.

All other apps (either cross platform or native) can be released through an app store or by other means (e.g. downloaded from a website, or distributed to a managed device via Mobile Device Management software such as AirWatch). However, Apple apps, outside of a very limited distribution to up to 100 devices specifically associated with the "provisioning profile" built into the app, can only be distributed outside the Apple app store if you are signed up to the Apple Developer Enterprise Programme. Android apps can be distributed though Google's own Google Play Store app store or through other online app stores, or for free by other mechanisms, such as via a download from a website, or internally via an MDM.

Publication of a public app to a well-known app store, such as the Apple App Store will often be desirable, for example to make the app more easily discoverable. However, bear in mind that distributing via an app store requires the app store providers to "accept" an app into their store and thus creates an extra "hurdle" to jump. Apple, for example, may reject a perfectly functional app simply because its look and feel is deemed insufficiently "native" for their platform.

The Environment Agency is signed up to the Apple Developer Enterprise Programme, at least at the time of writing, January 2020, and can therefore distribute apps by means other than the Apple app store when it chooses to do so. As of the same date (January 2020) core DEFRA and the other parts of the DEFRA family are NOT signed up to the Apple Developer Enterprise Programme. However, the costs of signing up are low, in the order of hundreds of pounds a year. **If you want to sign up another part of DEFRA to the Apple Enterprise Programme, first seek the advice of the Cloud Mobile Services team.**

These standards note the above considerations, **and do not mandate the distribution mechanism for apps intended to be available for use beyond the DEFRA family itself**. This is because we are already mandating that apps for use beyond the DEFRA family must already support at least both Apple and Android devices. To add to that requirement, for example, a mandatory rule that any such apps must also be published through the Apple App Store, when we could be allowed to publish outside of the store at low or no (at least for the Environment Agency) additional cost, for example via a GOV.UK website, would be overly and unnecessarily restrictive. Normally distribution through the Apple App Store and the Google Play Store would be recommended, but is not obligatory.

For internal apps, meaning those intended for use purely within the DEFRA family on managed devices, we have the option of distributing our apps via the DEFRA family's enterprise Mobile Device Management software, which is currently AirWatch. This brings many advantages in terms of app management and monitoring, such as, for example, controlling which user groups receive the app, allowing those groups to receive the app automatically or forcing the app to always use a provided VPN when connecting to specific URLs (this approach is called "per app" or "in-app" VPN). **Production distribution of internally developed apps intended purely for internal use, meaning use within the DEFRA family on managed devices, must therefore be via the DEFRA Mobile Device Management system, currently AirWatch. Note the unavoidable implication of this rule: this means that internal apps developed for use by any part of DEFRA other than the Environment Agency will require an Apple Developer Enterprise Programme membership to be arranged for the part of DEFRA that needs to use the app.**
