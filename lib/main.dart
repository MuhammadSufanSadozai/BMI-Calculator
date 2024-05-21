import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  String result = "";
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  String selectedGender = ""; // Variable to track selected gender

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'BMI CALCULATOR',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [Icon(Icons.settings)],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = "Male";
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selectedGender == "Male"
                                ? Colors.blue
                                : Colors.white, // Update color based on selection
                            border: Border.all(
                              color: Colors.blue, // Add a border for visibility
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Male',
                              style: TextStyle(
                                color: selectedGender == "Male"
                                    ? Colors.white
                                    : Colors.blue, // Update text color based on selection
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = "Female";
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: selectedGender == "Female"
                                ? Colors.pink
                                : Colors.white, // Update color based on selection
                            border: Border.all(
                              color: Colors.pink, // Add a border for visibility
                              width: 2.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Female',
                              style: TextStyle(
                                color: selectedGender == "Female"
                                    ? Colors.white
                                    : Colors.pink, // Update text color based on selection
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        'Your Height in Cm',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Your Height in Cm',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        'Your Weight in Kg',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Your weight in kg',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      double? height = double.tryParse(heightController.value.text);
                      double? weight = double.tryParse(weightController.value.text);

                      if (height != null && weight != null) {
                        height = height / 100; // Convert cm to meters
                        result = calculateBMI(height, weight, selectedGender);
                      } else {
                        result = "Invalid input";
                      }
                      print(result);
                    });
                  },
                  child: Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your BMI is : $result',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String calculateBMI(double height, double weight, String gender) {
    double finalResult = weight / (height * height);
    // Adjust BMI for females by a factor (example: subtracting 1 as an arbitrary adjustment)
    if (gender == "Female") {
      finalResult = finalResult - 1;
    }
    String bmi = finalResult.toStringAsFixed(2);
    return bmi;
  }
}