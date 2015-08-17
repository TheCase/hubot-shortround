# Description:
#   Short Round movie quotes from "Indiana Jones and the Temple of Doom"
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot shortround help - Display a random Short Round quote
#   hubot shortround me - Display a random Short Round quote
#   hubot shortround bomb X - Display X random Short Round quote
#   hubot shortround selfie - Display random Short Round image
#   hubot shortround how many - Display total number of quotes
#
# Author:
#   TheCase

shortrounds = [
  "Diamonds? Diamonds!",
  "Dr. Jones! No more parachutes!",
  "Haha! Very funny! Haha! All wet!",
  "Hang on, lady. We going for a ride.",
  "He no nuts. He crazy!",
  "Hey! You cheat, Dr. Jones! You cheat!",
  "Hey, Dr. Jones, no time for love! We've got company!",
  "Hey, lady! You call him Dr. Jones!",
  "I keep telling you, you listen to me more, you live longer!",
  "I step on something. Feels like I step on fortune cookies.",
  "I very little, you cheat very big!",
  "Indy!!!! Cover your heart!!!!!",
  "Indy, I love you! Wake up, Indy! Wake up!",
  "It wasn't me. It's her!",
  "Maybe he like OLDER women!",
  "No Indy! The left tunnel! The left! Indy!",
  "Okey dokey, Dr. Jones. Hold on to your potatoes!",
  "Strong bridge! Strong wood! Aaarrghhhh!!!",
  "Tell me later what happen.",
  "That's no cookie!",
  "They crash the plane to make you come here?",
  "Three aces! I win! Two more games, I have all your money! Ha, ha, ha!",
  "Very funny! Very funny! ...Uh oh!",
  "What is Sankara?",
  "Wow! Holy Smoke! Crash landing!",
  "You call him Doctor Jones, doll!",
  "You make me poor! No fun! Playing with you no fun!",
  "You say to stand against the wall. Not my fault. Not my fault!"
]

module.exports = (robot) ->

  robot.respond /shortround help/i, (msg) ->
    msg.send """
displays Short Round quotes from \"Indiana Jones and the Temple of Doom\"
--
shortround help     - this help
shortround me       - display one movie quote
shortround bomb <x> - display x movie quotes, optional (default: 5)
shortround selfie - display random google image search 
shortround how many  - display quote count 
"""

  robot.respond /shortround me/i, (msg) ->
    msg.send msg.random shortrounds

  robot.respond /shortround bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for x in [0...count] by 1
      msg.send msg.random shortrounds 

  robot.respond /shortround how many/i, (msg) ->
    msg.send "There are #{shortrounds.length} shortround quotes."

  robot.respond /shortround selfie/i, (msg) ->
    ImageMe msg, 'Short Round', (url) ->
      msg.send url

  ImageMe = (msg, query, cb) ->
    q = v: '1.0', rsz: '8', q: query, safe: 'active'
    msg.http('https://ajax.googleapis.com/ajax/services/search/images')
      .query(q)
      .get() (err, res, body) ->
        if err
          msg.send "Encountered an error :( #{err}"
          return
        if res.statusCode isnt 200
          msg.send "Bad HTTP response :( #{res.statusCode}"
          return
        images = JSON.parse(body)
        images = images.responseData?.results
        if images?.length > 0
          image = msg.random images
          cb ensureImageExtension image.unescapedUrl

ensureImageExtension = (url) ->
  ext = url.split('.').pop()
  if /(png|jpe?g|gif)/i.test(ext)
    url
  else
    "#{url}#.png"
                   
