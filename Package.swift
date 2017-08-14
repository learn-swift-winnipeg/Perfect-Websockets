// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "example.com",
    dependencies: [
	.Package(
		url:"https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
		majorVersion: 2		
		),
	.Package(url:"https://github.com/PerfectlySoft/Perfect-WebSockets.git", majorVersion: 2)
	]
)
