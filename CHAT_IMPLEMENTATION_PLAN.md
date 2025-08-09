# Plano Detalhado de Implementação - Sistema de Chat Uber Clone

## Visão Geral
Implementar um sistema de chat simples e funcional para comunicação entre passageiro e motorista durante viagens ativas, seguindo rigorosamente o Uber Base Design System e os componentes existentes.

## Arquitetura Proposta

```
lib/features/chat/
├── models/
│   ├── message_model.dart (já criado) ✓
│   ├── conversation_model.dart (a criar)
│   └── chat_user_model.dart (opcional)
├── services/
│   └── chat_service.dart
├── screens/
│   └── chat_screen.dart
├── widgets/
│   ├── message_bubble.dart (usando UberCard)
│   ├── chat_input.dart (usando UberInput + UberButton)
│   └── chat_header.dart (usando UberTypography)
└── providers/
    └── chat_provider.dart
```

## Modelos de Dados

### 1. ConversationModel (a criar)
```dart
class ConversationModel {
  final String id;
  final String tripId;
  final String passengerId;
  final String driverId;
  final List<MessageModel> messages;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Métodos de serialização
}
```

### 2. ChatService (mock)
- Gerenciar conversas em memória usando UberTokens para configurações
- Simular envio/recebimento de mensagens
- Fornecer stream de mensagens em tempo real
- Usar Duration do UberTokens para timeouts e delays

## Integração com Telas Existentes

### Telas que precisam de botão de chat:
1. **Passageiro - OnTripScreen** (`lib/features/passenger/screens/trip_flow/on_trip_screen.dart`) ✓
2. **Motorista - EnRouteToDestinationScreen** (`lib/features/driver/screens/trip_flow/en_route_to_destination_screen.dart`) ✓
3. **Passageiro - WaitingForDriverScreen** (`lib/features/passenger/screens/trip_flow/waiting_for_driver_screen.dart`)

### Design do Botão de Chat (Usando Padrão Existente)
```dart
buildActionButton(
  icon: Icons.chat_bubble_outline,
  label: 'Chat',
  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen())),
)
```
- **Componente**: Usar `buildActionButton` existente do `trip_flow_widgets.dart`
- **Ícone**: `Icons.chat_bubble_outline` (24px - `UberTokens.sizeIconMedium`)
- **Badge**: `UberCard` com `UberTokens.colorBlue500` para contador
- **Posição**: Integrado no painel inferior existente

## Fluxo de Implementação

### Fase 1: Estrutura Base (30 min)
1. Criar `conversation_model.dart`
2. Criar `chat_service.dart` com mock data
3. Criar `chat_provider.dart` para gerenciamento de estado

### Fase 2: UI Principal com Uber Components (45 min)
1. Criar `chat_screen.dart` usando `UberCard` para container principal
2. Criar `message_bubble.dart` com `UberCard` (elevated/outlined variants)
3. Criar `chat_input.dart` com `UberInput` + `UberButton` 
4. Adicionar navegação com animações do `UberTokens`

### Fase 3: Integração com Padrões Existentes (30 min)
1. Adicionar botões de chat usando `buildActionButton` existente
2. Conectar com ChatProvider seguindo padrão dos outros providers
3. Testar fluxo completo com navegação do Material

### Fase 4: Polimento com UberTokens (15 min)
1. Aplicar `UberTokens.durationMedium` para animações
2. Usar `UberTokens.shadowMedium` para elevações
3. Aplicar `UberTokens.spacing` para layout responsivo

## Decisões Técnicas

### Estado
- Usar ChangeNotifier seguindo padrão existente do codebase
- Armazenar conversas ativas em memória
- Limpar ao finalizar viagem usando lifecycle do Flutter

### Design (Uber Base Design System)
- **Cores**: `UberTokens.colorBackgroundPrimary`, `UberTokens.colorBlue500` (usuário), `UberTokens.colorGray100` (outro usuário)
- **Tipografia**: `UberTypography.bodyMedium` para mensagens, `UberTypography.labelSmall` para timestamps
- **Espaçamento**: `UberTokens.spacing300`, `UberTokens.spacing400` para padding
- **Bordas**: `UberTokens.borderRadius400` para bubbles, `UberTokens.borderRadius600` para input
- **Sombras**: `UberTokens.shadowSmall` para mensagens próprias
- **Componentes**: `UberCard`, `UberButton`, `UberInput`, `UberTypography`

