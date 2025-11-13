import 'package:flutter/material.dart'; 

 

void main() { 

  runApp( 
    MaterialApp( 
      debugShowCheckedModeBanner: false, 
      home: Scaffold( 
        backgroundColor: Colors.grey[300], 
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.yellow,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    color: Colors.blue,
                  ),
                ),
                Container(
                  width: 100,
                  height: 50,
                  color: Colors.yellow,
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 25,
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    flex: 75,
                    child: Container(
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ), 

      ), 

    ), 

  ); 

} 