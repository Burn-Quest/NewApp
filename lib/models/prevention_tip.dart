  import 'package:flutter/material.dart';

  class PreventionTip {
    final String title;
    final String description;
    final IconData icon;
    final String image;
    final String? whatToDo;
    final String? whatNotToDo;

    const PreventionTip({
      required this.title,
      required this.description,
      required this.icon,
      required this.image,
      this.whatToDo,
      this.whatNotToDo,
    });
  }

  final List<PreventionTip> preventionTips = [
    const PreventionTip(
      title: 'Cuidado com a Cozinha',
      description:
          'A cozinha é um dos lugares mais perigosos da casa quando se trata de queimaduras. Panelas quentes, água fervente e fogão podem causar acidentes graves.',
      icon: Icons.kitchen,
      image: 'assets/images/quiz/img1.png',
      whatToDo: 'Peça ajuda a um adulto para mexer em panelas ou usar o fogão.',
      whatNotToDo: 'Nunca toque em panelas no fogão ou tente cozinhar sozinho.',
    ),
    const PreventionTip(
      title: 'Cuidado com Líquidos Quentes',
      description:
          'Líquidos quentes como água, chá, café e sopa podem causar queimaduras graves na pele.',
      icon: Icons.local_drink,
      image: "assets/images/quiz/img2.png",
      whatToDo:
          'Peça ajuda para carregar bebidas quentes e tenha cuidado ao beber.',
      whatNotToDo:
          'Não corra ou brinque perto de pessoas segurando líquidos quentes.',
    ),
    const PreventionTip(
      title: 'Eletricidade',
      description:
          'A eletricidade pode causar queimaduras graves e até mesmo choques fatais.',
      icon: Icons.electrical_services,
      image: "assets/images/quiz/img3.png",
      whatToDo: 'Mantenha-se longe de tomadas e fios elétricos.',
      whatNotToDo:
          'Nunca coloque objetos metálicos em tomadas ou toque em fios desencapados.',
    ),
    const PreventionTip(
      title: 'Fogo e Fósforos',
      description:
          'Fogo, isqueiros e fósforos são muito perigosos e podem causar incêndios e queimaduras graves.',
      icon: Icons.local_fire_department,
      image: "assets/images/quiz/img4.png",
      whatToDo: 'Avise um adulto se encontrar fósforos ou isqueiros.',
      whatNotToDo: 'Nunca brinque com fogo, fósforos ou isqueiros.',
    ),
    const PreventionTip(
      title: 'Sol e Queimaduras Solares',
      description:
          'O sol forte pode queimar a pele e causar danos a longo prazo.',
      icon: Icons.wb_sunny,
      image: "assets/images/quiz/img5.png",
      whatToDo: 'Use protetor solar, chapéu e roupas que protejam do sol.',
      whatNotToDo:
          'Não fique exposto ao sol forte por muito tempo, especialmente entre 10h e 16h.',
    ),
    const PreventionTip(
      title: 'Produtos Químicos',
      description:
          'Produtos de limpeza, alvejantes e outros químicos podem causar queimaduras na pele.',
      icon: Icons.cleaning_services,
      image: "assets/images/quiz/img6.png",
      whatToDo: 'Peça ajuda a um adulto para usar qualquer produto químico.',
      whatNotToDo:
          'Nunca toque, beba ou brinque com produtos de limpeza ou químicos.',
    ),
    //news
    const PreventionTip(
      title: 'Insetos que Queimam',
      description:
          'Alguns insetos e lagartas podem causar queimaduras ou irritações graves na pele ao entrarem em contato com ela.',
      icon: Icons.bug_report,
      image: "assets/images/quiz/img7.png",
      whatToDo:
          'Use roupas protetoras ao entrar em áreas de mata ou jardins, e aplique repelente.',
      whatNotToDo:
          'Não toque em insetos desconhecidos, lagartas peludas ou ninhos. Evite andar descalço em áreas de risco.',
    ),
    const PreventionTip(
      title: 'Queimaduras por Água-Viva',
      description:
          'O contato com águas-vivas pode causar queimaduras dolorosas e irritações na pele devido às toxinas liberadas pelos tentáculos.',
      icon: Icons.water_damage,
      image: "assets/images/quiz/img8.png",
      whatToDo:
          'Fique atento a avisos de perigo na praia. Ao avistar águas-vivas na areia ou no mar, mantenha distância e avise outras pessoas.',
      whatNotToDo:
          'Não toque na água-viva, mesmo que esteja fora da água e aparentemente morta. Não esfregue a pele após o contato — isso espalha as toxinas.',
    ),
    const PreventionTip(
      title: 'Queimaduras por Equipamentos Eletrônicos',
      description:
          'Celulares, carregadores e outros eletrônicos podem superaquecer e causar queimaduras se usados ou carregados de forma inadequada.',
      icon: Icons.phone_iphone,
      image: "",
      whatToDo:
          'Use apenas carregadores originais e evite cobrir os aparelhos durante o uso ou carregamento. Faça pausas para resfriar o dispositivo.',
      whatNotToDo:
          'Não use o celular enquanto carrega na tomada por longos períodos. Não durma com o aparelho embaixo do travesseiro ou próximo ao corpo.',
    ),
    const PreventionTip(
      title: 'Queimaduras por Fricção',
      description:
          'Quedas no asfalto ou superfícies ásperas podem gerar queimaduras por atrito, especialmente em crianças ou ciclistas.',
      icon: Icons.directions_bike,
      image: "",
      whatToDo:
          'Use equipamentos de proteção como joelheiras e capacetes. Oriente sobre segurança no trânsito e brincadeiras.',
      whatNotToDo:
          'Não pratique esportes de velocidade sem proteção. Não ignore lesões leves — elas podem infeccionar.',
    ),
  ];
