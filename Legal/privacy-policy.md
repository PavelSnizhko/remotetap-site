# Privacy Policy

**Last Updated: October, 2026**

## Overview

This privacy policy explains how Remote Tap collects, stores, and processes data across its iOS, macOS, and Windows applications.

## I. Data Collection and Processing

**Contact Data**
We collect names and email addresses when users communicate directly with us to respond to inquiries.

**Correspondence Data**
Information provided through support requests, emails, and feedback about our apps helps us address user issues and improve our offerings.

**Analytics Data**
The iOS app uses Firebase Analytics (provided by Google) to understand how users interact with the app. This includes usage events such as button presses, screen views, and tab selections. Firebase may collect an app instance identifier, app usage data, and approximate location derived from IP address. No personally identifiable information is collected through analytics. Analytics data is not linked to your identity. The macOS and Windows companion apps do not use any cloud-based analytics or telemetry. You can learn more about Google's data practices at https://policies.google.com/privacy.

**Payment Data**
We do not collect payment instrument details. Transactions occur through Apple's App Store or the Microsoft Store without direct access to financial information.

**Local Network Data**
Remote Tap uses local network access to discover and communicate with companion apps on the same Wi-Fi network. This communication happens entirely on your local network using TLS encryption. No local network data is transmitted to external servers.

**Device Pairing Data**
When an iPhone connects to the macOS or Windows companion app for the first time, the companion app requires explicit user approval before accepting commands. Device identifiers (device name, device ID, and certificate fingerprint) are stored locally on the companion device to remember trusted pairings. This data never leaves your local devices.

**Software Updates (macOS)**
The macOS app periodically checks remotetap.app for available updates via a standard HTTPS request. No personal information is sent — only a normal HTTP request is made to download the update feed. System profiling is disabled; no hardware or OS details are collected through this mechanism.

## II. Screen Capture and Subtitle Recognition

Remote Tap includes a subtitle capture feature that allows the iPhone app to request the macOS or Windows companion app to read on-screen subtitles using optical character recognition (OCR).

**How it works:**
- The iPhone sends a capture request to the companion app over your local network.
- The companion app captures a screenshot of a portion of the active window, processes it with on-device OCR (Apple Vision framework on macOS, Windows.Media.Ocr on Windows), and extracts text that appears to be subtitles.
- Only the recognized text is sent back to the iPhone over the encrypted local connection. The screenshot itself is never saved to disk, never transmitted over the network, and never sent to any external server.

**Privacy safeguards:**
- All OCR processing happens entirely on your Mac or PC — no cloud services are involved.
- Screenshots are held in memory only for the duration of processing and then discarded.
- The subtitle capture feature is off by default and must be explicitly enabled by the user on the companion app.
- On macOS, the system requires you to grant Screen Recording permission before any capture can occur.
- DRM-protected content (e.g., Netflix) may appear as a black frame; the app detects this and reports that the player blocks screen capture.
- Captured subtitle text is never included in analytics events — only success/failure outcomes are logged on the iOS app.

## III. Platform-Specific Permissions

**iOS**
Camera access (for scanning a QR code to connect to your Mac or PC) and local network access (for device discovery via Bonjour).

**macOS**
Local network access (for receiving commands from the iPhone) and Screen Recording permission (required for the subtitle capture feature). The Screen Recording permission is managed through System Settings and can be revoked at any time.

**Windows**
No special system permissions are required. Screen capture uses standard Windows APIs available to all desktop applications. The in-app subtitle capture toggle is the user-facing control for this feature.

## IV. Data Retention

Personal data is retained according to legal requirements, regulatory obligations, and the purposes for which it was collected. Analytics data is retained according to Google Firebase's default retention policies. Captured subtitle text is ephemeral and is not stored persistently on any device.

## V. Data Sharing

Data may be shared with:
- Google (Firebase Analytics) for app usage analytics on iOS only
- Regulators or law enforcement when legally required

No screen capture data, recognized text, or subtitle content is ever shared with third parties.

## VI. Third-Party Services

The iOS app uses Firebase Analytics, a service provided by Google. Firebase is subject to Google's privacy policy. The macOS and Windows companion apps do not use any third-party analytics or data services. This privacy policy does not apply to third-party services, and we are not responsible for their practices.

## VII. Analytics Opt-Out

You can opt out of analytics data collection by disabling the analytics toggle in the iOS app's Settings screen. When analytics is disabled, no usage events are sent to Firebase.

## VIII. Security

We implement appropriate technical and organizational measures to protect data, including:
- TLS encryption for all communication between devices on your local network
- Device pairing approval to prevent unauthorized access
- On-device-only processing for screen capture and OCR

We will notify users of suspected breaches.

## IX. User Rights

Users can:
- Access their personal data
- Request corrections to inaccurate information
- Request erasure where appropriate
- Receive data in structured formats
- Object to or restrict processing
- Withdraw consent at any time
- Revoke Screen Recording permission on macOS or disable the subtitle capture toggle on Windows at any time

To exercise any of these rights, contact us at pavel.snizhko.2000@gmail.com.

## X. Children's Privacy

Our apps are not intended for children (under the age of 13 or such higher age as required by applicable law). We do not knowingly collect children's data and will remove such information if discovered.

## XI. Contact

If you have questions about this privacy policy or your data, contact us at pavel.snizhko.2000@gmail.com.

## XII. Policy Changes

Updates will be posted on this page and communicated via email when appropriate.
