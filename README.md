# COKIQ Consent Banner GTM Template

Google Tag Manager Community Template Gallery source for **COKIQ Consent Banner** (COKIQ by Hostao L.L.C.).

The tag:

1. sets the Google Consent Mode v2 **default** command for ad_storage, analytics_storage, ad_user_data and ad_personalization (plus functionality_storage, personalization_storage, security_storage), customisable **by region** (all regions, EEA + UK + Switzerland, or your own ISO 3166-2 list, with a separate default for other regions), with wait_for_update, ads_data_redaction and url_passthrough;
2. loads the COKIQ banner script (`https://cokiq.com/api/s/{siteKey}`), which sends the Consent Mode **update** command after every visitor choice and sets the COKIQ Google developer ID.

## Fields

- `siteKey`: the site key from the COKIQ dashboard.
- Consent Mode defaults: regions, the four consent types, the default for other regions, wait_for_update, ads_data_redaction, url_passthrough.

## Permissions

- `access_consent` (write defaults for the 7 consent types)
- `write_data_layer` for `ads_data_redaction` and `url_passthrough` (gtag set)
- `access_globals` write `__cokiqConsentModeDefaultsReady` (so the COKIQ script does not send a second default)
- `inject_script` for `https://cokiq.com/api/s/*`
- debug-only logging

## Install

1. In Google Tag Manager open **Templates > Search Gallery** (or import `template.tpl`).
2. Create a tag from **COKIQ Consent Banner**, paste the site key, choose the regions (same as "Where to show the banner" in COKIQ).
3. Trigger: **Consent Initialization - All Pages**.
4. Check in GTM Preview / Tag Assistant: the consent default appears before other tags, and an update after a banner choice.

## Docs and support

- Docs: https://cokiq.com/docs/google-consent-mode-basic-vs-advanced , https://cokiq.com/docs/regional-banner , https://cokiq.com/docs/debug-mode
- Support (contact COKIQ first for Consent Mode issues, not Google): support@cokiq.com
