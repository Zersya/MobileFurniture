import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import 'package:furniture_app/blocs/Items/items.dart';
import 'package:furniture_app/screens/home/detail.item.screen.dart';

class GridItems extends StatefulWidget {
  final String TOKEN;

  GridItems({Key key, this.TOKEN}) : super(key: key);

  @override
  _GridItemsState createState() => _GridItemsState();
}

class _GridItemsState extends State<GridItems> {
  ItemsBloc itemsBloc = ItemsBloc();
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    itemsBloc.dispatch(LoadItems(widget.TOKEN));
    super.initState();
  }

  @override
  void dispose() {
    itemsBloc.dispose();
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: itemsBloc,
      builder: (BuildContext context, ItemsState state) {
        if (state is ItemsLoading) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(199, 177, 152, 1)),
          ));
        } else if (state is ItemsLoaded) {
          return ListView(children: <Widget>[
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: 2,
                pageSnapping: true,
                controller: PageController(viewportFraction: 0.8),
                itemBuilder: (BuildContext context, int itemIndx) {
                  return topSaleCard(state, itemIndx);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Our Product',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  gridItem(state)
                ],
              ),
            ),
          ]);
        } else if (state is ItemsNotLoaded) {
          return Center(child: Text("Can't Load Item"));
        } else if (state is LoadedDetailItem) {
          return DetailItemScreen(
            item: state.item,
            itemsBloc: itemsBloc,
          );
        } else {
          return Center(
              child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Color.fromRGBO(199, 177, 152, 1)),
          ));
        }
      },
    );
  }

  Widget topSaleCard(ItemsLoaded state, itemIndx) {
    return Stack(
      children: <Widget>[
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              height: 200,
              placeholder: 'assets/wait.png',
              image: state.items[itemIndx].images[0].imageurl,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 10),
              child: Text(
                state.items[itemIndx].name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 1.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              ),
            ))
      ],
    );
  }

  StaggeredGridView gridItem(ItemsLoaded state) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      physics: ScrollPhysics(),
      itemCount: state.items.length,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              itemsBloc.dispatch(SelectDetailItem(state.items[index]));
            },
            child: itemGrid(state, index, context),
          ),
      staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, index.isEven ? 3 : 3),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 5.0,
    );
  }

  Widget itemGrid(ItemsLoaded state, int index, BuildContext context) {
    return Card(
      elevation: 10,
                  color: Color.fromRGBO(131, 132, 105, 1),
      child: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
              height: 100,
              placeholder: 'assets/wait.png',
              image: state.items[index].images[0].imageurl,
              fit: BoxFit.fill),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  color: Color.fromRGBO(131, 132, 105, 1),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text(state.items[index].name, style: TextStyle(color: Colors.white),),
                          subtitle: Text(
                            'Rp. ' +
                                FlutterMoneyFormatter(
                                        amount:
                                            state.items[index].price.toDouble())
                                    .output
                                    .nonSymbol,
                                    style: TextStyle(color: Colors.white),
                         ),
                        ),
                        Chip(
                          elevation: 5,
                          backgroundColor: Color.fromRGBO(223, 211, 195, 1),
                          label: Text(state.items[index].category),
                          avatar: CircleAvatar(
                            child: Text(
                              state.items[index].category[0],
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.brown,
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