### Performance
- Limitar histórico a 50 mensagens
- Scroll automático usando `ScrollController` com `UberTokens.durationMedium`
- Debounce no envio usando `UberTokens.durationFast` (150ms)

## Especificações de UI Detalhadas

### ChatScreen Layout
```dart
Scaffold(
  backgroundColor: UberTokens.colorBackgroundPrimary,
  appBar: AppBar(
    title: UberTypography.titleLarge('Nome do Motorista'),
    backgroundColor: UberTokens.colorBackgroundPrimary,
    elevation: 0,
  ),
  body: Column(
    children: [
      Expanded(child: MessagesList()), // ListView com UberCards
      ChatInput(), // UberInput + UberButton
    ],
  ),
)
```

### Message Bubble Variants
```dart
// Mensagem própria (direita)
UberCard(
  variant: UberCardVariant.filled,
  backgroundColor: UberTokens.colorBlue500,
  borderRadius: BorderRadius.circular(UberTokens.borderRadius400),
  margin: EdgeInsets.only(left: UberTokens.spacing800, right: UberTokens.spacing400),
)

// Mensagem do outro (esquerda) 
UberCard(
  variant: UberCardVariant.outlined,
  backgroundColor: UberTokens.colorGray100,
  borderRadius: BorderRadius.circular(UberTokens.borderRadius400),
  margin: EdgeInsets.only(left: UberTokens.spacing400, right: UberTokens.spacing800),
)
```

### Chat Input Component
```dart
Row(
  children: [
    Expanded(
      child: UberInput(
        placeholder: 'Digite uma mensagem...',
        borderRadius: UberTokens.borderRadius600,
      ),
    ),
    SizedBox(width: UberTokens.spacing200),
    UberButton(
      text: '',
      leading: Icon(Icons.send, size: UberTokens.sizeIconMedium),
      variant: UberButtonVariant.primary,
      size: UberButtonSize.medium,
      isFullWidth: false,
    ),
  ],
)
```

## Mock Data Inicial (Uber-Style)
```dart
// Conversa realista estilo Uber
ConversationModel(
  id: 'conv_001',
  tripId: 'trip_uber_123',
  passengerId: 'pass_001', 
  driverId: 'drv_mario_silva',
  messages: [
    MessageModel(
      id: 'msg_001',
      conversationId: 'conv_001',
      senderId: 'pass_001',
      receiverId: 'drv_mario_silva',
      content: 'Olá! Já estou no ponto de coleta 📍',
      type: MessageType.text,
      timestamp: DateTime.now().subtract(Duration(minutes: 3)),
      isFromCurrentUser: true,
    ),
    MessageModel(
      id: 'msg_002', 
      conversationId: 'conv_001',
      senderId: 'drv_mario_silva',
      receiverId: 'pass_001',
      content: 'Perfeito! Estou chegando em 2 minutos. Corolla prata ABC-1234',
      type: MessageType.text,
      timestamp: DateTime.now().subtract(Duration(minutes: 2)),
      isFromCurrentUser: false,
    ),
    MessageModel(
      id: 'msg_003',
      conversationId: 'conv_001',
      senderId: 'pass_001', 
      receiverId: 'drv_mario_silva',
      content: 'Ok, obrigado! 👍',
      type: MessageType.text,
      timestamp: DateTime.now().subtract(Duration(minutes: 1)),
      isFromCurrentUser: true,
    ),
  ],
)
```

## Próximos Passos
1. ✅ **CONCLUÍDO**: Alinhar plano com Uber Design System
2. Implementar `conversation_model.dart`
3. Criar `chat_service.dart` com mock data realista  
4. Desenvolver UI usando componentes Uber
5. Integrar botão de chat nas telas de trip flow
6. Testar fluxo completo com navegação