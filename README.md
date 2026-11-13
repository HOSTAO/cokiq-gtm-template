<p align="center">
  <a href="https://cokiq.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset=".github/assets/cokiq-logo-white.svg">
      <img src=".github/assets/cokiq-logo.svg" alt="COKIQ" width="300">
    </picture>
  </a>
</p>

# COKIQ Consent Banner – Google Tag Manager template

Google Tag Manager Community Template Gallery source for **COKIQ Consent Banner**, the consent management platform (CMP) by COKIQ (Hostao L.L.C.). Website: https://cokiq.com

## What the tag does

1. **Consent Mode v2 defaults** with `setDefaultConsentState` for `ad_storage`, `analytics_storage`, `ad_user_data` and `ad_personalization` (plus `functionality_storage`, `personalization_storage`, `security_storage`), customisable **by region**: all regions, EEA + UK + Switzerland, or your own ISO 3166-1/3166-2 list, with a separate default for all other regions. Supports `wait_for_update`, `ads_data_redaction` and `url_passthrough` (`gtagSet`).
2. **Loads the COKIQ banner** (`https://cokiq.com/api/s/{siteKey}`).
3. **Google CMP developer ID**: sets COKIQ's Google CMP developer ID (`developer_id.dZjc5MD`) once per page before the defaults, so Google can identify the consent platform.
4. **Returning visitors**: reads the visitor's stored COKIQ choice from the first-party `cokiq` cookie and applies it with `updateConsentState` straight away on Consent Initialization, before any other tag fires and without waiting for the banner script (expired choices are ignored).
5. **Consent Mode updates** with `updateConsentState`: every later choice, change or withdrawal (`Cokiq.addConsentListener`). COKIQ categories map to Google consent types as: marketing → ad_storage, ad_user_data, ad_personalization; analytics → analytics_storage; preferences → functionality_storage, personalization_storage; security_storage is always granted.

## Install

1. Download [`template.tpl`](template.tpl), then in Google Tag Manager open **Templates > Tag Templates > New > ⋮ > Import**. (The Community Template Gallery listing is under Google review; once it is live you can add **COKIQ Consent Banner** from **Search Gallery** instead.)
2. Create a tag from the template, paste your **COKIQ site key** (dashboard > Sites) and choose the regions (use the same setting as "Where to show the banner" in COKIQ).
3. Trigger: **Consent Initialization - All Pages**.
4. Check in GTM **Preview** / Tag Assistant: the consent *default* appears on Consent Initialization before other tags, and an *update* after a banner choice.

## Fields

| Field | Default | Notes |
| --- | --- | --- |
| COKIQ site key | – | required |
| Regions where these defaults apply | All regions | All / EEA + UK + CH / custom list |
| ad_storage, analytics_storage, ad_user_data, ad_personalization | denied | default inside the selected regions |
| Default for all other regions | granted | only when regions are limited |
| wait_for_update (ms) | 500 | |
| ads_data_redaction | on | |
| url_passthrough | on | |

## Permissions

- `access_consent`: read/write the 7 consent types
- `get_cookies`: read the `cokiq` consent cookie (stored choice of a returning visitor)
- `write_data_layer`: `ads_data_redaction`, `url_passthrough`
- `access_globals`: write `__cokiqConsentModeDefaultsReady` (so the COKIQ script does not send a second default); execute `Cokiq.getConsent` and `Cokiq.addConsentListener`
- `inject_script`: `https://cokiq.com/api/s/*`
- `logging`: debug only

## Tests

The template contains 10 unit tests (Tests tab in the template editor): regional defaults, all regions, custom regions, returning-visitor cookie update before the script loads, expired cookie, invalid cookie, stored choice from the script, later choice and withdrawal via the listener, script failure, and missing site key (defaults still set).

## Other ways to install COKIQ

- WordPress / WooCommerce: [COKIQ on WordPress.org](https://wordpress.org/plugins/cokiq/) (Plugins > Add New > search "COKIQ")
- Any website, Shopify, WHMCS, Next.js, React and more: https://cokiq.com/integrations

## Changelog

- **v6** (2026-11-13): a returning visitor's stored choice is applied from the first-party `cokiq` cookie before other tags fire (Google's recommended consent template pattern); Consent Mode defaults are set even when the site key is missing; `queryPermission` check before loading the script; 10 unit tests.
- **v5** (2026-11-12): brand thumbnail updated to the current COKIQ logo. No code, permission or test change.
- **v4** (2026-11-02): sets the COKIQ Google CMP developer ID before the Consent Mode defaults; unit test updated.
- **v3** (2026-11-01): Consent Mode updates via updateConsentState (returning visitors and every new choice), brand thumbnail, 7 unit tests.
- **v2**: regional Consent Mode v2 defaults, ads_data_redaction, url_passthrough.
- **v1**: initial release.

## Docs and support

- Docs: https://cokiq.com/docs/google-consent-mode-basic-vs-advanced · https://cokiq.com/docs/google-consent-mode-settings · https://cokiq.com/docs/regional-banner · https://cokiq.com/docs/debug-mode
- Bugs and questions: open a GitHub issue in this repository or email support@cokiq.com (contact COKIQ first for Consent Mode issues).

## License

Apache License 2.0 – see [LICENSE](LICENSE).
