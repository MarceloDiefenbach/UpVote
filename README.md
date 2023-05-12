<h3 align="center">UpVote</h1>
<h4 align="center"> Know what your users want </h2>

UpVote allows you to knwo what features your users most want </b> <br/>
</p>

<h3>
	<b> Setup </b>
</h3>

1. Import our package in your Xcode project using Swift Package Manager
```
https://github.com/MarceloDiefenbach/UpVote.git
```

2. Import and configure it with your AppCode. You can find your AppCode in your dashboard on <a href="https://upvote.marcelodiefenbach.com.br/" target="_blank">UpVote site</a>
```swift
import UpVote

UpVoteConfig.shared.appcode("your-app-code")
UpVoteConfig.shared.userID("user-ID")
```

3. Done! Now you can just use in your app
```swift

// SwiftUI
struct ContentView: View {
    var body: some View {
        FeaturesList()
    }
}
```

<hr/>

<h3>
	<b> Design and labels configuration </b>
</h3>

UpVote allows you to change UI colors and texts.

<b>Primary Color</b>

```swift
UpVoteConfig.shared.primaryColor = Color.red
UpVoteConfig.shared.listTitle = "My list"
```

<hr/>

<h3>
	<b> Platforms </b>
</h3>

<ul>
	<li>iOS 15+</li>
</ul>

<hr/>
