# 💧 Salve as Gotinhas

Jogo sério educativo focado na conscientização do consumo de água e no ensino de operações matemáticas básicas.

---

## 📋 Sobre o Projeto

**Salve as Gotinhas** é um jogo desenvolvido como Trabalho Final da disciplina de Engenharia de Software do curso de Bacharelado em Ciência da Computação da **Universidade Tecnológica Federal do Paraná (UTFPR - Campus Ponta Grossa)**.

O projeto foi idealizado em parceria com a **ASSARTE (Associação do Excepcional de Ponta Grossa)**, tendo como público-alvo pessoas com deficiência intelectual. O objetivo principal é ensinar operações matemáticas básicas (adição e subtração) de forma lúdica e acessível, utilizando a temática da preservação da água.

---

## 🎮 Funcionalidades do Jogo

O jogo utiliza uma estética em **Pixel Art minimalista** e recursos de **acessibilidade auditiva** para garantir a inclusão.

### 1. Fase 1: Somando ➕

Focada na identificação de objetos e na operação de adição.

- **Etapa 1:** Identificação de objetos que consomem água vs. objetos que não consomem.
- **Etapas 2, 3 e 4:** O jogador deve somar a quantidade de "gotinhas" (custo de água) de diferentes objetos para encontrar a resposta correta. A dificuldade é progressiva.

### 2. Fase 2: Subtraindo ➖

Focada na conscientização do desperdício e na operação de subtração.

- **Mecânica do Reservatório:** O jogador inicia com um reservatório cheio (10 gotas) e deve selecionar atividades do dia a dia para gastar a água até chegar exatamente a zero.
- **Feedback:** Se o jogador gastar mais água do que possui, um sistema de alerta visual e sonoro informa sobre o desperdício.

### 3. Acessibilidade e Ajuda ♿

- **Narração Global:** Sistema de áudio (NarradorGlobal) que descreve os objetos e lê os textos ao passar o mouse (hover), auxiliando alunos com dificuldades de leitura.
- **Tour de Ajuda:** Botão interativo (?) presente em todas as telas que destaca visualmente (com um shader de "holofote") os elementos importantes e explica o objetivo da fase passo a passo.

### 4. Área do Professor (Relatórios) 📊

Um painel exclusivo para educadores que permite acompanhar a evolução dos alunos.

- Registro de Erros e Acertos
- Monitoramento do Tempo gasto em cada etapa
- Dados persistentes que podem ser resetados para novas sessões

---

## 🛠️ Tecnologias e Metodologia

- **Motor Gráfico:** Godot Engine 4.5
- **Linguagem:** GDScript
- **Metodologia de Desenvolvimento:** Scrum (Dividido em 7 Sprints)
- **Qualidade de Software:** Avaliação baseada nas características da norma ISO/IEC 9126 (Funcionalidade, Confiabilidade, Usabilidade e Eficiência)

---

## 🚀 Instalação e Como Jogar

Não é necessária uma instalação complexa. O jogo é distribuído como um **executável portátil**.

### 🪟 Windows

1. Baixe o arquivo `.ZIP` da versão mais recente
2. Extraia todo o conteúdo para uma pasta
3. Execute o arquivo `jogo.exe` (ou `SalveAsGotinhas.exe`)

#### ⚠️ Aviso do Windows Defender

Na primeira execução, pode aparecer a mensagem **"O Windows protegeu seu PC"**. Isso ocorre porque o software acadêmico não possui certificado digital da Microsoft.

**Para jogar:**
1. Clique em **"Mais informações"**
2. Depois clique em **"Executar assim mesmo"**

### 🐧 Linux

1. Extraia o arquivo `.ZIP`
2. Dê permissão de execução ao arquivo `.x86_64`

   **Método Gráfico:**
   - Clique com botão direito > Propriedades > Permissões
   - Marque "Permitir execução como programa"

   **Método Terminal:**
   ```bash
   chmod +x nome-do-jogo.x86_64
   ```

3. Execute o arquivo com duplo clique ou via terminal:
   ```bash
   ./nome-do-jogo.x86_64
   ```

---

## 💻 Requisitos Mínimos do Sistema

### Windows
- **Sistema Operacional:** Windows 10 ou superior (64-bit)
- **Processador:** Dual Core 2.0 GHz
- **Memória RAM:** 1 GB
- **Placa de Vídeo:** Compatível com OpenGL 3.3
- **Espaço em Disco:** 200 MB disponível

### Linux
- **Sistema Operacional:** Distribuições modernas (64-bit)
- **Processador:** Dual Core 2.0 GHz
- **Memória RAM:** 1 GB
- **Placa de Vídeo:** Compatível com OpenGL 3.3
- **Espaço em Disco:** 200 MB disponível

---

## 👥 Equipe de Desenvolvimento (Equipe 05)

- **Daniel Samara**
- **Felipe de Brito** (Desenvolvedor)
- **Felipe do Rosario** (Desenvolvedor)
- **Fernando Alberti Gomes**
- **Tobias Rocha** (Scrum Master / Desenvolvedor)

**Product Owner / Docente:**
- Dra. Eliana Cláudia Mayumi Ishikawa

---

## 🧪 Validação

O protótipo funcional foi validado na **ASSARTE** em Novembro de 2025, com participação de alunos e professores, obtendo aprovação nos critérios de usabilidade e adequação ao objetivo pedagógico.


---

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como parte do curso de Engenharia de Software da UTFPR.

---

**Universidade Tecnológica Federal do Paraná - 2025**
