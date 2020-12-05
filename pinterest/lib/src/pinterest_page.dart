import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest/src/widgets/pinterest_menu.dart';
import 'package:provider/provider.dart';


class PinterestPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    
  final widthPantalla = MediaQuery.of(context).size.width;
  

    return ChangeNotifierProvider(
                  create: (_) => new  _MenuModel(),
                  child: Scaffold(
                    // body: PinterestMenu(),
                    //body: PinterestGrid(),
                    body: Stack(
                      children: [
                        PinterestGrid(),
                        _PinterestMenuLocation(widthPantalla: widthPantalla)
                      ],
                    ),
            ),
    );
  }

 
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({
    Key key,
    @required this.widthPantalla
    

  }) : super(key: key);

  final double widthPantalla;
  

  @override
  Widget build(BuildContext context) {
    final mostrar = Provider.of<_MenuModel>(context).mostrar;
    return Positioned(
      bottom: 30,
      child: Container(
       // color: Colors.red,
        width: widthPantalla,
        child: Align(
            child: PinterestMenu(
              mostrar: mostrar,
              //backgroundColor: Colors.red,
              activeColor: Colors.red,
              inactiveColor: Colors.blue,
              items: [
                  PinterestButton(icon: Icons.pie_chart, onPressed: (){print('icon_pie_chart');}),
                  PinterestButton(icon: Icons.search, onPressed: (){print('icon_search');}),
                  PinterestButton(icon: Icons.notifications, onPressed: (){print('icon_notifications');}),
                  PinterestButton(icon: Icons.supervised_user_circle, onPressed: (){print('icon_supervised_user_circle');})
              ],
            ),
            //alignment: Alignment.topRight,
        ),
      )
    );
  }
}
 class PinterestGrid extends StatefulWidget {

  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {

    final List items =  List.generate(200, (index) => index);
    ScrollController controller = new ScrollController();
    double scrollAnterior = 0;

    @override
    void initState() {
      // TODO: implement initState
      controller.addListener(() { 
        //print('Scrollistener ${controller.offset}');
        if(controller.offset > scrollAnterior && controller.offset > 150){
            print('ocultar menu');
            Provider.of<_MenuModel>(context,listen: false).mostrar = false;
        }else {
             print('mostrar menu');
             Provider.of<_MenuModel>(context,listen: false).mostrar = true;
        }
        scrollAnterior = controller.offset;

      });
      super.initState();
    }

    @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }

        @override
      Widget build(BuildContext context) {
        return  new StaggeredGridView.countBuilder(
              controller: controller,
              crossAxisCount: 4,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) => _PinterestItem( index ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, index.isEven ? 2 : 3),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            );
      }
}

class _PinterestItem extends StatelessWidget {
 
 final int index;

 _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: new Center(
          child: new CircleAvatar(
            backgroundColor: Colors.white,
            child: new Text('$index'),
          ),
        ));
  }
}


class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => this._mostrar;
  set mostrar(bool valor){
    this._mostrar = valor;
    notifyListeners();
  }
}

