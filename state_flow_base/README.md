# StateFlow

> Estudo de caso para fundamentar conceitos base de gerenciamento de estado no Flutter.


## Sobre o projeto

Mini app de semáforo interativo construído com o objetivo de evidenciar, os fundamentos de gerenciamento de estado no Flutter.

O app avança os estados de um semáforo (verde → amarelo → vermelho) e registra um histórico de todas as alterações com horário.

---

## Conceitos fundamentados

### O que é estado?

Estado é qualquer informação que pode alterar seu valor durante o uso do app — seja por uma interação do usuário ou pelo próprio funcionamento da aplicação. É o conjunto de dados mutáveis que interfere diretamente na UI, sendo responsável por promover reatividade e refletir os resultados das interações.

**Exemplos no app:** o estado atual do semáforo (`currentLight`) e a lista de logs (`statusLog`) são estados — ambos mudam ao longo do tempo e causam atualização visual.

---

### StatelessWidget vs StatefulWidget

| | StatelessWidget | StatefulWidget |
|---|---|---|
| **Estado** | Não possui | Possui |
| **Mutabilidade** | Imutável | Mutável |
| **Uso** | Estruturas estáticas | Elementos que refletem mudanças |
| **Exemplos** | Telas, menus, textos fixos | Formulários, contadores, animações |


**No app:** `CardLogs` é `StatelessWidget` — apenas exibe dados recebidos via parâmetro, sem gerenciar nada. `StateFlowApp` é `StatefulWidget` — gerencia o estado atual do semáforo e o histórico de logs.

---

### Estado Local vs Estado Global

**Estado local** é aquele que influencia apenas uma única árvore de widgets. Não precisa ser compartilhado com outras partes do app.

**Estado global** afeta múltiplas partes do app.

**No app:** todo o estado é local — `currentStatus` e `statusLog` vivem dentro de `_StateFlowAppState`. O `CardLogs` não acessa o estado diretamente; apenas recebe valores prontos via parâmetro.

---

### setState()

A forma mais primitiva e nativa de gerenciamento de estado no Flutter. Ao ser chamado, marca o widget como *dirty* e agenda um rebuild para o próximo frame.

```dart
setState(() {
                    switch (currentLight) {
                      case .green:
                        currentLight = .yellow;
                      case .yellow:
                        currentLight = .red;
                      case .red:
                        currentLight = .green;
                    }
                    statusLog.add(StatusLog(DateTime.now(), currentLight));
                  });
```

**Quando usar:** ideal para estado local simples, quando o `StatefulWidget` está posicionado corretamente na árvore — isolando apenas o widget que precisa reconstruir.

**Quando evitar:** quando o estado precisa ser compartilhado entre múltiplas telas, ou quando o `StatefulWidget` está alto na árvore e seu rebuild afeta widgets que não dependem daquele estado.
