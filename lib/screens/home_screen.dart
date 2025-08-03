import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherApiService();
  String city = 'Buenos Aires';
  String country = '';
  Map<String,dynamic> currentValue = {};
  List<dynamic> hourly = [];
  List<dynamic> day = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void>_fetchWeather() async{
    setState(() {
      isLoading = true;
    });
    try {
      final forecast = await _weatherService.getHourlyForecast(city); 
      setState(() {
        currentValue = forecast['current'] ?? {};
        hourly = forecast['forecast']?['forecastday']?[0]?['hour'] ?? [];
        day = forecast['forecast']?['forecastday']?[0]?['day'] ?? [];
        city = forecast['location']?['name'] ?? city;
        country = forecast['location']?['country'] ?? '';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        currentValue = {};
        hourly = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'City not found or invalid. Please enter a valid city name'
            )
          )
      );
    }
  }
  String formateTime(String timeString){
    DateTime time = DateTime.parse(timeString);
    return DateFormat.j().format(time);
  }
  @override
  Widget build(BuildContext context) {
    
    String iconPath = currentValue['condition']?['icon']??'';
    String imageUrl = iconPath.isNotEmpty? "https:$iconPath":"";
    Widget imageWidgets = imageUrl.isNotEmpty
    ? Image.network(imageUrl, height: 200, width: 200, fit: BoxFit.cover)
    : SizedBox();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea( 
          top: false,
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/1.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isLoading)
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: CircularProgressIndicator()
                        )
                      )
                    else...[
                      if(currentValue.isNotEmpty)
                      SizedBox(height: MediaQuery.of(context).size.height*0.08),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.1,
                        child: TextField(
                          onSubmitted: (value) {
                            if(value.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Please enter a city name.'
                                    )
                                  )
                              );
                              return;
                            }
                            city = value.trim();
                            _fetchWeather();
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for a location',
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                              fontSize: 18,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(120),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary.withAlpha(120),
                                width: 2.5
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary.withAlpha(120),
                                width: 2.5
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.primary.withAlpha(50),
                          ),
                        ),
                      ),
                        InkWell(
                          onTap: () {
                            
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Ink(
                            height: MediaQuery.of(context).size.height*.4,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    '$city${country.isNotEmpty ? ', $country': ''}',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontFamily: 'Poppins'
                                    ),
                                  ),
                                  Text(
                                    '${currentValue['temp_c']}°C',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'
                                    ),
                                  ),
                                  Text(
                                    '${currentValue['condition']['text']}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'
                                    ),
                                  ),
                                  imageWidgets,
                                  
                                ],
                              ),
                            ),
                              
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withAlpha(40),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [BoxShadow(
                              color: Theme.of(context).colorScheme.primary.withAlpha(60),
                              offset: Offset(1, 1),
                              blurRadius: 10,
                              spreadRadius: 1
                            )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/humidity.png', width: 30, height: 30,),
                                    Text(
                                      '${currentValue['humidity']}%',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'
                                      ),
                                    ),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/wind.png', width: 30, height: 30,),
                                    Text(
                                      '${currentValue['wind_kph']} kph',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'
                                      ),
                                    ),
                                    Text(
                                      'Wind',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/temp.png', width: 30, height: 30,),
                                    Text(
                                      hourly.isNotEmpty
                                        ? '${hourly.map((h) => h['temp_c']).reduce((a, b) => a>b?a:b)}°C'
                                        : 'N/A',
                                        style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'
                                      ),
                                    ),
                                    Text(
                                      'Max. temp.',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ), 
                    ] 
                  ],
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}