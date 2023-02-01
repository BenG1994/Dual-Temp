# Dual-Temp 

![120](https://user-images.githubusercontent.com/113778995/215928717-c126f83f-9c99-48eb-a547-82b17f5feaf1.png)

Dual Temp is a weather app that displays current weather data in both Celsius and Fahrenheit at the same time. Users can also switch between metric and imperial units for other data presented.

## Introduction

Dual Temp was created out a very specific need. As a United States citizen, I'm familiar with using Fahrenheit for temperature. But I moved to Europe for a good portion of 2022, where Celsius is the standard unit of measurement. I got comfortable with understanding Celsius and what was warm and cold, but comparing the two units with people back home still required some math (or conversion). So I decided to create an app that would display both at the same time and eliminate the need to calculate the other units or use another app to convert them.

## Skills used

* Swift 5
* Parse JSON
* OpenWeatherMap API (for both Fahrenheit and Celsius temperatures)
* FlagKit 2.4.0 - Swift Package
* CoreLocation
* Autolayout
* Saving users location and current temperatures
* Supporting light and dark modes

## Uniqueness

While I could've made a simple weather app that shows the two temperatures like I had originally envisioned, I decided to go further and add some user experience features other weather apps of this scale wouldn't have. Because it was meant to cater to international appeal with different units (Celsius/Fahrenheit, metric/imperial), I decided to add some more international features. The first was to add the flag of the country the weather for the searched, or present, city was located in. That required the use of a Swift Package to add all the flags (although two were missing and had to be added after the fact). The JSON data from the weather API included country codes, so I was able to link those with the flags from the package. 

I also changed the text color based on the current temperature, just to give a more visual representation on if the location is freezing or you're going to boil a bit. A changing icon displays the weather condition as well, such as clouds, rain, or snow. The icon changes in several of the stats in the lower half of the view as well.

The other thing I decided to add was local times. I added the time zone of the current or searched city based on GMT. The JSON also gave me basic time zone data in +/- time from GMT in minutes. So I was able to format and convert those times into the location's time zone. I was able to use JSON data to convert unix timestamps to give the sunrise and sunset in the local time of the searched city. In addition, I also added the current local time. For example, if you searched Tokyo, the app would show the Japanese flag, along with the time of GMT +0900 (9 hours) along with the local time below.

Below is a screenshot of how the app works, using Tromsø, Norway as an example. Notice that iOS automatically detects special characters, even if you typed just Tromso.

<img src="https://user-images.githubusercontent.com/113778995/215925630-6d9ec1e4-ff66-4f7a-a0b8-3da99c401472.jpg" width="200">

## Challenges

With Dual Temp being my first app, there were several challenges. Most came with formatting the time zone and current local time. Finding out that several flags were missing from the Swift Package also created a need to append and add to an existing Package, which I found to be quite easy. Another weird quirk of the API was that through the search bar, it didn't recognize cities with two names. So San Francisco, New York, or Los Angeles wouldn't work. But looking at the API URL, I noticed that two name cities were not separated with a space, but a "+" instead, so I was able to replace any spaces that a user would type in the search bar with a "+" and everything worked correctly.

But the most difficult problem that ended up affecting the layout and the usability of the app was the fact that some cities that you'd search for defaulted to different countries. Being a tennis fan in January, I wanted to search for Melbourne, Australia, but instead found the it showed me Melbourne, Florida instead. Same thing with Rome. It didn't show me Italy, as one would expect, but Rome, Georgia in the United States. So again using the country codes, I noticed that you were able to add the country code in after the city to get the specific country you desired: Melbourne, AU; Rome, IT. The problem: how many people know country codes other than their own? So I added a second view that gives a list of every single country code just in case a city pops in a country they don't expect.

<img src="https://user-images.githubusercontent.com/113778995/215926500-474bdb88-73ce-4256-8406-58aff381d1bf.jpg" width="200">

## Reflection

For a first app, this was a perfect choice and it allowed me to practice, learn, and troubleshoot through many problems that I hadn't anticipated or thought I would need to learn in order to complete the project. But also, it's an app I use myself everyday. Which I think is the most important thing, to be able to create an app that is usable and valuable to the user.

In the future, I would like to create a widget that displays the current weather information, along with rewriting the entire app to a different and more robust weather API, possibly Apple's WeatherKit. I would also think it would be a good addition to create an accompanying Apple Watch app and complications as well.

