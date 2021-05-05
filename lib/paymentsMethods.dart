import 'package:flutter/material.dart';
import 'package:food_home/OrderNow.dart';
import 'package:page_transition/page_transition.dart';
import 'constants.dart';

class PaymentsMethods extends StatefulWidget {
  final name, phone, address,email, message, listGet, finalTotal;
  PaymentsMethods(this.name, this.phone, this.address,this.email, this.message,
      [this.listGet, this.finalTotal]);
  @override
  _PaymentsMethodsState createState() => _PaymentsMethodsState();
}

class _PaymentsMethodsState extends State<PaymentsMethods> {
  @override
  Widget build(BuildContext context) {
      var size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Review",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: redTheme,
        elevation: 0.0,

        actions: [
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("${widget.listGet[1].length}",),
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [                                     
                                      
                                      Row(
                                        children: [
                                          Text("Name : \t\t\t\t\t\t\t\t\t\t\t\t",style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.bold),),
                                          Text(widget.name,style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Number  : \t\t\t\t\t\t",style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.bold),),
                                          Text(widget.phone,style: TextStyle(fontSize: 17)),
                                        ],
                                      ),
                                          Row(
                                        children: [
                                          Text("Email  : \t\t\t\t\t\t\t\t\t\t\t\t",style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.bold),),
                                          Expanded(child: Text(widget.email,style: TextStyle(fontSize: 17))),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Address : \t\t\t\t\t\t\t\t",style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.bold),),
                                          Expanded(child: Text("${widget.address}\n",style: TextStyle(fontSize: 17))),
                                        ],
                                      ),

                                      Table(
                                        border: TableBorder.all(
                                            color: Colors.grey[400], style: BorderStyle.solid, width: 1),
                                        children: [
                                          TableRow(
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('Items', style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
                                                  ),
                                                ],
                                              ),
                                               Column(
                                                children: [
                                                   Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('Quantities', style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
                                                  ),
                                                ],
                                              ),
                                               Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('Unit Price', style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          for(int i =0 ; i< widget.listGet[1].length ; i++)
                                          TableRow(
                                            children: [
                                              
                                               Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('${widget.listGet[1][i]}', style: TextStyle(fontSize: 12.0)),
                                                  ),
                                                ],
                                              ),
                                               Column(

                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('${widget.listGet[3][i]}', style: TextStyle(fontSize: 14.0),),
                                                  ),
                                                ],
                                              ),
                                               Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('${widget.listGet[2][i]}', style: TextStyle(fontSize: 14.0)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),                 
                                        ],
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                          children: [
                                            Text("Total : \t\t\t\t\t",style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,color: Colors.orange),),
                                            Text("${(widget.finalTotal == null) ? widget.listGet[2][0] : widget.finalTotal}/-",style: TextStyle(fontSize: 25,color: Colors.orange)),
                                          ],
                                        ),
                                    ),


                                                                        SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                            Text(
                                        "* \t\t\tNow only",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                        Text(
                                        " CASH on DELIVERY",
                                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                                      ),
                                        
                                        Text(
                                        " available  ",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                        ],
                                      ),

                                       SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                        children: [
                                          // Row(
                                          //   children: [
                                                Text(
                                            "* \t\t\tYou can pay your bill via cash on delivery or \n",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                            Text(
                                            "* \t\t\t\tjazzcash/easypaisa us on 03214031364 \n",
                                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                                          ),
                                            
                                            Text(
                                            "* \t\t\t\tDesi Food Items Can Take 2-3 Hours.",
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    SizedBox(height: 20,),
                                      Container(
                                        width: size.width,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                          MaterialButton(onPressed: (){
                                            Navigator.pop(context);
                                          },child:Text("Back"),color: Colors.grey[300],),
                                          SizedBox(width: 5,),
                                          MaterialButton(onPressed: (){


                                            Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: OrderNowButtons(
                                                  widget.name,
                                                  widget.phone,
                                                  widget.address,
                                                  widget.email,
                                                  widget.message,
                                                  widget.listGet,
                                                  widget.finalTotal),
                                            ),
                                          );
                                          },child:Text("Continue",style: TextStyle(color: Colors.white),),color: redTheme,),
                                          ],
                                        ),
                                      ),


                                    ],
                                ),
                              ),
              ),
      ),
    );
  }
}
