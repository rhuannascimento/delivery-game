# Scape Game

## Descrição

Delivery Game é um jogo desenvolvido como terceiro trabalho da disciplina de **Desenvolvimento de Jogos**. O projeto utiliza a engine Godot.

## Requisitos do Projeto

O jogo deve ser um produto completo e atender minimamente aos requisitos listados abaixo:

- **Tela Inicial:** Deve existir uma tela/menu inicial com a opção de iniciar o jogo (e opcionalmente opções adicionais como créditos, configurações e sair).
- **Detecção e Tratamento de Colisões:** Implementar detecção e tratamento de colisões — pode ser feito usando o sistema de física do Godot ou por detecção/gestão manual dentro dos scripts. Deve haver tratamento adequado entre jogador, inimigos, ambiente e objetos interativos.
- **Controle de Câmera:** A câmera não pode ser estática. Ela deve ter comportamento dinâmico (ex.: terceira pessoa, primeira pessoa, câmera aérea, lateral ou atrás do jogador) e seguir/acompanhar o jogador de forma apropriada à jogabilidade.
- **Áudio e Interface (HUD):** Incluir efeitos sonoros e música de fundo. Também deve haver elementos de interface para exibir informações relevantes (vida, pontuação, tempo, objetivos, etc.).
- **Uso de Física:** O jogo deve utilizar física (colisões rígidas, gravidade, forças ou outras simulações físicas) em pelo menos alguns elementos da jogabilidade.
- **Pathfinding / Estruturas de Decisão:** Deve haver uso de pathfinding e/ou estruturas de tomada de decisão para entidades não-jogadoras, tais como máquinas de estado finitas, árvores de decisão, ou árvores de comportamento (behaviour trees).
- **Objetivo do Jogo:** Definir um objetivo claro — por exemplo, completar um conjunto de fases, derrotar um conjunto de inimigos, entregar/colecionar itens, ou outro objetivo que dê sentido ao jogo e permita encerramento/ vitória.
- **Detecção de Colisões e Resposta:** Além da detecção, deve existir lógica de resposta (dano, reação, pontuação, física, rebote, etc.) adequada às colisões detectadas.
- **OPCIONAL (Procedural):** Ambiente ou conteúdo gerado proceduralmente é opcional, mas valorizado se implementado.

Observações:
- Todos os assets de terceiros devem ser devidamente creditados na seção de créditos.
- O jogo deve ser criado com a Godot Engine e o projeto deve incluir instruções básicas para execução.

## Padrões de Desenvolvimento

### Estrutura do Código

```
src/
├── Main.tscn                 # Cena principal do jogo
├── modules/
│   ├── player/
│   │   ├── Player.tscn      # Cena do personagem
│   │   └── scripts/
│   │       └── player.gd    # Script de controle do player
│   ├── map/
│   │   └── Map.tscn       # Cena do mundo/fase
│   └── [novo-modulo]/       # Padrão para novos módulos
│       ├── [Componente].tscn
│       └── scripts/
│           └── [componente].gd
```

#### Como Replicar para Futuros Módulos

1. **Criar a pasta do módulo**: `src/modules/[nome-do-modulo]/`
2. **Criar a cena principal**: `src/modules/[nome-do-modulo]/[NomeComponente].tscn`
3. **Criar a pasta de scripts**: `src/modules/[nome-do-modulo]/scripts/`
4. **Seguir a convenção de nomenclatura**:
   - Arquivos `.tscn` em PascalCase
   - Arquivos `.gd` em snake_case
   - Nomes de classes em PascalCase
5. **Instanciar o módulo** na cena pai quando necessário

### Padrão de Commits

Todos os commits devem seguir o padrão Conventional Commits com descrições em português:

```
FEAT: Adiciona nova funcionalidade
FIX: Corrige bug ou problema existente
CHORE: Alterações em configuração, dependências ou estrutura
REFACT: Refatoração de código sem mudança de funcionalidade
```

#### Exemplos:
- `FEAT: Adiciona sistema de pulo do player`
- `FIX: Corrige colisão com player`
- `CHORE: Reorganiza estrutura de pastas`
- `REFACT: Melhora lógica de controle de câmera`

### Padrão de Branches

As branches devem seguir o padrão:

```
feat/[descrição-da-funcionalidade]
fix/[descrição-do-problema]
chore/[descrição-da-tarefa]
refact/[descrição-da-refatoração]
```

#### Exemplos:
- `feat/sistema-de-vidas`
- `feat/inimigo-voador`
- `fix/bug-de-colisao-com-parede`
- `fix/audio-nao-reproduz-corretamente`
- `chore/atualizar-versao-godot`
- `refact/melhorar-sistema-de-eventos`

#### Regras para Branches:
1. Use hífen (`-`) para separar palavras
2. Use apenas letras minúsculas
3. Crie uma branch por feature/fix
4. Fazer Pull Request para master
5. Sempre crie a branch a partir da `master`

## Como Executar

1. Abra o projeto no Godot Engine
2. Clique em "Run" ou pressione `F5` para iniciar o jogo
3. Navegue pelo menu inicial para começar


## Grupo

- Rhuan Nascimento Ferreira
- Mario Henrrique
- Alfredo Lucas
- Daniel Rezende


**Desenvolvido para a disciplina de Desenvolvimento de Jogos**
