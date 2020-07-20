# Using Unmanaged Devices

A guide for everyone that needs to use unmanaged devices.

### What is this about?
This guide is about the appropriate steps you should take when using devices that are not managed by the normal
organisational IT controls.

Primarily that means developer's laptops.

### Does it apply to you?
Most people are issued with devices have been pre-configured with the organisation's standard IT controls in place.

For some people, however, these standard devices are too restricted and prevent us from performing our duties.

In these cases, you will have been issued with an _unmanaged_ device.

#### How do I know if my device is unmanaged?
You will have been issued with the device by your line manager and informed that it is an unmanaged device.

If you have a device and you do not know whether it is managed or unmanaged then ask your line manager.

#### What if it is my own device?
We do not allow people to use their own devices for official work. Please don't do it.

> This includes personal smartphones chatting on [Slack](https://slack.com), personal tablets used to
> [appear.in](https://appear.in/), etc.  Seriously, please don't.

One day we might have thought through the policy for official data on privately-owned equipment sufficiently to make
this happen, but we're not there yet.

#### How do I know if this guidance applies for my device?
This guidance applies for _all_ unmanaged devices.

### Who can you talk to about this?
If you have any questions then please contact your line manager.

For suggestions feel free to create an Issue or raise a PR with your suggested changes.

### What is different for unmanaged devices?
The main difference is that **you must apply all the necessary security controls to the device yourself**.

If you are not comfortable with the full set of responsibilities outlined in this guide then speak to your line manager.
It may be best to return the unmanaged device and replace it with a managed device.

### What are the security controls you need to apply?
The precise controls that you need to apply will vary depending on the type of device that you have and how you need
to use it.

However, there are some common controls that you must apply in all cases and these are described first.

### Common controls
These controls must be applied whatever type of unmanaged device you use.

#### Be aware of your responsibilities
Familiarise yourself with your organisation's information handling responsibilities, acceptable use policies and code
of conduct for the use of IT and digital resources.

We need to be especially mindful of these as the standard IT security controls often help us to comply with them
without us even realising it.

#### Understand the security principles
Read the [CESG End User Devices Security Guidance](https://www.ncsc.gov.uk/guidance/end-user-device-security), in
particular the [Security Principles](https://www.ncsc.gov.uk/guidance/end-user-devices-security-principles).

This should give you a good understanding of the kind of controls that are required and why they are necessary.

If you have any questions then speak to your line manager.

#### Ensure your device is registered on the appropriate inventory
Your line manager must have a record of your device and it must be recorded in a shared inventory.  In most cases, the
device itself will also have an asset identifier on it, usually in the form of a sticker.

This ensures that we can keep track of the device and prevent it becoming lost when people move roles.  It also allows
to audit equipment for security compliance.

#### Keep your device patched and up to date
Whatever device you are using, you will not be receiving updates distributed by your organisation so you will need to
apply these yourself.

You should normally apply all patches and updates immediately.
The only exception to this is where you need to maintain older versions of software to do compatibility testing.

#### Ensure that you are using official online resources
One of the main reasons for having unmanaged devices is to be able to make use of online resources.
However, this freedom of access can also be a threat that may cause devices to be compromised or leak official
information.

For this reason, only officially approved online resources should be accessed from unmanaged devices.

In reality, any resource that you access for legitimate work is likely to be "offically approved", but you are
responsible for all of your online activity and will be accountable for any incidents resulting from inappropriate
access.

If you are not sure whether an online resource is considered to be officially approved then speak to your line manager.

#### Do not compromise the organisation's corporate network
Under normal circumstances you must never connect your device to the organisation's internal corporate network.

However, for some work it may be appropriate to use the device on the corporate network and when this has been
officially approved then you must ensure that the network is not compromised.

#### Keep the device physically secure
Unmanaged devices are generally portable and often highly valuable, so you must take appropriate steps to keep the
device physically secure.

In particular, you should:
 - keep the device hidden whenever it is being transported or stored
 - ensure the device is stored in a secure, locked location
 - ensure the device is adequately protected from damage at all times

Cases, bags or other containers can be provided by your line manager.

#### Use the device safely
Unmanaged devices often have different physical characteristics than standard-issue equipment.

You must make sure that you complete an assessment of how to use the device in a way that does not cause strain or
long-term injury.

Some specific areas to look out for are:
 - screen size, graphics resolution and text size may not be optimal in the default configuration
 - on-screen or built-in keyboards, touchpads or trackpads are often not suitable for long periods of use
 - default operating system or software configuration can often not be suitable for long periods of use
 - devices may not have the necessary connectivity options for external equipment

Additional equipment or guidance can be provided by your line manager.

#### Backup and secure data
Using unmanaged devices often requires the creation of data outside of our secure, corporate repositories.

You must ensure that any unique content you create is backed up to alternative persistent storage in accordance with
the information management procedures that apply.

Additional equipment such as encrypted hard drives or online services such as OneDrive can be provided by your
line manager.

#### Returning devices
When you return your device, you must ensure that it has been treated to remove all official information and is
ready to be used by someone else.

This usually just means performing a factory reset, although in some cases additional steps may be required.
You must ensure that there are no online accounts linked to the device, such as Microsoft or Apple IDs.

### Controls for Windows laptops

#### Don't set a BIOS password
BIOS passwords don't add any greater security to the device and primarily only help to prevent accidental
mis-configuration.

Setting such passwords can make it more difficult to reuse the device so do not set a BIOS password.

#### Use the latest stable desktop operating system
The device is likely to come with a suitable version of Windows 10 pre-installed, but if not then you should ensure
that Windows 10 Professional or Enterprise is installed on it, but do not remove any existing recovery partition.

Guidance on this can be provided by your line manager.

You must ensure that the device has the latest stable version.

Do not use server versions or different operating systems, e.g. any Linux distribution.

If you need to work with a different operating system then you must use a virtualisation technology,
or you could consider using the Windows Subsystem for Linux.

#### Keep the operating system and applications patched and up to date
Windows 10 quality updates must be applied automatically and not paused.

Feature updates to new versions should be applied as soon as they are available for your device, but may be
deferred for a month or two if you have specific software compatibility issues.

#### User accounts
Your device should be supplied relatively factory-fresh, without existing user accounts.

You need to create a local device account for yourself, not linked to a Microsoft account, to use as a local
administrator account.
You should use your corporate network username for this account so that it can be unambiguously identified.

Secure this account with a password.

#### Disc encryption
You must activate BitLocker disc encryption on your device, with a minimum 8-digit PIN.

You must supply the recovery key and disc identifier to your line manager so they can keep a record of them.

#### Virtualisation
Most development work should be undertaken in a dedicated virtual machine as this helps to protect the integrity of
the host device.

Commercial virtualisation software can be provided by your line manager if required.

#### Corporate resources access
Whilst most corporate resources sit inside entirely private networks, it is possible for some of our online
services to be accessed from an unmanaged device.
To do this, additional controls can be applied to the device.

To allow your device to access the corporate Office 365 services, you will need to enrol it with InTune.
This facility can be requested through your line manager.

If you enrol your device, you will need to use your corporate account, which will become registered as a new account
on the device in addition to the local account you have already created.
You will need to secure this account with a PIN.

#### Cloud development environment access (VPN)
Dedicated development environments and services can be accessed via VPN.
You should install the VPN client on your device according to instructions provided by the operations team.

VPN client connections should be made from the host device, not from virtual machines.

### Controls for Macbooks

#### Don't set a firmware password
Firmware passwords offer minimal additional protection and are easily lost or forgotten, which can only be fixed by
an authorised Apple representative.

#### Use the latest general release operating system version
It can sometimes take a while for application vendors to support new macOS versions and there's no going back, so you
can allow yourself a month or two before moving to the latest macOS operating system.
But you should upgrade as soon as it is safe to do so.

If you have a device that will not support the latest version of the operating system then you should talk to your
line manager to arrange an alternative.

You must not install any other operating system such as Windows or a Linux distribution.

If you need to work with a different operating system then you must use a virtualisation technology.

#### Keep the operating system and applications patched and up to date
You must ensure that your device is configured to automatically check for updates and you should regularly install
macOS and app updates so that you are using current features.

Most importantly, you must ensure that your device is configured to automatically install system data files and
security updates, which only covers the built-in anti-malware software and its configuration.

#### User accounts
Your device should be supplied relatively factory-fresh, without existing user accounts.

You need to create a local device account for yourself to use as a local administrator account.
You should use your corporate network username for this account so that it can be unambiguously identified.

Secure this account with a password.

You will also need to create an Apple ID registered to your corporate email address if you don't already have one.
This account can be used for the App Store and can be linked to your work iPhone if you have one, which is useful
for enabling two-factor authentication.

However, you should not use this account to synchronise content across devices.

#### Disc encryption
You must enable FileVault on the disc of your device and create a local recovery key.
Do **not** use your iCloud account or store the recovery key with Apple.

You must supply the recovery key and disc identifier to your line manager so they can keep a record of them.

#### Virtualisation
Most development work will be done in the native operating system, but you may also wish to create virtual
machines.

#### Corporate resources access
Whilst most corporate resources sit inside entirely private networks, it is possible for some of our online
services to be accessed from an unmanaged device.
To do this, additional controls can be applied to the device.

To allow your device to access the corporate Office 365 services, you will need to enrol it with InTune.
This facility can be requested through your line manager.

#### Cloud development environment access (VPN)
Dedicated development environments and services can be accessed via VPN.
You should install the VPN client on your device according to instructions provided by the operations team.
