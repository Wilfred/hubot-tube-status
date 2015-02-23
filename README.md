# hubot-tube-status

[![Build Status](https://travis-ci.org/Wilfred/hubot-tube-status.svg?branch=master)](https://travis-ci.org/Wilfred/hubot-tube-status)

Get the tube status from transport for london (TFL) using the TfL
Open Data API.

See [`src/tube-status.coffee`](src/tube-status.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-tube-status --save`

Then add **hubot-tube-status** to your `external-scripts.json`:

```json
["hubot-tube-status"]
```

## Sample Interaction

```
user> hubot tube status
Hubot> District: Part closure from Aldgate East to Upminster.
Hammersmith and City: Part closure from Liverpool Street to Barking.
Overground: Part closure from Clapham Junction to Kensington (Olympia), Gospel Oak to Stratford, Highbury & Islington to Shadwell and Sydenham to Crystal Palace.
Waterloo and City: Train service resumes at 0615 on Monday.
```

## Changelog

### v0.1.1

Initial release.
