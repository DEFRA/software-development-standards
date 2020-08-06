Mobile Application Standards
============================

Introduction
------------

The huge increase in the use of mobile devices means that mobile application development is now of critical interest to the Defra family, even more so given the amount of field-work being carried out by workers within the Defra family.

Scope
-----

These standards apply to mobile application in-house development and management.

These standards are intended to cover all forms of mobile application.

As implied, there are a number of ways of delivering mobile apps. These standards will cover which approach is best and under what circumstances, and aspects that are common to all or many of the approaches. As and when more detail is available on specific approaches, such as Flutter app development, or Progressive Web Apps, such approach-specific standards should form part of their own separate, detailed, documented standard, which, ideally, will simply be a reference to a recognised external standard for that specific technology.

Caveats
-------

This is a fast moving area involving multiple platforms and diverse technology stacks: these standards are therefore early and provisional. As such, these standards often require more background explanation and justification than those for other, more mature or more homogenous, technology stacks. Inevitably, therefore, these standards, for the time being, are likely to be more discursive than those for other areas, and, unavoidably, the line between standard and guidance can often, as yet, not be so sharply drawn.

This document should therefore be read in conjunction with the Mobile Application Guidance (**[guidance](/guides/mobile_app_guidance.md)**).

What is a Mobile App?
---------------------

### Assume We Are Providing an Offline Mobile App Unless We Have Clear Agreement That the App Will Only Work Online.

Mobile apps are commonly defined along the following lines: "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch."

In practice, the user need that often drives the requirement to have a mobile app in the first place is the necessity to use the app when the user is out and about, including in situations where there is no signal and therefore no internet access. Indeed, it is difficult for an app to be truly "mobile" unless it is capable of still doing something useful where connectivity is lost. This is particularly the case for Defra family field workers who will often be working in remote, rural locations.

Therefore, rather than providing purely "mobile apps", we will usually be providing what are commonly called **offline mobile apps** (a.k.a. **offline apps**).

Offline apps can continue to be usable without an internet connection, including being able to work with data locally on the device **if** that is necessary for the app still to perform "usefully".

We should assume that any mobile apps we are providing are offline mobile apps unless we have a clear understanding, and written agreement with the users, that this is not a requirement, as this can often be a cause of confusion, and retrofitting offline functionality to a purely online mobile application after it has been provided may be very difficult or even not practical at all.

### If Only an Online Mobile App Is Needed Its Functionality Should Still Degrade Gracefully When Offline

Even if it is agreed that the app only needs to work online then it should still degrade gracefully when the connection is lost, for example by providing a clear message to the user that connection has been lost and the user should check their connection.

Which Mobile Platforms Must Be Supported
----------------------------------------

### Mobile Applications for Use within the Defra Family Must Run on the Apple Platform; Apps Intended for Public Use Must Run on at Least Apple AND Android Devices

Mobile applications must run on mobile devices. Currently Defra has adopted Apple technology as the standard platform for mobile devices. **All mobile applications intended for internal use must therefore run on Apple devices. All mobile applications intended for by the general public, must run on at least Apple and Android devices. If a mobile application is intended for use outside Defra, but restricted to a specific and atypical (in terms of likely use of mobile technology as compared to the general public) user community, then we will need to be guided by the preferences of that user community in terms of the platform that we need to support.**

Troubleshooting
---------------

### Before Starting Development You Must Have the Knowledge, Kit, Privileges and App Distribution Arrangements in Place to Able to Remotely Debug the App on Suitable Devices.

Often, issues will only be encountered when running apps on actual target devices. **Therefore you must have the knowledge, kit, privileges and app distribution arrangements in place to be able to remotely debug the app on suitable devices.**

### The App Must Log Errors, and It Must be Possible for the User to Make That Information Available to Us for Support Purposes 

Information about errors occurring on mobile devices will often be lost to us, making problem resolution much more difficult. To mitigate this issue **the app must log errors, and it must be possible for the user to make that information available to us for support purposes**, even if that is just via screenshot. It should also be possible to vary the level of detail logged, for example by implementing a "debug" mode. Early implementation of such features is very likely to also speed up error resolution during development itself.

