import 'package:flutter/material.dart';

class PreventionTip {
  final String title;
  final String description;
  final IconData icon;
  final String? whatToDo;
  final String? whatNotToDo;

  const PreventionTip({
    required this.title,
    required this.description,
    required this.icon,
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
    whatToDo: 'Peça ajuda a um adulto para mexer em panelas ou usar o fogão.',
    whatNotToDo: 'Nunca toque em panelas no fogão ou tente cozinhar sozinho.',
  ),
  const PreventionTip(
    title: 'Cuidado com Líquidos Quentes',
    description:
        'Líquidos quentes como água, chá, café e sopa podem causar queimaduras graves na pele.',
    icon: Icons.local_drink,
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
    whatToDo: 'Mantenha-se longe de tomadas e fios elétricos.',
    whatNotToDo:
        'Nunca coloque objetos metálicos em tomadas ou toque em fios desencapados.',
  ),
  const PreventionTip(
    title: 'Fogo e Fósforos',
    description:
        'Fogo, isqueiros e fósforos são muito perigosos e podem causar incêndios e queimaduras graves.',
    icon: Icons.local_fire_department,
    whatToDo: 'Avise um adulto se encontrar fósforos ou isqueiros.',
    whatNotToDo: 'Nunca brinque com fogo, fósforos ou isqueiros.',
  ),
  const PreventionTip(
    title: 'Sol e Queimaduras Solares',
    description:
        'O sol forte pode queimar a pele e causar danos a longo prazo.',
    icon: Icons.wb_sunny,
    whatToDo: 'Use protetor solar, chapéu e roupas que protejam do sol.',
    whatNotToDo:
        'Não fique exposto ao sol forte por muito tempo, especialmente entre 10h e 16h.',
  ),
  const PreventionTip(
    title: 'Produtos Químicos',
    description:
        'Produtos de limpeza, alvejantes e outros químicos podem causar queimaduras na pele.',
    icon: Icons.cleaning_services,
    whatToDo: 'Peça ajuda a um adulto para usar qualquer produto químico.',
    whatNotToDo:
        'Nunca toque, beba ou brinque com produtos de limpeza ou químicos.',
  ),
];
