module.exports = {
  defaultBrowser: "Firefox",
  handlers: [
    {
      // Open finopsys urls in Safari
      match: [
        "finopsys.squiz.net",
        "finopsys.squiz.net/*",
      ],
      browser: "Safari"
    },
    {
      // Open meet.google.com urls in Google Chrome
      match: [
        "meet.google.com", // Google hangouts
        "meet.google.com/*",
      ],
      browser: "Google Chrome"
    }
  ]
};
