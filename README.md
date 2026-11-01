# COKIQ Consent Banner – Google Tag Manager template

Google Tag Manager Community Template Gallery source for **COKIQ Consent Banner**, the consent management platform (CMP) by COKIQ (Hostao L.L.C.). Website: https://cokiq.com

## What the tag does

1. **Consent Mode v2 defaults** with `setDefaultConsentState` for `ad_storage`, `analytics_storage`, `ad_user_data` and `ad_personalization` (plus `functionality_storage`, `personalization_storage`, `security_storage`), customisable **by region**: all regions, EEA + UK + Switzerland, or your own ISO 3166-1/3166-2 list, with a separate default for all other regions. Supports `wait_for_update`, `ads_data_redaction` and `url_passthrough` (`gtagSet`).
2. **Loads the COKIQ banner** (`https://cokiq.com/api/s/{siteKey}`).
3. **Consent Mode updates** with `updateConsentState`: the stored choice of a returning visitor (`Cokiq.getConsent`) and every later choice or change (`Cokiq.addConsentListener`). COKIQ categories map to Google consent types as: marketing → ad_storage, ad_user_data, ad_personalization; analytics → analytics_storage; preferences → functionality_storage, personalization_storage; security_storage is always granted.

## Install

1. In Google Tag Manager open **Templates > Tag Templates > Search Gallery** and add **COKIQ Consent Banner** (or import `template.tpl`).
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
- `write_data_layer`: `ads_data_redaction`, `url_passthrough`
- `access_globals`: write `__cokiqConsentModeDefaultsReady` (so the COKIQ script does not send a second default); execute `Cokiq.getConsent` and `Cokiq.addConsentListener`
- `inject_script`: `https://cokiq.com/api/s/*`
- `logging`: debug only

## Tests

The template contains 7 unit tests (Tests tab in the template editor): regional defaults, all regions, custom regions, returning visitor update, listener update, script failure and missing site key.

## Docs and support

- Docs: https://cokiq.com/docs/google-consent-mode-basic-vs-advanced · https://cokiq.com/docs/google-consent-mode-settings · https://cokiq.com/docs/regional-banner · https://cokiq.com/docs/debug-mode
- Bugs and questions: open a GitHub issue in this repository or email support@cokiq.com (contact COKIQ first for Consent Mode issues).

## License

Apache License 2.0 – see [LICENSE](LICENSE).
