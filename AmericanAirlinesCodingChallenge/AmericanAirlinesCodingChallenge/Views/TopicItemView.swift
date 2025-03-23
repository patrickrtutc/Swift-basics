import SwiftUI

struct TopicItemView: View {
    let title: String
    let url: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(url)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TopicItemView(
        title: "American Airlines Category",
        url: "https://duckduckgo.com/c/American_Airlines"
    )
} 