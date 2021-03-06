import telebot, asyncdispatch, logging, options
from strutils import strip

var L = newConsoleLogger(fmtStr="$levelname, [$time] ")
addHandler(L)

const API_KEY = slurp("secret.key").strip()

proc updateHandler(b: Telebot, u: Update): Future[bool] {.async.} =
  if not u.message:
    return true
  var response = u.message.get
  if response.text:
    let text = response.text.get
    discard await b.sendMessage(response.chat.id, text, parseMode = "markdown", disableNotification = true, replyToMessageId = response.messageId)

proc greatingHandler(b: Telebot, c: Command): Future[bool] {.async.} =
  discard b.sendMessage(c.message.chat.id, "hello " & c.message.fromUser.get().firstname, disableNotification = true, replyToMessageId = c.message.messageId)
  result = true

when isMainModule:
  let bot = newTeleBot(API_KEY)

  bot.onUpdate(updateHandler)
  bot.onCommand("hello", greatingHandler)
  bot.poll(timeout=300)
