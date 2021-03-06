//  separate the creation and preparation of a message

protocol Message {
    init (message:String);
    func prepareMessage();
    var contentToSend:String { get };
}

class ClearMessage : Message {
    fileprivate var message:String;
    
    required init(message:String) {
        self.message = message;
    }
    
    func prepareMessage() {
        // no action required
    }
    
    var contentToSend:String {
        return message;
    }
}

class EncryptedMessage : Message {
    fileprivate var clearText:String;
    fileprivate var cipherText:String?;
    
    required init(message:String) {
        self.clearText = message;
    }
    
    func prepareMessage() {
//        cipherText = String(reverse(clearText));
		cipherText = String(clearText)
    }
    
    var contentToSend:String {
        return cipherText!;
    }
}
