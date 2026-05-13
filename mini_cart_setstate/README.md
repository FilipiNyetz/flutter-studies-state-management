# MiniCart

> Estudo de caso para fundamentar conceitos de `setState` e state lifting no Flutter.
---

## Sobre o projeto

Neste app foi implementada a lógica básica de simulação de um carrinho de compras utilizando exclusivamente `setState` para todo o gerenciamento de estado.

---

## Objetivos do estudo de caso

- Aplicar o conceito de state lifting na prática
- Observar a reconstrução de widgets em cada nível da árvore
- Distinguir o que é estado do que é widget em `StatefulWidgets`
- Evidenciar os desafios e limitações do `setState` como única solução de gerenciamento

---

## Arquitetura

```
MyApp (StatelessWidget)
└── CartScreen (StatefulWidget)        — valor total do carrinho
    └── ProductsCard (StatefulWidget)  — lista de produtos + quantidades
        └── QuantityCell (StatelessWidget) — botões + / -
```

---

## Estrutura

**`CartScreen`** mantém o valor total do carrinho. Por estar no topo da árvore, depende dos widgets filhos para calcular esse valor — o que é feito através de um callback `ValueChanged<double>` passado como parâmetro para `ProductsCard`. Toda vez que o subtotal muda, o callback é chamado e o `setState` do `CartScreen` reconstrói o totalizador.

**`ProductsCard`** declara a lista de produtos e gerencia as quantidades através de um `Map<int, int>` que associa o `id` de cada produto à sua quantidade atual. O total é calculado como estado derivado via getter — sem armazenamento separado. As quantidades vivem aqui por causa do state lifting: o `CartScreen` precisa do total, e o total depende das quantidades, então o estado subiu até o nível que consegue calculá-lo e comunicá-lo para cima.

**`QuantityCell`** é um `StatelessWidget` responsável apenas por exibir a quantidade atual e disparar o callback `ValueChanged<int>` a cada clique — sem gerenciar estado próprio.

---

## Fluxo de dados

```
QuantityCell
  — onChanged(newQuantity) →

ProductsCard
  — atualiza Map<int, int>
  — calcula _totalValue (getter)
  — onChanged(totalValue) →

CartScreen
  — setState() → reconstrói o totalizador
```

---

## Conceitos aplicados

### State lifting

O estado de quantidade nasceu naturalmente no `QuantityCell` — é ele quem exibe e altera o valor. Porém, como o `ProductsCard` precisa calcular o subtotal e o `CartScreen` precisa exibir o total, o estado precisou **subir** para o nível que consegue calculá-lo e comunicá-lo.

```dart
// ProductsCard — estado que "subiu" do QuantityCell
Map<int, int> quantity = {};

// Getter de estado derivado — não armazenado, calculado na hora
double get _totalValue {
  double total = 0;
  for (var product in ProductsCard.products) {
    total += product.valor * (quantity[product.id] ?? 0);
  }
  return total;
}
```


### Callback filho → pai

Sem um mecanismo de compartilhamento, a única forma de um filho comunicar uma mudança ao pai com `setState` é através de callbacks passados como parâmetro.

```dart
// Pai declara e passa o callback
QuantityCell(
  quantity: quantity[product.id] ?? 0,
  onChanged: (newQuantity) => _onQuantityChanged(product.id, newQuantity),
)

// Filho dispara o callback
IconButton(
  onPressed: () => onChanged(quantity + 1),
  icon: const Icon(Icons.add),
)
```

---

## Limitações evidenciadas

Este mini app evidenciou os principais problemas de usar exclusivamente setState e torna explícito o custo do state lifting em apps maiores: sou obrigado a construir callbacks para escutar alterações nos widgets filhos apenas porque o pai precisa ler aquele estado. O QuantityCell é o exemplo mais claro disso, ele perdeu a autonomia sobre sua própria quantidade não por uma decisão de arquitetura, mas por uma limitação do setState: sem um mecanismo de compartilhamento, o estado precisa subir até quem precisa ler, mesmo que semanticamente ele pertença ao filho.

---