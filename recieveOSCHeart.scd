// create the OSCFunc


(
//
(
~startHeart= {
	var oldNum= 0.5;
	var num= 0;

	o = OSCFunc({ |msg, time, addr, recvPort| //[msg, time, addr, recvPort].postln;
		num= msg[1].linlin(0, 512*2, 0.00, 1.00);
		~heartBeat.(num, oldNum, 0.675);
		oldNum= num;

	},
	'/heart', n, 12000)
}
);



(
~heartBeat= {|numero, numViejo, threshold|

		if( numero>=threshold,
			{
				if(numViejo>numero, {"GOT IT".postln;

				Synth(\drums, [\bufnum, ~drums.(\k1, \bass), \out, 10, \amp, 0.25]);


			});




			},
			{"below threshold".postln} );
		("oldNum now is"+numViejo.asString+"and num is"+numero.asString).postln;


	};
)
);

(
{Out.ar([0,2,4,6],GVerb.ar(In.ar(10,2),80, 10,0.5, mul:0.25))}.play;
);

OSCFunc.trace(true); // Turn posting on
OSCFunc.trace(false); // Turn posting off