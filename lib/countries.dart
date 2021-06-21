
import 'dart:convert';

import 'package:earch1/ditalscountry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Countreis extends StatefulWidget {
String id ;
String name ; 

Countreis({@required this.id,this.name});

@override
_CountriesState createState() => _CountriesState();


}

class _CountriesState extends State<Countreis> {
Map _map;
List country;
List countries = [];
List favourite  = [];

bool hart = false;
final controller = TextEditingController();
String isExist;
Future<List> getCountry ()async {
  final String response = await rootBundle.loadString('json/data.json');
  final data = await json.decode(response);
  setState(() {
      _map = data['countries'];
      country  = _map.values.toList();
    });

  for(var i =0 ; i<country.length ; i++){
    var countryOfCon = country[i]['continent'];
    if (widget.id == countryOfCon){
      countries.add(country[i]);
    }
  } 
return countries;
}

void searchlist(value){

//for(var i =0 ; i<countries.length ; i++){
if (countries[2]["name"].contains(value.toString().trim())) {
  print("yes");
}
else{
print("false");

}


//}

 


}
@override
void initState(){
  getCountry();
  super.initState();
}

@override
Widget build(BuildContext context){
     
  return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: TextStyle(letterSpacing: 4),),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
             // onChanged: (value) => searchlist(value),
              controller: controller,
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (context, index) => Card(
                        color: Colors.orangeAccent,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: (){
 Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountriesDetails(
                                  name: countries[index]["name"],
                                  continent: countries[index]["continent"],
                                  emoji: countries[index]["emoji"],
                                  native: countries[index]["native"],
                                  phone: countries[index]["phone"],
                                  languages: countries[index]["languages"],
                                )));

                          },
                          leading: Text(countries[index]["emoji"]),
                          trailing: Icon( Icons.favorite,color: Colors.red,),
                          title: Text(countries[index]['name'],style: TextStyle(fontWeight: FontWeight.bold),),
                         // subtitle: Text(
                           //   '${_foundUsers[index]["age"].toString()} years old'),
                        ),
                      ),
                    )
                  
            ),
          ],
        ),
      ),
       floatingActionButton: FloatingActionButton(
          onPressed: () {
            for(var i =0 ; i<countries.length ; i++){
          //  if (countries[2]["name"].contains(controller.text.toString().trim())) {
            if(countries[i]["name"] ==controller.text.toString().trim() ){
           // print("yes");
                       print("found");
                       isExist = "True";

                                  //     ScaffoldMessenger.of(context).showSnackBar(_snackBar1);
                                  _showValue(context).then((value) => snackBBar(context));
            break;

            }
            else{
              print("not found");
               isExist = "False";
                                                 _showValue(context).then((value) => snackBBar(context));

            }
           
        
            }
           
          },
          child: const Icon(Icons.search),
        ),

    );  
     
}

  Future <void>_showValue(BuildContext context)async {

    print("Hello");
  }
Widget snackBBar(context){
    
   final snackBar = SnackBar(content:
    Text("Country is exist  : ${isExist}  "
        ,textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orangeAccent),)
      ,backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(30.0),
                  duration: const Duration(seconds: 5),
      
      );
      
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
//Text(countries[index]["name"],style: TextStyle(
  //                           color: Colors.green,fontSize: 15),);
