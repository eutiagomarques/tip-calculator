# 📱 Tip Calculator

Uma calculadora de gorjetas moderna e responsiva, desenvolvida para demonstrar a implementação de fluxos de dados reativos no ecossistema iOS.

## 🎯 Objetivo do Projeto
O foco principal deste projeto foi aplicar os conceitos de **Programação Reativa** utilizando o framework **Combine**. A aplicação gerencia entradas de dados (valor da conta, porcentagem de gorjeta e divisão entre pessoas) e reflete os cálculos na interface de forma instantânea e encadeada.

## 🏗 Arquitetura (MVVM Reativo)
O projeto utiliza o padrão **MVVM (Model-View-ViewModel)** com uma abordagem robusta de **Input/Output**, o que desacopla a lógica de negócio da interface e facilita a manutenção.

* **View**: Captura eventos de interface através de `Publishers` (via CombineCocoa).
* **ViewModel**: Recebe esses eventos em uma `struct Input`, processa os dados usando operadores como `Publishers.CombineLatest3` e `map`, e expõe uma `struct Output`.
* **Binding**: A `ViewController` assina o output da ViewModel para atualizar os componentes de UI automaticamente, garantindo que a lógica de cálculo não "polua" a View.

## 🛠 Tecnologias e Bibliotecas
* **Swift** (v5.0+)
* **UIKit**: Interface 100% construída em **View Code**.
* **Combine**: Framework nativo para programação reativa e vinculação de dados.
* **CombineCocoa**: Extensões para integrar componentes UIKit com o Combine.
* **SnapKit**: DSL para implementação de Auto Layout via código.

## 🚀 Destaques Técnicos
* **Transformações Declarativas**: O cálculo do valor por pessoa e gorjetas é feito através de uma cadeia de operadores, eliminando a necessidade de funções de callback manuais.
* **Gerenciamento de Memória**: Uso rigoroso de `Set<AnyCancellable>` e `[weak self]` para evitar ciclos de retenção (Memory Leaks).
* **UI Thread Safety**: Garantia de que as atualizações de interface ocorrem na Main Thread através do `.receive(on: RunLoop.main)`.
* 
* 
<img width="400" height="800" alt="Simulator Screenshot - iPhone 17 Pro - 2026-02-28 at 12 40 35" src="https://github.com/user-attachments/assets/601a73b0-6001-4808-bcb7-792854306f0b" />




