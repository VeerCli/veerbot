
local function get_weather(location)
  location = location:gsub(" ","+")
  print("Finding weather in "..location)
  local urlw = "http://api.openweathermap.org/data/2.5/weather?q="..location.."&units=metric&appid=bd82977b86bf27fb59a04b61b657fb6f"

  local url, res = http.request(urlw)
print("\nurl : "..url.."\nres : "..res)
  if res ~= 200 then return "Error" end
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
end

local function weather(msg, MsgText)
  if MsgText[1] == '!weather' then
  if not MsgText[2] then
    get_weather = "!weather (city)"
    else
  local get_weather = get_weather(MsgText[2])
  if not get_weather then
    get_weather = "Can't get weather from that city."
  end
  end
  end
  return sendMsg(msg.chat_id_,msg.id_,get_weather)
end

return {
Veer = {
"^(!weather)$",
"^(!weather) (.*)$",
 },
 iVeer = weather,
 }
 