Extra Security Considerations for Mobile Apps
---------------------------------------------

### Assess and Address the Security Challenges to Your App before Finally Agreeing App Scope/Minimal Viable Product

Data security is always essential, and mobile apps can be especially exposed to security risks and challenges. All mobile devices suffer from poor physical security in terms of being easily lost or stolen, and all have to operate over potentially insecure public networks. Furthermore, when an app is intended to run on a public device, then the security of the device is an unknown, and, by default, we should assume the device is inherently insecure. This means that the points below **must be considered and addressed very early in any project to develop such a mobile app**, as they could even influence the practical viability of the app or the scope of the requirements it can securely deliver. Design the complete security profile for your app before finally agreeing the scope of the app's requirements or the minimal viable product.

### All Traffic to and from the App Must Be Encrypted

As mobile applications will usually be accessing the internet over entirely public networks **all traffic to and from the app must be encrypted**, for example via HTTPS/Transport Layer Security and/or via the use of a Virtual Private Network (VPN) and/or in-built application security wrapper. Please consult the latest security standards as to the appropriate level of encryption any such mechanisms should adopt, given the confidentiality marking of the data in question.

### If the App Needs to Access Defra Family Systems That Are Non-public, Developers and/or Application Architects Must Design the Security Profile for the App in Consultation with the Cloud Mobile Services Team in Group Infrastructure and Operations

**If your app, which will normally be operating across the public internet, needs to access Defra family systems that are non-public, developers and/or application architects must consult with the Cloud Mobile Services team in Group Infrastructure and Operations**, who will advise on what is or isn't permissible and, where permissible, what mechanisms they can provide to allow such access to be done securely. For example, Cloud Mobile Services may advise as to VPN software and VPN end-points that they can make available to mobile devices that can allow safe access into "back-end", non-public Defra family systems in the cloud or on premise.

### Also Consider the Guidance before Designing the App's Security Profile

There are other recommendations to also bear in mind, especially around the security of data on the device and authentication strategies, so you are strongly advised to also read the accompanying **[guidance](/guides/mobile_app_guidance.md)** on mobile app development alongside these standards.

Which Type of Mobile Technology to Adopt
----------------------------------------

### Decide Which Type of Mobile Technology to Adopt by Working through the Options below in the Stated Order of Preference, Stopping as Early as Possible

Mobile apps will usually be required to work on multiple devices and operating systems. For example, for apps intended for general public use, we have already stated that mobile apps created by the Defra family must work on at least the Apple and Android platforms. That alone creates a considerable development challenge, and can mean continuing high costs of ownership, especially as those platforms are rapidly changing, and some suppliers, such as Apple, impose additional constraints and demands on users of their technology stack. Add in the need for the mobile app to work readily even with no internet access, and the additional concerns mobile poses to security, and the approach adopted to deliver a mobile app needs to be chosen extremely carefully, following the standard hierarchy explained below, **starting from the top and only working your way further down the options where it is clearly necessary to do so.**

### 

#### Option 0: Pick Something "Off-The-Shelf"

This means that, **before developing an in-house app, it is even more important than for other bespoke developments to consider if a Commercial Off-The-Shelf (COTS) approach is preferred**. For example, is a suitable app already available in the app stores? Also, if the app is intended for use with an already adopted COTS suite, for example a time recording or asset management system, then is it possible that the supplier of that suite already has or will soon have a suitable app available, removing the need for us to develop our own app and then integrate that app with third party software? Then not only the development costs of the app, but also the ongoing costs of ownership, will be shared across the supplier's many customers rather than being having to be paid by us alone.

If using a third party app of any kind carefully assess whether use of that app will be appropriate given the sensitivity of the data it will be handling. In particular, many apps, especially free apps available in app stores, harvest user data, for example via Google Analytics. If those data harvesting features cannot be reliably disabled, and the data being processed by the app is in any way sensitive, then the use of such an app would be entirely inappropriate.

