import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectWebSockets

// Config Routes
var routes = Routes([
    Route(method: .get, uri: "/", handler: {(request, response) in
        response.setBody(string: "Hello, Tess!")
        response.completed()
    }),
    Route(method: .get, uri: "echo", handler: {(request, response) in
        WebSocketHandler(handlerProducer: {
            (request: HTTPRequest, protocols: [String]) -> WebSocketSessionHandler? in
            
            guard protocols.contains("echo") else{
                return nil
            }
            
            return EchoHandler()
            
        }).handleRequest(request: request, response: response)
        
    })
])

//func makeRoutes() -> Routes {
//    var routes = Routes()
//    routes.add(method: .get, uri: "*", handler: { (request, response) in
//        StaticFileHandler(documentRoot: request.documentRoot).handleRequest(request: request, response: response)
//        })
//
//
//    routes.add(method: .get, uri: "/echo", handler: {
//    })
//}



// Config Server
let server = HTTPServer()
server.documentRoot = "webroot"
server.serverPort = 8181
server.addRoutes(routes)


// Run Server
do {
    try server.start()
} catch PerfectError.networkError(let error, let message){
    print("Network error thrown: \(error) -> \(message)")
}
