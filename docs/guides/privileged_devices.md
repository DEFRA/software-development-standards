# Using Devices with Privileged Access

A guide for everyone that has privileged access to their corporate devices - often referred to as "developer laptops".

### What is this about?
This guide is about the appropriate steps you should take when using devices where you have been granted privileged access, bypassing the normal organisational IT controls.

This includes:

- local admin access, such as with MakeMeAdmin
- exemption from network controls, such as specialist Zscaler profiles

This privileged access is provided so that you can work effectively, but requires you to apply extra care to ensure you work safely and securely.

This guide provides guidance on safe practice and includes some advice on setting up some of the tools you might need to use.

### Does it apply to you?
Most people are issued with devices have been pre-configured with the organisation's standard IT controls in place.

For some people, however, these standard devices are too restricted and prevent us from performing our duties.

In these cases, your manager will have arranged for you to be given additional, privileged access to your device.

If you do not know whether or not you are in this group, ask your manager.

### Can I use my own device?
We do not allow people to use their own devices for official work.

### What if I am a supplier and not part of the Defra group?
Your company with have contractual arrangements with Defra or one of its associated organisations regarding the use of equipment and tooling.
If Defra have provided you with equipment, then this guidance applies to you when using that equipment.

## Your responsibilities
This list is a brief outline of some of the key considerations you should have in mind when using the privileged access on your device.

#### Be aware of your responsibilities
Familiarise yourself with Defra's information handling responsibilities, acceptable use policies and code of conduct for the use of IT and digital resources.

We need to be especially mindful of these as the standard IT security controls often help us to comply with them without us even realising it.