#### Option 1: Develop a Microsoft Power App

Microsoft Power Apps offer a low or even no code way of developing mobile apps, which can then run within a Power Apps Mobile "app player" that comes in varieties downloadable to a range of mobile platforms. This option is likely to be appropriate if the app is going to have to interact with the rest of the Microsoft technology stack in the cloud, for example Dynamics or Office365, and when the app is simpler. Due to the Microsoft licensing model, it is also currently only likely to be appropriate for internal apps. Note that Microsoft frequently revises its licensing model, so you are advised to check out the current model before proceeding to assess what is possible, the costs and what licences we may already have available.

### 

#### Option 2: Develop a Progressive Web App (PWA)

**Where a fully bespoke app is needed the next option to consider is a Progressive Web App (PWA), as recommended by the Government Digital Service here: <https://www.gov.uk/service-manual/technology/working-with-mobile-technology>**

Progressive Web Apps provide cross platform and cross device support and can be delivered just like ordinary web apps to the browser, so no engagement with an app store or Mobile Device Management (MDM) software is needed, either by ourselves or the users, and the constraints of dealing with a proprietary platform, such as Apple, are avoided (for example, Apple require all apps to be re-released with a renewed provisioning profile at least once a year). Ongoing costs of ownership, as compared with other bespoke approaches, ought to be lower. Furthermore the skills involved in developing Progressive Web Apps are more transferable and much more likely to have a longer shelf life, so time and money invested in learning will have a bigger pay-off. This approach should also make it feasible to take existing web applications, and progressively enhance them until they can become PWAs.

It is possible to build PWAs that are fully functional offline mobile apps even on less standards compliant browsers such as Apple's Safari/WebKit. For more information on this please see read the "Extra Guidance on Progressive Web Apps" section in the accompanying **[guidance](/guides/mobile_app_guidance.md)**.

#### Option 3: Build a Cross-Platform App

If, having considered above and done the recommended research, a PWA is not acceptable, the next option to consider is building the mobile app using a cross platform technology stack. These stacks are ways of using the same, or very close to the same, code-base but still building the app in ways that can allow it to run on multiple platforms and multiple devices. Otherwise a completely different code base, using a different language and development framework, is needed to build an app for each platform.

There are many such cross platform technology stacks, but some are obscure or are nearing obsolescence. This is still a too broad and fast moving area for us to as yet mandate solid standards, so you are therefore strongly advised to read the accompanying Mobile Application Guidance before considering a technology stack for developing cross platform apps (**[guidance](/guides/mobile_app_guidance.md)**).

Note that cross platform app development, where in any way feasible, **is always preferable to native app development, even when we are currently targeting only a single platform (say Apple) and range of associated devices**. That is because such apps ought to be easily adaptable to run on a different platform, for example if our selected choice of devices changes, or if we decide to make the app, or a version of the app, available on more devices. Also, investment, in terms of time, money and "hard lessons learned", in cross platform app development is more likely to be applicable across the whole range of possible future apps than if we focus on a single native app technology. Furthermore, cross platform app development techniques also provide much better insulation against all the myriad changes that happen on the underlying platform itself (not completely, but better than with pure native development).

### Don't Build Hybrid Apps

In the past one common technique used to build cross platform apps was to actually run the app inside a hidden browser on the device, with such apps often being called "hybrid" apps. However, that is not the approach adopted by any of latest and more popular frameworks, and it is increasingly challenged by ever stricter adoption of "single origin" security restrictions in more modern browser engines. A mobile app rendering local content automatically uses up one "origin", to be precise, before it even starts to interact with any \"remote\" systems, plus single origin restrictions disallow delivering up local content via AJAX calls. Therefore, such frameworks including Apache Cordova, the closely related PhoneGap (which is Adobe's own Cordova variant) and Cordova-based Ionic (though Ionic also now has a React based version) must now be regarded as legacy and **not used for new projects**. It is still just about possible to work around such restrictions using the above frameworks, but the approaches then become painful and convoluted, for example Cordova-based Ionic does so by using a local web server built into the app. **Avoid these "hybrid" approaches for building a cross-platform app within a browser.**

