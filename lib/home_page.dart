import 'dart:math';

import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedGender =0, _height=170, _age=23, _weight=65;
  double _bmi=0;
  String _bmiStatus() {
    if (_bmi < 18.5) {
      return "Underweight";
    } else if (_bmi < 24.9) {
      return "Normal weight";
    } else if (_bmi < 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }



  //for color

  Color _getStatusColor() {
    if (_bmi < 18.5) {
      return Colors.yellow;     // Underweight: yellow background
    } else if (_bmi < 24.9) {
      return Colors.green;      // Normal weight: green background
    } else if (_bmi < 29.9) {
      return Colors.orange;     // Overweight: orange background
    } else {
      return Colors.red;        // Obesity: red background
    }
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        title: const Text("BMI Calculator"),
      ),
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: _buildUI(),
      ),
      floatingActionButton:FloatingActionButton(
          onPressed: (){
            setState(() {
              _bmi=_weight/pow(_height/100,2);

            });
          } ,
        child: const Icon(Icons.calculate,
        ),

      ) ,

    );
  }

  Widget _buildUI(){


    return Column(
      children: [
        _genderSelector(),
        _heightInput(),
        _weightAndAgeInputRow(),
        _bmiResult(),
        _bmiStatusContainer(),



      ],
    );

  }
  Widget _genderSelector(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15,)
      ),
      margin: const EdgeInsets.all(10.2,),
      padding:  const EdgeInsets.symmetric(vertical: 10.2,),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                iconSize: 60,

                  onPressed: (){
                  setState(() {
                    _selectedGender=0;

                  });

                  },
                  icon:Icon(
                Icons.male,color: _selectedGender==0 ? Theme.of(context).colorScheme.primary:Colors.blue,
              )
              ),
              const Text("Male",style: TextStyle(fontSize: 25,),)
            ],
          ),
          Column(
            children: [
              IconButton(
                  iconSize: 60,

                  onPressed: (){
                    setState(() {
                      _selectedGender=1;

                    });

                  },
                  icon:Icon(
                    Icons.female,color: _selectedGender==1 ? Theme.of(context).colorScheme.primary:Colors.blue,
                  )
              ),
              const Text("Female",style: TextStyle(fontSize: 25,),)
            ],
          )
        ],
      ),
    );

  }
  Widget _heightInput(){
    return Container(
        decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primaryContainer,
    borderRadius: BorderRadius.circular(15,)
    ),
    margin: const EdgeInsets.all(10.2,),
    padding: EdgeInsets.symmetric(vertical: 10.2,
    ),
    child:Column(
      children: [
        const Text("Height",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
        Slider(
          min: 0,
          max: 400,
          divisions:300 ,
          value: _height.toDouble(),
            onChanged: (value) {
              setState(() {
                _height=value.toInt();
              },
              );
            },
            ),
        Text("$_height cm",
        style: const TextStyle(
          fontSize: 20,

        ),)

      ],
    )) ;

  }

  Widget      _weightAndAgeInputRow(){
    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceEvenly,


      children: [
        Expanded(child:  _weightInput()),
        Expanded(child: _ageInput()),

      ],
    );
  }
  Widget _weightInput(){
    return Container(
        decoration: BoxDecoration(
        color:Theme.of(context).colorScheme.primaryContainer,
    borderRadius: BorderRadius.circular(15,)
    ),
    margin: const EdgeInsets.all(10.2,),
    padding: EdgeInsets.symmetric(
      vertical: 12.2,
      horizontal: 12.0,
    ),
    child:Column(
      children: [
        const Text(
          "Weight",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        ItemCount(
          buttonSizeHeight: 25,
            buttonSizeWidth: 38,
            initialValue: _weight,
            minValue: 50,
            maxValue: 350,
            onChanged:(value){
            setState(() {
          _weight=value.toInt();
        });
            } ,
            decimalPlaces: 0)

      ],
    ),
    );
  }

  Widget _ageInput(){
    return Container(
      decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15,)
      ),
      margin: const EdgeInsets.all(10.2,),
      padding: EdgeInsets.symmetric(
        vertical: 10.2,
        horizontal: 10.0,
      ),
      child:Column(
        children: [
          const Text(
            "Age",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          ItemCount(
              buttonSizeHeight: 25,
              buttonSizeWidth: 38,
              initialValue: _age,
              minValue: 1,
              maxValue: 100,
              onChanged:(value){
                setState(() {
                  _age=value.toInt();
                });
              } ,
              decimalPlaces: 0)

        ],
      ),
    );
  }
  Widget _bmiResult() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10.2),
      padding: const EdgeInsets.symmetric(
        vertical: 10.2,
        horizontal: 10.0,
      ),
      child: Text(
        "BMI: ${_bmi.toStringAsFixed(2)}", // Display the numeric BMI result
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }






  // Separate container to display BMI status
  Widget _bmiStatusContainer() {
    return Container(
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10.2),
      padding: const EdgeInsets.symmetric(
        vertical: 10.2,
        horizontal: 10.0,
      ),


      child: Text(
        _bmiStatus(), // Call _bmiStatus function to get the status message based on BMI
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}


