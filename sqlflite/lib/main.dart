import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlflite/providers/cart_provider.dart';
import 'di_container.dart' as di;
import 'models/cart.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<CartProvider>()),
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    Provider.of<CartProvider>(context,listen: false).addCart(new Cart(id: DateTime.now().millisecond,name: "Cart Name",price: 100));
  }

  @override
  void initState() {
    super.initState();

    Provider.of<CartProvider>(context,listen: false).getAllCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Consumer<CartProvider>(
        builder: (_,cartProvider,child) => SafeArea(
            child: CustomScrollView(
              slivers: [
                (cartProvider.cartList.isEmpty) ?
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text("No Cart Item Found!"),
                      ),
                    ):
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.all(15),
                        child: Container(
                          color: Colors.blue[100 * (index % 9 + 1)],
                          height: 300,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "${cartProvider.cartList[index].name}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Price= ${cartProvider.cartList[index].price}",
                                style: const TextStyle(fontSize: 30),
                              ),
                              FlatButton(onPressed: (){
                                cartProvider.delete(cartProvider.cartList[index].id??-1);
                              }, child: Text("Delete")),

                              FlatButton(onPressed: (){
                                Cart cart = cartProvider.cartList[index];
                                cart.price = 200;
                                cart.name = "This Cart Is Updated.";
                                cartProvider.update(cart);
                              }, child: Text("Update")),



                            ],
                          ),
                        ),
                      );
                    },
                    childCount: cartProvider.cartList.length, // 1000 list items
                  ),
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