Of course, PWAs are also mobile apps that run within the browser, but with PWAs we are working "with the grain" of industry standards, that are becoming ever more capable all the time, where-as proprietary frameworks tend to eventually be allowed to fall behind browser standards, and then become gradually but inexorably less capable over time. For example, PWAs offer industry standards such as the indexedDB API to make managing and accessing local content much more straightforward than in any of the old "hybrid" app technologies. Also, because they are based on open W3C standards, knowledge gained building PWAs is likely to be useful for much longer and be more transferable.

### Don't Build Native Apps

Given all the alternative approaches, and the significant disadvantages of developing purely native apps, we do not currently anticipate any need to ever build native apps. Should this ever appear to be necessary, it will need to be managed as an exception to this standard.

Extra Considerations for Testing Mobile Apps
--------------------------------------------

### Mobile Apps Must Be Tested on a Representative Range of Platforms and Devices

**Mobile Apps must be tested on a representative range of platforms and devices.** That range of platforms and devices will obviously depend on the intended use of the app: for example, it can include the Apple platform and associated devices for an internal app, but for an app intended for use beyond the Defra family will include at least both the Apple and Android platforms and associated devices.

### Clearly State the Specific Operating System Versions and Device Types on Which the App Will Be "Officially Supported"

**At all times clearly state the specific operating system versions and device types on which the app will be tested, and where it is therefore "officially supported". This list will change constantly as operating systems and devices are updated.**

Appropriate tools should be adopted to facilitate this. For example, if using a full functional IDE such as Xcode or Android Studio, make extensive use of the device simulators.

However, no simulator is entirely perfect, and, once the mobile app has gone live, you will also be faced with the need to keep it tested and running despite rapid operating system updates (for example, for iPad OS these occur roughly monthly). It is therefore also strongly recommended that you acquire, and refresh as needed, a range of suitable devices for use in developing and then supporting the app.

### For Apps Running on Defra Managed Devices, Test the App on the Currently Latest Defra Adopted Version of iOS/iPad OS and the Currently Latest Public Version of iOS/iPad OS

**If the app is to be deployed on Defra managed devices it must be tested on the currently latest Defra adopted version of iOS/iPad OS and the currently latest public version of iOS/iPad OS** (most of the time these versions will be the same, but there is normally a slight delay between Apple releasing a new version of iOS/iPad OS and Defra adoption, to ensure that no business critical apps have been negatively affected).

### Test Public Apps on the Appropriate Versions of iOS/iPad OS and Android

**If the app is intended for use outside Defra, then it must be tested on the versions of iOS/iPad OS stated above, plus it should also be tested on the previous public version, at least. It must also be tested on the latest version of Android and should also be tested on the previous version, at least.**

### Use Beta Programmes to Test Apps on Emerging Versions of iOS/iPad OS or Android

**Device/s must also be enrolled in any beta programmes and used to test emerging versions of iOS/iPad OS or Android, so that we have advance warning of any upcoming issues.**

Distributing and Managing Apps
------------------------------

### Choose the Mechanism/s to Distribute the App and App Updates to End User Devices before Development Starts

**App delivery is impossible without a mechanism for distributing the app and continuing app updates to end user devices. It is therefore best to assess the app distribution options early in the project, in order to understand any implications for the project as quickly as possible, and to best ensure that testing during development can be done on a realistic basis.**

For progressive web apps this task is straight-forward: merely requiring the end user to navigate to the app's URL in a browser.

Distribution of Android apps is very open. Android apps can be distributed via app stores, such as Google Play or the Amazon app store, via your own website or even sent via emails. Android apps could also, of course, be distributed internally via Defra Mobile Device Management software, currently AirWatch, but, as mobile applications intended for internal use must run on Apple devices, attempting to distribute Android apps this way would currently be pointless, as such apps cannot run on the mandated Apple devices.

