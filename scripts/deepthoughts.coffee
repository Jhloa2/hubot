# Description
#   <description of the scripts functionality>
#
# Dependencies:
#   
#
# Configuration:
#   
#
# Commands:
#   hubot deep - gets deep thought
#  
#   
#
# Author:
#   jhloa2


# Configures the plugin
module.exports = (robot) ->
    # waits for the string "hubot deep" to occur
    robot.respond /deep/i, (msg) ->
        # Configures the url of a remote server
        msg.http('http://andymatthews.net/code/deepthoughts/get.cfm')
            # and makes an http get call
            .get() (error, response, body) ->
                # passes back the complete reponse
                msg.send JSON.parse( body ).message
