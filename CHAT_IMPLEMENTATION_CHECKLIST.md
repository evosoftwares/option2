# Checklist Detalhado - Implementação do Chat Uber Clone

## ✅ Status Atual
- [x] MessageModel criado (`lib/features/chat/models/message_model.dart`)
- [ ] ConversationModel pendente
- [ ] Estrutura de serviços pendente
- [ ] UI do chat pendente
- [ ] Integração com telas existentes pendente

## 📋 Arquivos a Criar (em ordem)

### 1. Models
- [ ] `lib/features/chat/models/conversation_model.dart`
- [ ] `lib/features/chat/models/chat_user_model.dart` (opcional)

### 2. Services
- [ ] `lib/features/chat/services/chat_service.dart`

### 3. Providers
- [ ] `lib/features/chat/providers/chat_provider.dart`

### 4. Screens
- [ ] `lib/features/chat/screens/chat_screen.dart`

### 5. Widgets
- [ ] `lib/features/chat/widgets/message_bubble.dart`
- [ ] `lib/features/chat/widgets/chat_input.dart`
- [ ] `lib/features/chat/widgets/chat_header.dart`

### 6. Integração
- [ ] Adicionar botão em `lib/features/passenger/screens/trip_flow/on_trip_screen.dart`
- [ ] Adicionar botão em `lib/features/driver/screens/trip_flow/en_route_to_destination_screen.dart`
- [ ] Adicionar botão em `lib/features/passenger/screens/trip_flow/waiting_for_driver_screen.dart`

## 🎯 MVP Definido
**Funcionalidades essenciais:**
- Chat de texto simples
- Disponível apenas durante viagem ativa
- Sem persistência (apenas memória)
- Sem histórico após viagem
- Sem notificações push

## 🔄 Fluxo de Uso
1. Passageiro inicia viagem
2. Botão de chat aparece na tela
3. Clica → abre chat com motorista
4. Troca mensagens em tempo real
5. Finaliza viagem → chat desaparece

## 📱 Design System
- Usar `UberTokens.primaryColor` para mensagens do usuário
- Usar `UberTokens.neutral200` para mensagens do outro
- Fonte: `UberTypography.bodyMedium`
- Espaçamento: 16px padrão
- Bordas arredondadas: 12px

## 🚀 Próximos Passos
1. Aprovar este checklist
2. Mudar para modo Code
3. Implementar arquivos na ordem listada
4. Testar integração
5. Ajustar conforme necessário

## ⏱️ Estimativa de Tempo
- Models: 15 min
- Services: 20 min
- UI Básica: 30 min
- Integração: 15 min
- **Total: ~1h20min**