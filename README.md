# MediaPickerView

MediaPickerView is a SwiftUI view for MPMediaPickerController

# sample

```swift
struct ContentView: View {
    @State var mediaItemCollection: MPMediaItemCollection?
    @State var isShowMediaPicker: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            Button {
                self.isShowMediaPicker = true
            } label: {
                Text("Select Music")
            }
        }.fullScreenCover(isPresented: $isShowMediaPicker) {
        } content: {
            MediaPickerView(mediaTypes: .music,
                            config: MediaPickerView.Configuration(allowsPickingMultipleItems: true, showsCloudItems: true, showsItemsWithProtectedAssets: true),
                            onSelect: { mediaItemCollection in
                self.mediaItemCollection = mediaItemCollection
            }) {
            }
        }
    }
}
```

# License

MIT