Distribution of Apple apps is, however, outside of distributions for purely development and testing purposes, very closed. Apple expect such apps to be distributed via the Apple app store, with the exception of apps that as an organisation intends to be used purely internally. Such internal apps can also, or instead, be distributed internally via an organisation's Mobile Device Management software (so in our case AirWatch) provided the organisation has purchased an Enterprise licence via the Apple Developer Enterprise Programme.

The Environment Agency is signed up to the Apple Developer Enterprise Programme, at least at the time of writing, May 2020, and can therefore distribute apps through the shared Defra family Mobile Device Management (MDM) software (i.e. AirWatch). As of the same date (May 2020) core Defra and the other parts of the Defra family are NOT signed up to the Apple Developer Enterprise Programme, meaning that they are contractually not meant to deploy their apps internally via our shared AirWatch. However, the costs of signing up are low, in the order of hundreds of pounds a year. **If you want to sign up another part of Defra to the Apple Enterprise Programme, first seek the advice of the Cloud Mobile Services team.**

### Internal Apps That Can Be Managed by an Internal Mobile Device Management Solution Must Be so Managed (at Least in Production)

Deploying an app intended for internal use via our MDM (currently AirWatch a.k.a. VMWare Workspace One) has many advantages in terms of app management and monitoring, such as, for example, controlling which user groups receive the app, allowing those groups to receive the app automatically or forcing the app to always use a provided VPN when connecting to specific URLs (this approach is called "per app" or "in-app" VPN). **Production distribution of internally developed apps intended purely for internal use, meaning use within the Defra family on managed devices, that can technically be managed via our MDM solution (so, for example, this standard cannot apply to PWAs) must therefore be via the Defra Mobile Device Management system, currently AirWatch. Note the unavoidable implication of this rule: this means that internal apps developed for use by any part of Defra other than the Environment Agency will require an Apple Developer Enterprise Programme membership to be arranged for the part of Defra that needs to use the app.**

**The advantages of having apps, which we are using officially internally, managed via an MDM means that it will often (but not always) be desirable to also deploy third party apps via the same mechanism, in other words use our MDM (currently AirWatch a.k.a. VMWare Workspace One) to also manage these third party apps (in addition to apps we have developed internally).** Note, however, that as organisations are contractually only meant to use an MDM to distribute production apps to themselves, and then only when they have an Apple Developer Enterprise Programme licence, third party apps cannot be directly deployed to our MDM. Instead such apps must first be deployed to the app store. MDMs (including our current AirWatch set-up) then integrate via an Apple provided service called the Apple Business Manager **(<https://www.apple.com/uk/business/it/>** ) to the Apple app store, and are then able to manage apps pulled out of the app store and include them in the MDM's own application catalogues. (In AirWatch such apps can be managed in a very similar way to our own apps, such as being rolled out automatically to certain groups of users, or being forced to use a VPN).

We may also want a third party supplier to make, for example, an app developed or customised for our specific use available to us privately, rather than via the public part of the app store. Though, at the time of writing (May 2020), we have never used this facility, Apple have a service, called "App Store Connect", that is meant to allow private deployment from the Apple app store to a client's own MDM (<https://developer.apple.com/business/distribute/>).

### No Standards Are Mandated for the Distribution of External Apps, but There Are Technical and Licensing Restrictions to Be Aware of on the Apple Platform

The above covers how we should manage apps for our own internal use (which, because of our standards about mobile devices, can currently only be Apple apps). We may also want to distribute apps externally.

Publication of a public app to a well-known app store will often be desirable, for example to make the app more easily discoverable. However, bear in mind that distributing via an app store requires the app store providers to "accept" an app into their store and thus creates an extra "hurdle" to jump.

**Therefore, no standards are mandated about how we should externally distribute the Android versions of internally developed apps.**

**Unfortunately, though, Apple versions of internally developed apps can (and must) ONLY be externally distributed via the Apple app store.** It is technically possible to externally distribute an Apple app signed with an Enterprise licence by mechanisms other than the app store but, though this will work, Apple tend to regard it as a violation of licence terms and may summarily revoke the provisioning profile of the offending app, causing the app to immediately stop working.
