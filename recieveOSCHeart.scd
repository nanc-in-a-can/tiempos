
// receiving the msg from processing.....
//OSCFunc.trace(true); // Turn posting on
//OSCFunc.trace(false); // Turn posting off



(
~netAddr2 = NetAddr("127.0.0.1", 13000);

// funciones necesarias
~startHeart= {
	var oldNum= 0.5;
	var num= 0;

	var o = OSCdef(\cora, { |msg, time, addr, recvPort| //[msg, time, addr, recvPort].postln;
		num= msg[1].linlin(0, 512*2, 0.00, 1.00);
		~heartBeat.(num, oldNum, 0.675);
		oldNum= num;

	},
	'/heart', n, 13000);
    o
};


~heartBeat= {|numero, numViejo, threshold|
    if( numero>=threshold,
			{
            if(numViejo>numero, {"GOT IT".postln;
                Synth(\bassHeart, [\out, [10,0]]);
            });

        },
        {"below threshold".postln} );
    ("oldNum now is"+numViejo.asString+"and num is"+numero.asString).postln;
};



~startHeartBeatMonitor = {
    ~verb= Synth(\verb, [\in, 10, \out, 0]);
    ~corazon= ~startHeart.();
};

~stopHeartBeatMonitor = {
    ~corazon.free;
    ~netAddr2.sendMsg("/heart", 0);
};
);