___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "COKIQ Consent Banner",
  "categories": [
    "TAG_MANAGEMENT",
    "UTILITY"
  ],
  "brand": {
    "id": "cokiq",
    "displayName": "COKIQ"
  },
  "description": "Sets Google Consent Mode v2 defaults (per region) and loads the COKIQ consent banner, which sends the consent update after each visitor choice. Use the Consent Initialization - All Pages trigger.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "siteKey",
    "displayName": "COKIQ site key",
    "simpleValueType": true,
    "valueHint": "cs_...",
    "help": "Copy the site key from the COKIQ dashboard (Sites).",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "defaultsGroup",
    "displayName": "Consent Mode defaults",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SELECT",
        "name": "regionRule",
        "displayName": "Regions where these defaults apply",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "all",
            "displayValue": "All regions"
          },
          {
            "value": "eea_uk_ch",
            "displayValue": "EEA, UK and Switzerland"
          },
          {
            "value": "custom",
            "displayValue": "Custom list of countries"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "all",
        "help": "Use the same choice as 'Where to show the banner' in the COKIQ dashboard. With a region list, other regions get the default below."
      },
      {
        "type": "TEXT",
        "name": "customRegions",
        "displayName": "Countries / regions (ISO 3166-2, comma separated)",
        "simpleValueType": true,
        "valueHint": "DE, FR, GB, US-CA",
        "enablingConditions": [
          {
            "paramName": "regionRule",
            "paramValue": "custom",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "ad_storage",
        "displayName": "ad_storage",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "denied",
            "displayValue": "Denied"
          },
          {
            "value": "granted",
            "displayValue": "Granted"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      },
      {
        "type": "SELECT",
        "name": "analytics_storage",
        "displayName": "analytics_storage",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "denied",
            "displayValue": "Denied"
          },
          {
            "value": "granted",
            "displayValue": "Granted"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      },
      {
        "type": "SELECT",
        "name": "ad_user_data",
        "displayName": "ad_user_data",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "denied",
            "displayValue": "Denied"
          },
          {
            "value": "granted",
            "displayValue": "Granted"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      },
      {
        "type": "SELECT",
        "name": "ad_personalization",
        "displayName": "ad_personalization",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "denied",
            "displayValue": "Denied"
          },
          {
            "value": "granted",
            "displayValue": "Granted"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "denied"
      },
      {
        "type": "SELECT",
        "name": "outsideDefault",
        "displayName": "Default for all other regions",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "granted",
            "displayValue": "Granted (no banner shown there)"
          },
          {
            "value": "denied",
            "displayValue": "Denied"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "granted",
        "enablingConditions": [
          {
            "paramName": "regionRule",
            "paramValue": "all",
            "type": "NOT_EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "waitForUpdate",
        "displayName": "wait_for_update (milliseconds)",
        "simpleValueType": true,
        "defaultValue": "500",
        "valueValidators": [
          {
            "type": "NON_NEGATIVE_NUMBER"
          }
        ]
      },
      {
        "type": "CHECKBOX",
        "name": "adsDataRedaction",
        "checkboxText": "Redact ads data when ad_storage is denied (ads_data_redaction)",
        "simpleValueType": true,
        "defaultValue": true
      },
      {
        "type": "CHECKBOX",
        "name": "urlPassthrough",
        "checkboxText": "Pass ad click information through URLs (url_passthrough)",
        "simpleValueType": true,
        "defaultValue": true
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const encodeUriComponent = require('encodeUriComponent');
const logToConsole = require('logToConsole');
const setDefaultConsentState = require('setDefaultConsentState');
const gtagSet = require('gtagSet');
const setInWindow = require('setInWindow');
const makeNumber = require('makeNumber');

const EEA_UK_CH = ['AT', 'BE', 'BG', 'HR', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', 'GR', 'HU', 'IE', 'IT', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SK', 'SI', 'ES', 'SE', 'IS', 'LI', 'NO', 'GB', 'CH'];

const siteKey = data.siteKey;
if (!siteKey) {
  logToConsole('COKIQ: site key is required.');
  data.gtmOnFailure();
  return;
}

// 1. Consent Mode defaults (before any other tag; use the Consent Initialization - All Pages trigger).
let regions = [];
if (data.regionRule === 'eea_uk_ch') regions = EEA_UK_CH;
if (data.regionRule === 'custom' && data.customRegions) {
  regions = data.customRegions.split(',').map(function (r) { return r.trim().toUpperCase(); }).filter(function (r) { return r.length > 0; });
}
if (regions.length > 0) {
  const other = data.outsideDefault === 'denied' ? 'denied' : 'granted';
  setDefaultConsentState({
    ad_storage: other,
    analytics_storage: other,
    ad_user_data: other,
    ad_personalization: other,
    functionality_storage: other,
    personalization_storage: other,
    security_storage: 'granted'
  });
}
const defaults = {
  ad_storage: data.ad_storage || 'denied',
  analytics_storage: data.analytics_storage || 'denied',
  ad_user_data: data.ad_user_data || 'denied',
  ad_personalization: data.ad_personalization || 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'granted'
};
const wait = makeNumber(data.waitForUpdate);
if (wait > 0) defaults.wait_for_update = wait;
if (regions.length > 0) defaults.region = regions;
setDefaultConsentState(defaults);
gtagSet({
  ads_data_redaction: data.adsDataRedaction !== false,
  url_passthrough: data.urlPassthrough !== false
});
// Tell the COKIQ script the defaults are set, so it does not send a second default.
setInWindow('__cokiqConsentModeDefaultsReady', true, true);

// 2. Load the COKIQ banner. It sends the consent update after every visitor choice.
injectScript(
  'https://cokiq.com/api/s/' + encodeUriComponent(siteKey),
  data.gtmOnSuccess,
  data.gtmOnFailure,
  'cokiq-consent-' + siteKey
);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cokiq.com/api/s/*"
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ads_data_redaction"
              },
              {
                "type": 1,
                "string": "url_passthrough"
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "__cokiqConsentModeDefaultsReady"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Sets regional defaults and loads COKIQ
  code: |-
    const mockData = {
      siteKey: 'cs_test',
      regionRule: 'eea_uk_ch',
      ad_storage: 'denied',
      analytics_storage: 'denied',
      ad_user_data: 'denied',
      ad_personalization: 'denied',
      outsideDefault: 'granted',
      waitForUpdate: '500',
      adsDataRedaction: true,
      urlPassthrough: true
    };
    mock('injectScript', function(url, onSuccess) { onSuccess(); });
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalled();
    assertApi('gtagSet').wasCalled();
    assertApi('injectScript').wasCalledWith('https://cokiq.com/api/s/cs_test', success, failure, 'cokiq-consent-cs_test');
    assertApi('gtmOnSuccess').wasCalled();
- name: Fails without site key
  code: |-
    runCode({ siteKey: '', regionRule: 'all' });
    assertApi('gtmOnFailure').wasCalled();
    assertApi('injectScript').wasNotCalled();


___NOTES___

Created on 01/11/2026. Consent Mode defaults with regions added.
