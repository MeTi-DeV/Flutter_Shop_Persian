import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _editProduct = Product(
    id: '',
    imageUrl: '',
    title: '',
    description: '',
    price: 0,
  );
  var _isInState = true;
  var _initialValue = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void savForm() {
    final isSave = _formKey.currentState!.validate();
    if (!isSave) {
      return;
    }

    _formKey.currentState!.save();
    if (_editProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInState) {
      final productId = ModalRoute.of(context)!.settings.arguments == null
          ? "Null"
          : ModalRoute.of(context)!.settings.arguments as String;
      if (productId != "Null") {
        _editProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
      }
      _initialValue = {
        'id': _editProduct.id,
        'title': _editProduct.title,
        'price': _editProduct.price.toString(),
        'description': _editProduct.description,
        'imageUrl': ''
      };
      _imageUrlController.text = _editProduct.imageUrl;
    }
    _isInState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اضافه و ویرایش محصول'),
        actions: [
          IconButton(
            onPressed: () {
              savForm();
              
            },
            icon: Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initialValue['title'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفا عنوان محصول خود را اانتخاب کنید';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      isFavorite: _editProduct.isFavorite,
                      id: _editProduct.id,
                      imageUrl: _editProduct.imageUrl,
                      title: value as String,
                      description: _editProduct.description,
                      price: _editProduct.price);
                },
                decoration: InputDecoration(labelText: 'عنوان محصول'),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: _initialValue['price'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفا مبلغ محصول را را وارد کنید';
                  }
                  if (double.tryParse(value) == null) {
                    return 'لطفا مبلغ محصول را به درستی وارد کنید';
                  }
                  if (double.parse(value) <= 0) {
                    return 'مبلغی بیشتر از 10000 تومان وارد کنید';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      isFavorite: _editProduct.isFavorite,
                      id: _editProduct.id,
                      imageUrl: _editProduct.imageUrl,
                      title: _editProduct.title,
                      description: _editProduct.description,
                      price: double.parse(value!));
                },
                decoration: InputDecoration(labelText: 'قیمت محصول'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: _initialValue['description'],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'لطفا توضیحات محصول را وارد کنید';
                  }
                  if (value.length <10) {
                    return 'توضیحات باید بیش از 10 کلمه باشد';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editProduct = Product(
                      isFavorite: _editProduct.isFavorite,
                      id: _editProduct.id,
                      imageUrl: _editProduct.imageUrl,
                      title: _editProduct.title,
                      description: value as String,
                      price: _editProduct.price);
                },
                decoration: InputDecoration(labelText: 'توضیحات محصول'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: _imageUrlController.text.isEmpty
                        ? Text('آدرس اینترنتی را وارد کنید')
                        : FittedBox(
                            child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          )),
                    margin: EdgeInsets.only(top: 15, right: 10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: TextFormField(
                      
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'آدرس اینترنتی را وارد کنید';
                      }
                      if (!value.startsWith('http') &&
                          (!value.startsWith('https'))) {
                        return 'آدرس اینترنتی باید با http یا https شروع شود';
                      }
                      if (!value.endsWith('jpg') &&
                          !value.endsWith('png') &&
                          !value.endsWith('jpeg')) {
                        return 'پسوند تصویر را به درستی وارد کنید';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editProduct = Product(
                          isFavorite: _editProduct.isFavorite,
                          id: _editProduct.id,
                          imageUrl: value as String,
                          title: _editProduct.title,
                          description: _editProduct.description,
                          price: _editProduct.price);
                    },
                    decoration:
                        InputDecoration(labelText: 'آدرس اینترنتی تصویر'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onFieldSubmitted: (_) => savForm(),
                    onEditingComplete: () {
                      // Navigator.of(context).pop();
                      // savForm();
                      setState(() {});
                    },
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
