// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopper/models/cart.dart';
import 'package:provider_shopper/models/catalog.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.display4),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.title;
    var cart = Provider.of<CartModel>(context);

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        title: Text(
          cart.items[index].name,
          style: itemNameStyle,
        ),
        trailing: _RemoveButton(item: cart.items[index]),
      ),
    );
  }
}

class _RemoveButton extends StatelessWidget {
  final Item item;

  const _RemoveButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return FlatButton(
      onPressed: cart.items.contains(item) ? () => cart.remove(item) : () => null,
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)
          ? Icon(Icons.remove_shopping_cart, semanticLabel: 'REMOVED')
          : Text('REMOVE'),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.display4.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}', style: hugeStyle)),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Try later please.')));
              },
              color: Colors.red,
              child: Text('BUY ME A BEER'),
            ),
          ],
        ),
      ),
    );
  }
}