#### Understand the security posture
Read the [NCSC Device Security Guidance](https://www.ncsc.gov.uk/collection/device-security-guidance) to understand the controls that are in place on managed devices, why they are there and how your privileged access relates to them.

This should give you a clear view of the areas where you need to pay extra attention to security.

In particular, you should read the section titled [Permit only trusted software](https://www.ncsc.gov.uk/collection/device-security-guidance/security-principles/permit-only-trusted-software) as your privileged access is intended to loosen this restriction.

If you have any questions then speak to your manager.

#### Ensure that your device stays patched and up to date
The organisation will push regular patches and updates to your device according to the standard patching schedule. You should normally apply these immediately.

The only exception to this is where you need to maintain older versions of software to do compatibility testing. In this case, you should update as soon as possible.

#### Ensure that you are using official online resources
One of the main reasons for privileged access is to be able to make use of online resources.
However, this freedom of access can also be a threat that may cause devices to be compromised or leak official information.

For this reason, only officially approved online resources should be accessed from unmanaged devices.

In reality, any resource that you access for legitimate work is likely to be "officially approved", but you are responsible for all of your online activity and will be accountable for any incidents resulting from inappropriate access.

If you are not sure whether an online resource is considered to be officially approved then speak to your manager.

#### Ensure you comply with licensing and usage requirements
Your privileged access allows you to download and install software that is necessary for your work.

You will need to carefully check the licensing arrangements for this software, in particular whether the licence covers commercial, business or public sector use.

If you need to pay for a licence to use a piece of software, speak to your manager.

#### Ensure that you only install software that doesn't introduce a security risk
Before installing and using software, you should be aware of any data that the software stores or any potential it may have for information exposure.

Privileged access does not circumvent device or firewall malware scanning, you should not attempt deactivate this. All downloaded software will be scanned and quarantined or blocked if deemed a risk.

If you have any concerns about any software, speak to your manager before installing it.

#### Use public networks securely
You will need to be more careful than usual whenever you are connecting to public networks as the privileged access you have can represent a higher information security risk should your communications be intercepted.
In particular, the captive portals typically found in cafes and hotels that require a username and password may not provide secure end-to-end encryption.

Whenever you are connecting to a public network, you must ensure that you first evaluate whether it is safe to do so.

#### Backup and secure your data
Privileged access allows us to install our own tooling. One consequence of this is that we inevitably store more data locally.

You must ensure that any unique content you create is backed up to secure, corporate repositories such as OneDrive or SharePoint.

You should also consider backing up some of your local settings and data, which could help if your device fails and needs to be fixed or replaced.

Keys and other credentials that you might hold in local configuration files can be held securely in our Defra Bitwarden organisation.

## Setup guidance
The following sections will help you getting set up with some of the tools you are likely to use when you have privileged access.

### Windows Subsystem for Linux
If you are undertaking development, testing or prototyping activities, you are likely to benefit from being able to build and test in a Linux environment.

The recommended approach to this if you have a Windows machine is to use the [Windows Subsystem for Linux](https://learn.microsoft.com/en-us/windows/wsl/) (WSL).

You should ensure that you are using Windows 11 in order to get the best experience and install WSL2 rather than WSL1.

Follow the below Microsoft guide to install the distro of your choice. The Ubuntu distro is recommended as it is the default distro for WSL and is widely used, including deployment across Defra. This means that there are plenty of resources that can help with any WSL or Linux-related issues. Also, Ubuntu is one of the easiest distros to work with as it it is well-maintained and well-supported by tool and utility makers.

[Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install)

Within the guide there is also a [recommended setup](https://docs.microsoft.com/en-us/windows/wsl/setup/environment#set-up-your-linux-user-info) of a development environment using WSL.

This guide should also be followed as it includes setup of Docker Desktop, Git, Windows Terminal and VS Code.

#### Windows file permissions
You will mostly work with files in your WSL distro's filesystem, but you may occasionally need to work with files in the Windows filesystem from within WSL.

In this case, you may need to allow WSL to modify the Windows file permissions - to do this, the drives need to be mounted with the metadata option.

1. Create or edit a WSL config file by entering the below terminal command.

    ```
    sudo nano /etc/wsl.conf
    ```

1. Add the following content to the file, then save and exit.

    ```
    [automount]
    options = "metadata"
    ```

1. Restart WSL for changes to take effect.

#### Proxy
You will need to configure WSL to work around the Zscaler proxy to avoid network conflicts.

This can be configured in the **WSL Settings** app. Open the WSL Settings app and set the networking mode to `Mirrored` with `Auto proxy enabled` set to `false`. Restart WSL for changes to take effect.

#### Zscaler
Install the Zscaler root certificate into the WSL trust store so that TLS inspection does not break package managers and other tools running inside WSL.

**1. Export the Zscaler root certificate from Windows**

1. Press `Win + R` and run `certmgr.msc`.
1. Navigate to **Trusted Root Certification Authorities → Certificates**.
1. Find the Zscaler certificate (often named `Zscaler Root CA`, `Zscaler Intermediate Root CA`, or a company-specific name).
1. Right-click → **All Tasks → Export**.
1. Choose **Base-64 encoded X.509 (.CER)** and save it somewhere accessible, for example:

    ```
    C:\Users\YOURNAME\Downloads\zscaler-root.cer
    ```

**2. Copy the certificate into WSL**

Inside WSL, run:

```
cp /mnt/c/Users/YOURNAME/Downloads/zscaler-root.cer ~/
```

**3. Install into the Ubuntu/Debian trust store**

1. Rename the file to `.crt`:

    ```
    mv ~/zscaler-root.cer ~/zscaler-root.crt
    ```

1. Copy it into the CA certificates directory:

    ```
    sudo cp ~/zscaler-root.crt /usr/local/share/ca-certificates/
    ```

1. Update the certificate store:

    ```
    sudo update-ca-certificates
    ```

    You should see output similar to:

    ```
    1 added, 0 removed
    ```

**4. Verify**

Test that TLS is working:

```
curl https://example.com
```

If the connection succeeds without certificate errors, your certificate is installed correctly.

##### Node.js

Node.js does not use the system certificate store by default. Add the following to your `~/.bashrc` (or `~/.zshrc` if using Zsh):

```
export NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/zscaler-root.crt
```

Reload your shell or run `source ~/.bashrc` (or `source ~/.zshrc`) to apply the change.

#### Quick links
- [Setup Docker Desktop](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-containers)
- [Setup Git](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-git)
- [Setup Visual Studio Code](https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-vscode)
- [Setup Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/get-started)

### Docker Desktop
You can use the [Docker Engine](https://docs.docker.com/engine/) freely on MacOS or inside WSL, but many people appreciate the convenience of using [Docker Desktop](https://docs.docker.com/desktop/) especially on Windows.

You can install Docker Desktop from the Docker Web site:

1. Download the [Docker Desktop installer](https://www.docker.com/products/docker-desktop) for your operating system.

1. Run the installer and follow the prompts to install Docker Desktop.
    - If you are using WSL ensure that `Use WSL 2 instead of Hyper-V (recommended)` is ticked during installation

1. You will need to configure Docker Desktop to work around the proxy to avoid network conflicts. This can be done by right clicking the Docker Desktop icon in the system tray and selecting `Settings`. From there, select `Resources`, `Proxies` and ensure that `Manual proxy configuration` is checked.

If you are running WSL:

1. Check that Docker Desktop is set to use the WSL2 backend. This can be done by right-clicking the Docker Desktop icon in the system tray and selecting `Settings`. From there, select `General` and ensure `Use the WSL 2 based engine` is checked.

1. Ensure that Docker Desktop is available to your WSL distro. This can be done by right-clicking the Docker Desktop icon in the system tray and selecting `Settings`. From there, select `Resources`, `WSL Integration` and ensure that the distro you are using is checked.

Defra has a Docker organisation that you should join to ensure that you are licensed for your use of Docker Desktop.

### Visual Studio Code
A lot of developers use VS Code, setup instructions can be found at [https://code.visualstudio.com/docs/setup/setup-overview](https://code.visualstudio.com/docs/setup/setup-overview)

You may find some extensions face issues with the proxy when attempting authentication - in this case set the `http.proxySupport` setting to `off` instead of the default `override`
