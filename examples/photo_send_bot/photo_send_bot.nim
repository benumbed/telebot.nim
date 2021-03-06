import telebot, asyncdispatch, options, logging, os


const API_KEY = slurp("../secret.key")


addHandler(newConsoleLogger(fmtStr="$levelname, [$time] "))

proc updateHandler(bot: TeleBot, e: Update): Future[bool] {.async, gcsafe.} =
  discard await bot.sendPhoto(e.message.get.chat.id, "file://" & getAppDir() & "/sample.jpg")

let bot = newTeleBot(API_KEY)

bot.onUpdate(updateHandler)
bot.poll(timeout=500)
