# Description
#   Get the tube status from transport for london (TFL)
#
# Configuration:
#   HUBOT_TFL_APP_ID
#   HUBOT_TFL_APP_KEY
#
# You can get API keys at
# https://api-portal.tfl.gov.uk/
#
# Commands:
#   hubot tube status - report the current TfL service status

tflAppId = process.env.HUBOT_TFL_APP_ID
tflAppKey = process.env.HUBOT_TFL_APP_KEY

module.exports = (robot) ->
  robot.respond /tube status/, (msg) ->
    if not tflAppId
      msg.reply "Dunno. You need to set HUBOT_TFL_APP_ID for me to find out."
      return
    if not tflAppKey
      msg.reply "Dunno. You need to set HUBOT_TFL_APP_KEY for me to find out."
      return
      
    msg.reply "hello!"
