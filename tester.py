from rabcorelib.pyriffle import FabricSession
from twisted.internet.defer import inlineCallbacks, returnValue

URL = u"ws://ubuntu@ec2-52-26-83-61.us-west-2.compute.amazonaws.com:8000/ws"


class Session(FabricSession):

    @inlineCallbacks
    def onJoin(self, details):
        print "Joined"

        yield self.absPublish('xs.demo.swiftbench/types', 1, 1.0, 1.0, "string", True)
        yield self.absPublish('xs.demo.swiftbench/collections', [1, 2], [1.0, 2.0], [1.0, 2.0], ["string", "yo"], [True, False])

        # Int, String, Bool = yield self.absCall('xs.demo.swiftbench/callTypes')
        # print "Int: %s, String: %s, Bool: %s" % (Int, String, Bool,)

        # This is a CallResult-- please return the actual arguments!
        print "Calling"
        result = yield self.absCall('xs.demo.swiftbench/callType')
        print result

        self.leave()

    def tick(self, ticker):
        print "Recieved tick: ", ticker

if __name__ == '__main__':
    Session.start(URL, "xs.demo.swiftbrutalizer", start_reactor=True)
