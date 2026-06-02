___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cokiq_consent_banner",
  "version": 1,
  "securityGroups": [],
  "displayName": "COKIQ Consent Banner",
  "categories": ["TAG_MANAGEMENT", "UTILITY"],
  "brand": {
    "id": "cokiq",
    "displayName": "COKIQ"
  },
  "description": "Loads the COKIQ consent banner on all pages."
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "siteKey",
    "displayName": "COKIQ site key",
    "simpleValueType": true,
    "valueHint": "Paste the site key from COKIQ"
  },
  {
    "type": "TEXT",
    "name": "baseUrl",
    "displayName": "COKIQ base URL",
    "simpleValueType": true,
    "defaultValue": "https://cokiq.com"
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const encodeUriComponent = require('encodeUriComponent');
const logToConsole = require('logToConsole');

const siteKey = data.siteKey;
const baseUrl = (data.baseUrl || 'https://cokiq.com').replace(/\/$/, '');

if (!siteKey) {
  logToConsole('COKIQ: site key is required.');
  data.gtmOnFailure();
} else {
  injectScript(
    baseUrl + '/api/s/' + encodeUriComponent(siteKey),
    data.gtmOnSuccess,
    data.gtmOnFailure,
    'cokiq-consent-' + siteKey
  );
}

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
    "clientAnnotations": {
      "isEditedByUser": true
    }
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
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "debug"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    }
  }
]
