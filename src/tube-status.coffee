# Description
#   Get the tube status from transport for london (TFL)
#
# Commands:
#   hubot tube status - report the current TfL service status

parser = require 'xml2json'
_ = require 'underscore'

# Convert ['foo', 'bar', 'baz'] to 'foo, bar and baz'
joinWithAnd = (arr) ->
  switch arr.length
    when 0 then ""
    when 1 then arr[0]
    when 2 then "#{arr[0]} and #{arr[1]}"
    else
      "#{_.initial(arr).join(", ")} and #{_.last(arr)}"

# Convert 'foo Bar' to 'Foo bar'
capitalize = (str) ->
  str.charAt(0).toUpperCase() + str.substring(1).toLowerCase()
      
formatDisruptions = (disruptions) ->
  getDescription = (disruption) -> disruption.Status.Description

  result = ""
  for description, stations of _.groupBy(disruptions, getDescription)
    stationPairs = ("#{s.StationFrom.Name} to #{s.StationTo.Name}" for s in stations)
    result = result + "#{capitalize(description)} from #{joinWithAnd(stationPairs)}. "

  result.trim()

formatSummary = (summary) ->
  linesWithDelays = {}
  for lineStatus in summary.ArrayOfLineStatus.LineStatus
    name = lineStatus.Line.Name
    status = lineStatus.Status.Description
    disruptions = lineStatus.BranchDisruptions?.BranchDisruption

    if not _.isEmpty(disruptions)
      # If there's a single disruption, we don't have an array.
      if _.isArray(disruptions)
        linesWithDelays[name] = formatDisruptions disruptions
      else
        linesWithDelays[name] = formatDisruptions [disruptions]

    else if status != 'Good Service'
      # line is probably closed
      linesWithDelays[name] = lineStatus.StatusDetails

  if _.isEmpty(linesWithDelays)
    return "It all looks good at the moment!"

  printableLines =
    for line in _.keys(linesWithDelays).sort()
      "#{line}: #{linesWithDelays[line]}"

  printableLines.join("\n")

module.exports = (robot) ->
  robot.respond /tube status/i, (msg) ->
    msg.http("http://cloud.tfl.gov.uk/TrackerNet/LineStatus/IncidentsOnly")
    .get() (err, res, body) ->
      msg.send formatSummary parser.toJson(body, {object: true})
