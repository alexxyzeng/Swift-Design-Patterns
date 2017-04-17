var comms = Communicator(channel: Channel.Channels.satellite);

comms.sendClearTextMessage("Hello!");
comms.sendSecureMessage("This is a secret");
comms.sendPriorityMessage("This is important");
