class QuizQuestion {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final String? explanation;

  const QuizQuestion({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    this.explanation,
  });
}

final List<QuizQuestion> quizQuestions = [
  const QuizQuestion(
    question: 'O que você deve fazer se encontrar fósforos ou isqueiros?',
    answers: [
      'Brincar com eles para ver como funcionam',
      'Guardar no seu bolso',
      'Avisar um adulto imediatamente',
      'Tentar acender para ver se funcionam',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Fósforos e isqueiros são muito perigosos e podem causar incêndios. Sempre avise um adulto se encontrar esses objetos.',
  ),
  const QuizQuestion(
    question: 'Qual é o lugar mais perigoso da casa para queimaduras?',
    answers: ['Quarto', 'Cozinha', 'Sala de estar', 'Banheiro'],
    correctAnswerIndex: 1,
    explanation:
        'A cozinha tem fogão, panelas quentes e líquidos ferventes que podem causar queimaduras graves.',
  ),
  const QuizQuestion(
    question: 'O que você deve fazer se quiser algo que está no fogão?',
    answers: [
      'Pegar sozinho com cuidado',
      'Subir em uma cadeira para alcançar',
      'Pedir ajuda a um adulto',
      'Usar uma colher grande para pegar',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Nunca tente pegar algo do fogão sozinho. Sempre peça ajuda a um adulto.',
  ),
  const QuizQuestion(
    question: 'O que você deve fazer para se proteger do sol?',
    answers: [
      'Usar protetor solar e chapéu',
      'Ficar no sol apenas ao meio-dia',
      'Não precisa se proteger em dias nublados',
      'Usar roupas pretas que absorvem mais calor',
    ],
    correctAnswerIndex: 0,
    explanation:
        'Usar protetor solar, chapéu e roupas adequadas é a melhor forma de se proteger das queimaduras solares.',
  ),
  const QuizQuestion(
    question: 'O que você deve fazer se derramar um produto de limpeza?',
    answers: [
      'Limpar sozinho rapidamente',
      'Ignorar, pois não é perigoso',
      'Cheirar para ver que produto é',
      'Chamar um adulto imediatamente',
    ],
    correctAnswerIndex: 3,
    explanation:
        'Produtos de limpeza contêm químicos que podem causar queimaduras. Sempre chame um adulto se derramar algum produto.',
  ),
  const QuizQuestion(
    question: 'O que você NÃO deve fazer perto de tomadas elétricas?',
    answers: [
      'Manter distância',
      'Colocar objetos metálicos dentro delas',
      'Chamar um adulto se notar algo estranho',
      'Evitar tocar com as mãos molhadas',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Nunca coloque objetos, especialmente metálicos, dentro de tomadas. Isso pode causar choques elétricos graves.',
  ),
  const QuizQuestion(
    question:
        'O que você deve fazer se alguém estiver com a roupa pegando fogo?',
    answers: [
      'Correr para buscar água',
      'Soprar o fogo para apagar',
      'Parar, deitar e rolar no chão',
      'Correr para pedir ajuda',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Se a roupa estiver pegando fogo, a pessoa deve parar (não correr), deitar e rolar no chão para apagar as chamas.',
  ),
  const QuizQuestion(
    question: 'Qual é a melhor forma de carregar uma bebida quente?',
    answers: [
      'Correndo rápido para não esfriar',
      'Com cuidado, usando as duas mãos',
      'Enchendo o copo até a borda',
      'Segurando o copo pela borda',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Bebidas quentes devem ser carregadas com cuidado, usando as duas mãos e sem encher demais o copo.',
  ),
  const QuizQuestion(
    question:
        'O que você deve fazer ao ver uma lagarta peluda ou inseto estranho?',
    answers: [
      'Tocar para ver se é perigoso',
      'Tentar espantar com a mão',
      'Observar de perto e soprar',
      'Ficar longe e avisar um adulto',
    ],
    correctAnswerIndex: 3,
    explanation:
        'Insetos como lagartas podem causar queimaduras e irritações. Nunca toque — mantenha distância e avise um adulto.',
  ),
  const QuizQuestion(
    question: 'O que fazer se você ver uma água-viva na praia?',
    answers: [
      'Tocar para ver se está viva',
      'Brincar com ela usando um galho',
      'Avisar um adulto e manter distância',
      'Empurrar de volta pro mar com o pé',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Mesmo fora da água, a água-viva pode queimar. É importante manter distância e avisar um adulto.',
  ),
  const QuizQuestion(
    question: 'O que você deve evitar fazer com o celular para não se queimar?',
    answers: [
      'Usar o celular com capinha',
      'Dormir com ele debaixo do travesseiro',
      'Usar fone de ouvido',
      'Carregar durante o dia',
    ],
    correctAnswerIndex: 1,
    explanation:
        'Celulares podem superaquecer. Dormir com eles debaixo do travesseiro aumenta o risco de queimaduras.',
  ),
  const QuizQuestion(
    question: 'O que ajuda a evitar queimaduras quando você anda de bicicleta?',
    answers: [
      'Andar descalço para sentir melhor o pedal',
      'Usar roupas leves e soltas',
      'Usar capacete e joelheiras',
      'Evitar andar em subidas',
    ],
    correctAnswerIndex: 2,
    explanation:
        'Equipamentos de proteção como capacete e joelheiras ajudam a evitar ferimentos e queimaduras em quedas.',
  ),
];
