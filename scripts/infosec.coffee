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

lookup_site = "http://www.reddit.com/r/netsec/top/.json?"
env = process.env


module.exports = (robot)->
	if env.HUBOT_SENDGRID_USER and env.HUBOT_SENDGRID_KEY
		robot.hear /question: (.*)/i, (msg)->
			message = msg.match[1]
			sender = msg.message.user.name.toLowerCase()
			exec = require('child_process').exec
			data = "'to=jhloa2@gmail.com&from=infosecbot@sendgrid.com&api_user=jordan_dmarc&api_key=XcQ7s6pYJHwPKZrb9ge&subject="
			data = data.concat("#{sender} has a question!&text=") # Appends email subject
			data = data.concat("#{message}'") # Appends email body
			command = "curl -d "
			command = command.concat(data) # Appends data
			command = command.concat(" https://api.sendgrid.com/api/mail.send.json") # Appends URL to post to
			exec command, (error, stdout, stderr)->
				if error
					msg.send "Curl error!"
					return
				msg.send "Question sent to InfoSec!"
				return
	else # Bot will complain if environment variables aren't set.
		robot.hear /question: (.*)/i, (msg)->
			msg.send "Please set HUBOT_SENDGRID_KEY and HUBOT_SENDGRID_USER ENV variables!"


	robot.respond /usage/i, (msg)->
		msg.send "InfoSec Bot Usage:"
		msg.send "hubot usage - you should already know what this does :)"
		msg.send "question: <question> - emails your extremely important question to the InfoSec team."
		msg.send "hubot netsec - populates room with popular reddit netsec links."


	robot.respond /netsec/i, (msg)->
	    msg.http( lookup_site ).get() (error, response, body)->
	        list = JSON.parse(body).data.children
	        for item in list
	        	if item.data.ups > 50
	        		text = ( item.data.title || item.data.link_title ) + " - " + ( item.data.url || item.data.body ) 
	        		msg.send text




