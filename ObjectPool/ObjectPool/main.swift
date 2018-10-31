import Foundation

var queue = DispatchQueue(label: "workQ", attributes: .concurrent);
var group = DispatchGroup();

print("Starting...");

for i in 1 ... 20 {
    queue.async(group: group, execute: {() in
        let book = Library.checkoutBook("reader#\(i)");
        if (book != nil) {
            Thread.sleep(forTimeInterval: Double(arc4random() % 2));
            Library.returnBook(book!);
        }
    });
}

let _ = group.wait(timeout: DispatchTime.distantFuture);

print("All blocks complete");

Library.printReport();
