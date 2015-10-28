from rabcorelib.pyriffle import FabricSession
from twisted.internet.defer import inlineCallbacks, returnValue

URL = u"ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"

class Session(FabricSession):
    def onJoin(self, details):
        print "Joined"

if __name__ == '__main__':
    Session.start()
    Session.start(URL, "xs.demo.swiftbrutalizer", start_reactor=True)