import SwiftUI

struct MessagesView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        List {
            ForEach(appState.messages.sorted(by: { $0.updatedAt > $1.updatedAt })) { thread in
                NavigationLink(destination: MessageDetailView(thread: thread)) {
                    MessageRow(thread: thread)
                }
            }
        }
        .navigationTitle("Messages")
    }
}

struct MessageRow: View {
    let thread: MessageThread

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.accentColor.opacity(0.15))
                .frame(width: 44, height: 44)
                .overlay(Text(String(thread.participant.prefix(1))).fontWeight(.semibold))

            VStack(alignment: .leading, spacing: 6) {
                HStack { 
                    Text(thread.participant)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(Self.dateFormatter.string(from: thread.updatedAt))
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                HStack(alignment: .center, spacing: 8) {
                    Text(thread.preview)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                    if thread.unreadCount > 0 {
                        Text("\(thread.unreadCount)")
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 6)
                            .padding(.vertical, 4)
                            .background(Color.accentColor.opacity(0.2), in: Capsule())
                            .foregroundStyle(.accentColor)
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }
}

struct MessageDetailView: View {
    @EnvironmentObject private var appState: AppState
    let thread: MessageThread
    @State private var messageText: String = ""

    private var currentThread: MessageThread? {
        appState.messages.first(where: { $0.id == thread.id })
    }

    private var messages: [Message] {
        (currentThread?.messages ?? thread.messages).sorted(by: { $0.timestamp > $1.timestamp })
    }

    private let quickReplies = [
        "Thanks for the update!",
        "On our way now.",
        "Can we chat after pickup?"
    ]

    var body: some View {
        VStack(spacing: 0) {
            List { 
                ForEach(messages) { message in
                    MessageBubble(message: message)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)

            quickReplyBar
        }
        .navigationTitle(thread.participant)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            appState.markThreadAsRead(thread.id)
        }
    }

    private var quickReplyBar: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(quickReplies, id: \.self) { reply in
                        Button(reply) {
                            appState.sendQuickMessage(to: thread.id, content: reply)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.horizontal)
            }

            HStack(spacing: 12) {
                TextField("Send a message", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                Button {
                    guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
                    appState.sendQuickMessage(to: thread.id, content: messageText)
                    messageText = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
        }
        .background(.regularMaterial)
    }
}

struct MessageBubble: View {
    let message: Message

    private var bubbleColor: Color {
        message.isFromStaff ? .secondary.opacity(0.2) : Color.accentColor.opacity(0.25)
    }

    var body: some View {
        HStack {
            if message.isFromStaff {
                bubble
                Spacer()
            } else {
                Spacer()
                bubble
            }
        }
    }

    private var bubble: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(message.sender)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(message.content)
                .padding(10)
                .background(bubbleColor, in: RoundedRectangle(cornerRadius: 12))
        }
        .padding(.vertical, 6)
    }
}

#Preview {
    NavigationStack {
        MessagesView()
            .environmentObject(AppState())
    }
}
