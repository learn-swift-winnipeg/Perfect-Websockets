//
//  EchoHandler.swift
//  PerfectLib
//
//  Created by Steven Prichard on 2017-08-13.
//

import Foundation
import PerfectHTTP
import PerfectWebSockets


class EchoHandler: WebSocketSessionHandler {
    var socketProtocol: String? = "echo"
    
    func handleSession(request: HTTPRequest, socket: WebSocket) {
        socket.readStringMessage{
            (message, op, finish) in
            guard let message = message else{
                socket.close()
                return
            }
            
            print("Read Message: \(message)")
            print("Status -> OP: \(op), Finished: \(finish)")
            
            socket.sendStringMessage(string: message, final: true){
                self.handleSession(request: request, socket: socket)
            }
        }
    }
}

