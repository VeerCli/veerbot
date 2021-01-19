
local function get_weather(location)
  location = location:gsub(" ","+")
  print("Finding weather in "..location)
  local urlw = "http://api.openweathermap.org/data/2.5/weather?q="..location.."&units=metric&appid=bd82977b86bf27fb59a04b61b657fb6f"

  local url, res = http.request(urlw)
  if res == 200 then
  local weather = JSON.decode(url)
  print("\nweather : "..JSON.encode(weather))
  local city = weather.name
  local country = weather.sys.country
  local temp = 'The temperature in '..city
    ..' (' ..country..')'
    ..' is '..weather.main.temp..'°C'
  local conditions = 'Current conditions are: '
    .. weather.weather[1].description

  if weather.weather[1].main == 'Clear' then
    conditions = conditions .. ' ☀'
  elseif weather.weather[1].main == 'Clouds' then
    conditions = conditions .. ' ☁☁'
  elseif weather.weather[1].main == 'Rain' then
    conditions = conditions .. ' ☔'
  elseif weather.weather[1].main == 'Thunderstorm' then
    conditions = conditions .. ' ☔☔☔☔'
  end
  return temp .. '\n' .. conditions
else
  print("Error")
  return "Error"
end
end

local function weather(msg, MsgText)
  if MsgText[1] == '!weather' then
  if not MsgText[2] then
  sendMsg(msg.chat_id_,msg.id_,"!weather (city)")
    else
  sendMsg(msg.chat_id_,msg.id_,get_weather(MsgText[2]))
  end
  end
  return false
end

return {
Veer = {
"^(!weather)$",
"^(!weather) (.*)$",
 },
 iVeer = weather,
 }
 
