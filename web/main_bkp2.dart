import 'dart:html';
import 'dart:math';

void main() {
  //Criar base de dados com produtos
  //Criar página com produtos e opção de adicionar o carrinho
  //while true para criação de novos objetos Product
  //Append para list carrinho
  InputElement? checkbox1 = document.querySelector('pd1-cb') as InputElement?;
  InputElement? checkbox2 = document.querySelector('pd2-cb') as InputElement?;
  InputElement? checkbox3 = document.querySelector('pd3-cb') as InputElement?;
  Product p1 =
      Product('Playstation', 100.00, 1, false, checkbox1 as InputElement);
  Product p2 = Product('Xbox 360', 200.00, 1, false, checkbox2 as InputElement);
  Product p3 = Product('Airfryer', 500.15, 1, false, checkbox3 as InputElement);

  var carrinho = <Product>[p1, p2, p3];
  Total t1 = Total(carrinho);

  void updateTotais() {
    //Total
    querySelector('#total-value')?.text = "BRL " "${t1.total}";
    //Desconto
    querySelector('#discount-value')?.text = "BRL " "${t1.discount}";
    //Subtotal
    querySelector('#subtotal-value')?.text = "BRL" "${t1.subtotal}";
    //Check box produto 1
  }

  updateTotais();

  void validaCheckbox() {
    for (Product e in carrinho) {
      e.checkbox.onChange.listen(
        (event) {
          bool? statusCheckbox = e.checkbox.checked;
          if (statusCheckbox == true) {
            e.valido = true;
            t1 = Total(carrinho);
            updateTotais();
          } else {
            e.valido = false;
            t1 = Total(carrinho);
            updateTotais();
          }
        },
      );
    }
  }

  querySelector('pd1-cb')?.onChange.listen(
    (event) {
      validaCheckbox();
    },
  );
  querySelector('pd2-cb')?.onChange.listen(
    (event) {
      validaCheckbox();
    },
  );
  querySelector('pd3-cb')?.onChange.listen(
    (event) {
      validaCheckbox();
    },
  );

  //Produto 1
  querySelector('#pd1-name')?.text = p1.nome;
  querySelector('#pd1-value')?.text = "BRL " "${p1.preco}";
  //Produto 2
  querySelector('#pd2-name')?.text = p2.nome;
  querySelector('#pd2-value')?.text = "BRL " "${p2.preco}";
  //Produto 3
  querySelector('#pd3-name')?.text = p3.nome;
  querySelector('#pd3-value')?.text = "BRL " "${p3.preco}";
}

class Product {
  String nome;
  double preco;
  int quantidade;
  bool valido;
  InputElement checkbox;

  Product(this.nome, this.preco, this.quantidade, this.valido, this.checkbox);
  void setValid() {
    valido = true;
  }

  void setInvalid() {
    valido = false;
  }
}

class Total {
  List carrinho;
  double total = 0;
  double subtotal = 0;
  double discountPercentage = 0.25;
  double discount = 0;

  Total(this.carrinho) {
    carrinho.forEach((element) {
      if (element.valido == true) {
        total += element.preco;
        subtotal = total;
      }

      if (total >= 300) {
        var lista = <double>[];
        int num = 0;
        for (Product i in carrinho) {
          if (i.valido == true) {
            lista.insert(num, i.preco);
            num++;
          }
        }
        discount = (lista.reduce(min)) * discountPercentage;
        total -= discount;
      }
    });
  }
}
