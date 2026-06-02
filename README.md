# COKIQ Consent Banner GTM Template

This repository contains the Google Tag Manager Community Template Gallery source for **COKIQ Consent Banner**.

COKIQ helps websites load a cookie consent banner and record visitor consent choices. This GTM template loads the COKIQ site script through Google Tag Manager using a configured COKIQ site key.

## Template Type

Tag template.

## Fields

- `siteKey`: the site key copied from the COKIQ dashboard.
- `baseUrl`: the COKIQ script host. Keep the default `https://cokiq.com` unless using a dedicated COKIQ host.

## Permissions

The template requests:

- `inject_script` for `https://cokiq.com/api/s/*`
- debug-only logging

## Install

1. In Google Tag Manager, open **Templates**.
2. Click **Search Gallery** after the template is approved, or import `template.tpl` manually before gallery approval.
3. Create a new tag from **COKIQ Consent Banner**.
4. Paste the COKIQ site key.
5. Trigger on all pages.
6. Use GTM Preview to confirm the COKIQ script loads once per page.

## Verification

- GTM Preview shows the COKIQ tag firing.
- Browser network requests include `https://cokiq.com/api/s/{siteKey}`.
- Consent choices appear in the COKIQ dashboard for the configured website.

## Support

- Website: https://cokiq.com
- Documentation: https://cokiq.com/docs
- Support: https://cokiq.com/support
