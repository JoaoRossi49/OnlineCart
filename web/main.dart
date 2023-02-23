import 'dart:html';
import 'dart:math';

void main() {
  //Criar base de dados com produtos
  //Criar página com produtos e opção de adicionar o carrinho
  //while true para criação de novos objetos Product
  //Append para list carrinho

  Product p1 = Product('Playstation', 100.00, 1, false);
  Product p2 = Product('Xbox 360', 200.00, 1, false);
  Product p3 = Product('Airfryer', 300, 1, false);
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

  InputElement? checkbox1 = document.querySelector('#pd1-cb') as InputElement?;

  checkbox1?.onChange.listen(
    (event) {
      bool? statusCheckbox1 = checkbox1?.checked;
      print(statusCheckbox1);
      if (statusCheckbox1 == true) {
        p1.valido = true;
        t1 = Total(carrinho);
        print("Deu certo, true");
        updateTotais();
      } else {
        p1.valido = false;
        t1 = Total(carrinho);
        print("Deu certo, false");
        updateTotais();
      }
    },
  );

  InputElement? checkbox2 = document.querySelector('#pd2-cb') as InputElement?;

  checkbox2?.onChange.listen(
    (event) {
      bool? statusCheckbox2 = checkbox2?.checked;
      print(statusCheckbox2);
      if (statusCheckbox2 == true) {
        p2.valido = true;
        t1 = Total(carrinho);
        print("Deu certo, true");
        updateTotais();
      } else {
        p2.valido = false;
        t1 = Total(carrinho);
        print("Deu certo, false");
        updateTotais();
      }
    },
  );

  InputElement? checkbox3 = document.querySelector('#pd3-cb') as InputElement?;

  checkbox3?.onChange.listen(
    (event) {
      bool? statusCheckbox3 = checkbox3?.checked;
      print(statusCheckbox3);
      if (statusCheckbox3 == true) {
        p3.valido = true;
        t1 = Total(carrinho);
        print("Deu certo, true");
        updateTotais();
      } else {
        p3.valido = false;
        t1 = Total(carrinho);
        print("Deu certo, false");
        updateTotais();
      }
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

  Product(this.nome, this.preco, this.quantidade, this.valido);
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
